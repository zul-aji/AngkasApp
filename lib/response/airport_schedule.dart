import 'package:hive/hive.dart';

import 'request_terms.dart';
import 'schedule_flights.dart';

class AirportSchedule extends HiveObject {
  final Request request;
  final List<ScheduleFlights> response;
  final String terms;

  AirportSchedule({
    required this.request,
    required this.response,
    required this.terms,
  });

  factory AirportSchedule.fromJson(Map<String, dynamic> json) {
    return AirportSchedule(
      request: Request.fromJson(json['request']),
      response: List<ScheduleFlights>.from(
        json['response'].map((flight) => ScheduleFlights.fromJson(flight)),
      ),
      terms: json['terms'],
    );
  }
}
