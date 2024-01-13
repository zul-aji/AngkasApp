// Save flight details to local storage using Hive with an expiration time
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_ui/boxes_list.dart';

import 'response/airport_schedule.dart';
import 'response/schedule_flights.dart';
import 'local_notifications.dart';

late Box arrBox;
late Box depBox;

Future<void> saveReminder(ScheduleFlights scheduleFlights, bool isArr) async {
  final box = isArr ? arrBox : depBox;
  DateTime expireDateTime = stringToDateTime(isArr
      ? scheduleFlights.arrTime ?? '[Unavailable]'
      : scheduleFlights.depTime ?? '[Unavailable]');

  // Store the flight details along with the expiration time
  final expirationTime =
      expireDateTime.add(const Duration(minutes: 10)).millisecondsSinceEpoch;

  var scheduleFlightsList = ScheduleFlights()
    ..aircraftIata = scheduleFlights.airlineIata
    ..aircraftIcao = scheduleFlights.airlineIcao
    ..flightIata = scheduleFlights.flightIata
    ..flightIcao = scheduleFlights.flightIcao
    ..flightNumber = scheduleFlights.flightNumber
    ..depIata = scheduleFlights.depIata
    ..depIcao = scheduleFlights.depIcao
    ..depTerminal = scheduleFlights.depTerminal
    ..depGate = scheduleFlights.depGate
    ..depTime = scheduleFlights.depTime
    ..depTimeUtc = scheduleFlights.depTimeUtc
    ..arrIata = scheduleFlights.arrIata
    ..arrIcao = scheduleFlights.arrIcao
    ..arrTerminal = scheduleFlights.arrTerminal
    ..arrGate = scheduleFlights.arrGate
    ..arrBaggage = scheduleFlights.arrBaggage
    ..arrTime = scheduleFlights.arrTime
    ..arrTimeUtc = scheduleFlights.arrTimeUtc
    ..csAirlineIata = scheduleFlights.csAirlineIata
    ..csFlightNumber = scheduleFlights.csFlightNumber
    ..csFlightIata = scheduleFlights.csFlightIata
    ..status = scheduleFlights.status
    ..duration = scheduleFlights.duration
    ..delayed = scheduleFlights.delayed
    ..depDelayed = scheduleFlights.depDelayed
    ..arrDelayed = scheduleFlights.arrDelayed
    ..aircraftIcao = scheduleFlights.aircraftIcao
    ..arrTimeTs = scheduleFlights.arrTimeTs
    ..depTimeTs = scheduleFlights.depTimeTs;

  print(scheduleFlightsList.toString());
  await box.add(scheduleFlightsList);
  await box.add(expirationTime);
}

// Retrieve non-expired flight details from local storage using Hive
Future<List<ScheduleFlights>> getReminders(bool isArr) async {
  final box = isArr ? arrBox : depBox;

  // Get the current time
  final currentTime = DateTime.now();

  // Get all entries in the box
  final allEntries = await box.get('');
  print(allEntries);

  // Filter out entries that have expired
  final validEntries = <ScheduleFlights>[];
  for (var entry in allEntries) {
    // final expirationTime = DateTime.parse(entry['expirationTime']);
    // if (expirationTime.isAfter(currentTime)) {
    // Entry is still valid, add to the list
    final detailsMap = entry['details'];
    final scheduleFlights = ScheduleFlights.fromJson(detailsMap);
    validEntries.add(scheduleFlights);
    //   } else {
    //     // Entry has expired, remove it from the box
    //     await box.delete(entry.key);
    //   }
  }

  return validEntries;
}

Future<List<ScheduleFlights>> getReminder(bool isArr) async {
  final box = await Hive.openBox<Map>(
      isArr ? 'arrivalFlightBox' : 'departureFlightBox');
  final currentTime = DateTime.now();

  final nonExpiredDetails = box.values.where((dynamic details) {
    if (details is Map<String, dynamic>) {
      final expirationTime = details['expirationTime'] as DateTime;
      return expirationTime.isAfter(currentTime);
    }
    return false;
  }).toList();

  // Convert the Map data back to FlightDetails
  final flightDetailsList =
      nonExpiredDetails.map<ScheduleFlights>((dynamic details) {
    if (details is Map<String, dynamic>) {
      return ScheduleFlights.fromJson(
          details['details'] as Map<String, dynamic>);
    }
    throw Exception('Unexpected type encountered when processing reminders.');
  }).toList();

  return flightDetailsList;
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
