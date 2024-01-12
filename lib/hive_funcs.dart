// Save flight details to local storage using Hive with an expiration time
import 'package:hive/hive.dart';

import 'response/airport_schedule.dart';
import 'util_funcs.dart';

Future<void> saveReminder(FlightDetails flightDetails, bool isArr) async {
  DateTime expireDateTime = stringToDateTime(isArr
      ? flightDetails.arrTime ?? '[Unavailable]'
      : flightDetails.depTime ?? '[Unavailable]');
  final box = await Hive.openBox<Map>(
      isArr ? 'arrivalFlightBox' : 'departureFlightBox');

  // Store the flight details along with the expiration time
  final expirationTime = expireDateTime.add(const Duration(minutes: 10));
  final detailsWithExpiration = {
    'details': flightDetails.toJson(), // Convert FlightDetails to Map
    'expirationTime': expirationTime,
  };

  await box.add(detailsWithExpiration);
}

// Retrieve non-expired flight details from local storage using Hive
Future<List<FlightDetails>> getReminders(bool isArr) async {
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
      nonExpiredDetails.map<FlightDetails>((dynamic details) {
    if (details is Map<String, dynamic>) {
      return FlightDetails.fromJson(details['details'] as Map<String, dynamic>);
    }
    throw Exception('Unexpected type encountered when processing reminders.');
  }).toList();

  return flightDetailsList;
}

// Delete a specific flight detail from local storage using Hive
Future<void> deleteReminder(String flightIata, bool isArr) async {
  final box = await Hive.openBox<FlightDetails>(
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
  final box = await Hive.openBox<FlightDetails>(
      isArr ? 'arrivalFlightBox' : 'departureFlightBox');
  await box.clear();
}
