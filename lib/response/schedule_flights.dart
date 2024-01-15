import 'package:hive_flutter/hive_flutter.dart';

class ScheduleFlights extends HiveObject {
  String? airlineIata;
  String? airlineIcao;
  String? flightIata;
  String? flightIcao;
  String? flightNumber;
  String? depIata;
  String? depIcao;
  String? depTerminal;
  String? depGate;
  String? depTime;
  String? depTimeUtc;
  String? arrIata;
  String? arrIcao;
  String? arrTerminal;
  String? arrGate;
  String? arrBaggage;
  String? arrTime;
  String? arrTimeUtc;
  String? csAirlineIata;
  String? csFlightNumber;
  String? csFlightIata;
  String? status;
  int? duration;
  int? delayed;
  int? depDelayed;
  int? arrDelayed;
  String? aircraftIcao;
  int? arrTimeTs;
  int? depTimeTs;

  ScheduleFlights({
    this.airlineIata,
    this.airlineIcao,
    this.flightIata,
    this.flightIcao,
    this.flightNumber,
    this.depIata,
    this.depIcao,
    this.depTerminal,
    this.depGate,
    this.depTime,
    this.depTimeUtc,
    this.arrIata,
    this.arrIcao,
    this.arrTerminal,
    this.arrGate,
    this.arrBaggage,
    this.arrTime,
    this.arrTimeUtc,
    this.csAirlineIata,
    this.csFlightNumber,
    this.csFlightIata,
    this.status,
    this.duration,
    this.delayed,
    this.depDelayed,
    this.arrDelayed,
    this.aircraftIcao,
    this.arrTimeTs,
    this.depTimeTs,
  });

  factory ScheduleFlights.fromJson(Map<dynamic, dynamic> json) {
    return ScheduleFlights(
      airlineIata: json['airline_iata'],
      airlineIcao: json['airline_icao'],
      flightIata: json['flight_iata'],
      flightIcao: json['flight_icao'],
      flightNumber: json['flight_number'],
      depIata: json['dep_iata'],
      depIcao: json['dep_icao'],
      depTerminal: json['dep_terminal'],
      depGate: json['dep_gate'],
      depTime: json['dep_time'],
      depTimeUtc: json['dep_time_utc'],
      arrIata: json['arr_iata'],
      arrIcao: json['arr_icao'],
      arrTerminal: json['arr_terminal'],
      arrGate: json['arr_gate'],
      arrBaggage: json['arr_baggage'],
      arrTime: json['arr_time'],
      arrTimeUtc: json['arr_time_utc'],
      csAirlineIata: json['cs_airline_iata'],
      csFlightNumber: json['cs_flight_number'],
      csFlightIata: json['cs_flight_iata'],
      status: json['status'],
      duration: json['duration'],
      delayed: json['delayed'],
      depDelayed: json['dep_delayed'],
      arrDelayed: json['arr_delayed'],
      aircraftIcao: json['aircraft_icao'],
      arrTimeTs: json['arr_time_ts'],
      depTimeTs: json['dep_time_ts'],
    );
  }

  set aircraftIata(aircraftIata) {}

  Map<String, dynamic> toJson() {
    return {
      'airline_iata': airlineIata,
      'airline_icao': airlineIcao,
      'flight_iata': flightIata,
      'flight_icao': flightIcao,
      'flight_number': flightNumber,
      'dep_iata': depIata,
      'dep_icao': depIcao,
      'dep_terminal': depTerminal,
      'dep_gate': depGate,
      'dep_time': depTime,
      'dep_time_utc': depTimeUtc,
      'arr_iata': arrIata,
      'arr_icao': arrIcao,
      'arr_terminal': arrTerminal,
      'arr_gate': arrGate,
      'arr_baggage': arrBaggage,
      'arr_time': arrTime,
      'arr_time_utc': arrTimeUtc,
      'cs_airline_iata': csAirlineIata,
      'cs_flight_number': csFlightNumber,
      'cs_flight_iata': csFlightIata,
      'status': status,
      'duration': duration,
      'delayed': delayed,
      'dep_delayed': depDelayed,
      'arr_delayed': arrDelayed,
      'aircraft_icao': aircraftIcao,
      'arr_time_ts': arrTimeTs,
      'dep_time_ts': depTimeTs,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'airline_iata': airlineIata,
      'airline_icao': airlineIcao,
      'flight_iata': flightIata,
      'flight_icao': flightIcao,
      'flight_number': flightNumber,
      'dep_iata': depIata,
      'dep_icao': depIcao,
      'dep_terminal': depTerminal,
      'dep_gate': depGate,
      'dep_time': depTime,
      'dep_time_utc': depTimeUtc,
      'arr_iata': arrIata,
      'arr_icao': arrIcao,
      'arr_terminal': arrTerminal,
      'arr_gate': arrGate,
      'arr_baggage': arrBaggage,
      'arr_time': arrTime,
      'arr_time_utc': arrTimeUtc,
      'cs_airline_iata': csAirlineIata,
      'cs_flight_number': csFlightNumber,
      'cs_flight_iata': csFlightIata,
      'status': status,
      'duration': duration,
      'delayed': delayed,
      'dep_delayed': depDelayed,
      'arr_delayed': arrDelayed,
      'aircraft_icao': aircraftIcao,
      'arr_time_ts': arrTimeTs,
      'dep_time_ts': depTimeTs,
    };
  }

  factory ScheduleFlights.fromMap(Map<dynamic, dynamic> map) {
    return ScheduleFlights(
      airlineIata: map['airline_iata'],
      airlineIcao: map['airline_icao'],
      flightIata: map['flight_iata'],
      flightIcao: map['flight_icao'],
      flightNumber: map['flight_number'],
      depIata: map['dep_iata'],
      depIcao: map['dep_icao'],
      depTerminal: map['dep_terminal'],
      depGate: map['dep_gate'],
      depTime: map['dep_time'],
      depTimeUtc: map['dep_time_utc'],
      arrIata: map['arr_iata'],
      arrIcao: map['arr_icao'],
      arrTerminal: map['arr_terminal'],
      arrGate: map['arr_gate'],
      arrBaggage: map['arr_baggage'],
      arrTime: map['arr_time'],
      arrTimeUtc: map['arr_time_utc'],
      csAirlineIata: map['cs_airline_iata'],
      csFlightNumber: map['cs_flight_number'],
      csFlightIata: map['cs_flight_iata'],
      status: map['status'],
      duration: map['duration'],
      delayed: map['delayed'],
      depDelayed: map['dep_delayed'],
      arrDelayed: map['arr_delayed'],
      aircraftIcao: map['aircraft_icao'],
      arrTimeTs: map['arr_time_ts'],
      depTimeTs: map['dep_time_ts'],
    );
  }
}
