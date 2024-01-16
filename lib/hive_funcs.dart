import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'response/schedule_flights.dart';
import 'local_notifications.dart';

late Box arrBox;
late Box depBox;

class HiveFuncs {
  static Future<void> saveReminder(
      String flightIata, bool isArr, ScheduleFlights flightDetails) async {
    final box = isArr ? arrBox : depBox;

    final details = {'details': flightDetails.toMap()};

    print(details.toString());
    await box.add(details);
    Fluttertoast.showToast(
      msg: isArr
          ? 'Flight is added to notification list, You will be notified near flight arrival'
          : 'Flight is added to notification list, You will be notified near flight departure',
    );
  }

// Retrieve non-expired flight details from local storage using Hive
  static List<ScheduleFlights> getReminders(bool isArr) {
    final box = isArr ? arrBox : depBox;

    // Get all entries in the box
    final allEntries = box.values.toList();

    // Map the details and create ScheduleFlights objects
    final flightDetailsList = allEntries
        .map((entry) => ScheduleFlights.fromMap(entry['details']))
        .toList();

    // Find indices of expired entries
    final indicesToDelete = <int>[];
    for (int i = 0; i < flightDetailsList.length; i++) {
      DateTime expirationArrTime =
          stringToDateTime(flightDetailsList[i].arrTime ?? "[Unavailable]");
      DateTime expirationDepTime =
          stringToDateTime(flightDetailsList[i].depTime ?? "[Unavailable]");
      bool isExpired = isArr
          ? expirationArrTime
              .isBefore(DateTime.now().add(const Duration(minutes: 10)))
          : expirationDepTime
              .isBefore(DateTime.now().add(const Duration(minutes: 10)));
      if (isExpired) {
        indicesToDelete.add(i);
      }
    }

    // Delete expired entries from the Hive box
    for (int index in indicesToDelete) {
      if (index >= 0 && index < allEntries.length) {
        box.deleteAt(index);
      }
    }

    // Filter out expired entries
    final nonExpiredEntries = flightDetailsList.where((entry) {
      DateTime expirationArrTime =
          stringToDateTime(entry.arrTime ?? "[Unavailable]");
      DateTime expirationDepTime =
          stringToDateTime(entry.depTime ?? "[Unavailable]");
      return isArr
          ? expirationArrTime
              .isAfter(DateTime.now().add(const Duration(minutes: 10)))
          : expirationDepTime
              .isAfter(DateTime.now().add(const Duration(minutes: 10)));
    }).toList();

    return nonExpiredEntries;
  }

  static bool checkCurrentFlight(String flightIata, bool isArr) {
    final box = isArr ? arrBox : depBox;

    // Get all entries in the box
    final allEntries = box.values.toList();

    // Check if flightIata is present in any of the entries
    return allEntries.any((entry) {
      final details = entry['details'];
      final scheduleFlight = ScheduleFlights.fromMap(details);

      // Assuming flightIata is a property in ScheduleFlights class
      return scheduleFlight.flightIata == flightIata;
    });
  }

// Delete a specific flight detail from local storage using Hive
  static Future<void> deleteReminder(String flightIata, bool isArr) async {
    final box = await Hive.openBox<ScheduleFlights>(
        isArr ? 'arrivalFlightBox' : 'departureFlightBox');

    // Find the index of the flight detail with the specified flightIata
    final index = box.values.toList().indexWhere((flight) =>
        flight.flightIata != null && flight.flightIata == flightIata);

    // If found, delete the flight detail at the specified index
    if (index != -1) {
      await box.deleteAt(index);
    }
  }

// Delete all flight details from local storage using Hive
  static Future<void> deleteAllReminder(bool isArr) async {
    final box = await Hive.openBox<ScheduleFlights>(
        isArr ? 'arrivalFlightBox' : 'departureFlightBox');
    await box.clear();
  }
}
