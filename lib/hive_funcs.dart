// Save flight details to local storage using Hive with an expiration time
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'response/schedule_flights.dart';
import 'local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

late Box arrBox;
late Box depBox;

Future<void> saveReminder(ScheduleFlights scheduleFlights, bool isArr) async {
  final box = isArr ? arrBox : depBox;
  DateTime expireDateTime = stringToDateTime(isArr
      ? scheduleFlights.arrTime ?? '[Unavailable]'
      : scheduleFlights.depTime ?? '[Unavailable]');

  final details = {'details': scheduleFlights.toMap()};

  // var scheduleFlightsList = ScheduleFlights()
  //   ..aircraftIata = scheduleFlights.airlineIata
  //   ..aircraftIcao = scheduleFlights.airlineIcao
  //   ..flightIata = scheduleFlights.flightIata
  //   ..flightIcao = scheduleFlights.flightIcao
  //   ..flightNumber = scheduleFlights.flightNumber
  //   ..depIata = scheduleFlights.depIata
  //   ..depIcao = scheduleFlights.depIcao
  //   ..depTerminal = scheduleFlights.depTerminal
  //   ..depGate = scheduleFlights.depGate
  //   ..depTime = scheduleFlights.depTime
  //   ..depTimeUtc = scheduleFlights.depTimeUtc
  //   ..arrIata = scheduleFlights.arrIata
  //   ..arrIcao = scheduleFlights.arrIcao
  //   ..arrTerminal = scheduleFlights.arrTerminal
  //   ..arrGate = scheduleFlights.arrGate
  //   ..arrBaggage = scheduleFlights.arrBaggage
  //   ..arrTime = scheduleFlights.arrTime
  //   ..arrTimeUtc = scheduleFlights.arrTimeUtc
  //   ..csAirlineIata = scheduleFlights.csAirlineIata
  //   ..csFlightNumber = scheduleFlights.csFlightNumber
  //   ..csFlightIata = scheduleFlights.csFlightIata
  //   ..status = scheduleFlights.status
  //   ..duration = scheduleFlights.duration
  //   ..delayed = scheduleFlights.delayed
  //   ..depDelayed = scheduleFlights.depDelayed
  //   ..arrDelayed = scheduleFlights.arrDelayed
  //   ..aircraftIcao = scheduleFlights.aircraftIcao
  //   ..arrTimeTs = scheduleFlights.arrTimeTs
  //   ..depTimeTs = scheduleFlights.depTimeTs;

  print(details.toString());
  await box.add(details);
  Fluttertoast.showToast(
    msg: isArr
        ? 'Flight is added to notification list, You will be notified near flight arrival'
        : 'Flight is added to notification list, You will be notified near flight departure',
  );
}

// Retrieve non-expired flight details from local storage using Hive
List<ScheduleFlights> getReminders(bool isArr) {
  final box = isArr ? arrBox : depBox;

  // Get all entries in the box
  final allEntries = box.values.toList();

  // Map the details and create ScheduleFlights objects
  final scheduleFlightsList = allEntries
      .map((entry) => ScheduleFlights.fromMap(entry['details']))
      .toList();

  // Filter out expired entries
  final nonExpiredEntries = scheduleFlightsList.where((entry) {
    DateTime expirationTime =
        stringToDateTime(entry.arrTime ?? '[Unavailable]');
    bool isExpired =
        expirationTime.isBefore(DateTime.now().add(Duration(minutes: 10)));
    if (isExpired) {
      // Delete the expired entry from the Hive box
      box.deleteAt(allEntries.indexOf(entry));
    }
    return !isExpired;
  }).toList();

  return nonExpiredEntries;
}

bool checkCurrentFlight(String flightIata, bool isArr) {
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
Future<void> deleteReminder(String flightIata, bool isArr) async {
  final box = await Hive.openBox<ScheduleFlights>(
      isArr ? 'arrivalFlightBox' : 'departureFlightBox');

  // Find the index of the flight detail with the specified flightIata
  final index = box.values.toList().indexWhere(
      (flight) => flight.flightIata != null && flight.flightIata == flightIata);

  // If found, delete the flight detail at the specified index
  if (index != -1) {
    await box.deleteAt(index);
  }
}

// Delete all flight details from local storage using Hive
Future<void> deleteAllReminder(bool isArr) async {
  final box = await Hive.openBox<ScheduleFlights>(
      isArr ? 'arrivalFlightBox' : 'departureFlightBox');
  await box.clear();
}
