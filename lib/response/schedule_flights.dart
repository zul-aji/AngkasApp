import 'package:hive_flutter/hive_flutter.dart';

part 'schedule_flights.g.dart';

@HiveType(typeId: 0)
class ScheduleFlights extends HiveObject {
  @HiveField(0)
  String? airlineIata;

  @HiveField(1)
  String? airlineIcao;

  @HiveField(2)
  String? flightIata;

  @HiveField(3)
  String? flightIcao;

  @HiveField(4)
  String? flightNumber;

  @HiveField(5)
  String? depIata;

  @HiveField(6)
  String? depIcao;

  @HiveField(7)
  String? depTerminal;

  @HiveField(8)
  String? depGate;

  @HiveField(9)
  String? depTime;

  @HiveField(10)
  String? depTimeUtc;

  @HiveField(11)
  String? arrIata;

  @HiveField(12)
  String? arrIcao;

  @HiveField(13)
  String? arrTerminal;

  @HiveField(14)
  String? arrGate;

  @HiveField(15)
  String? arrBaggage;

  @HiveField(16)
  String? arrTime;

  @HiveField(17)
  String? arrTimeUtc;

  @HiveField(18)
  String? csAirlineIata;

  @HiveField(19)
  String? csFlightNumber;

  @HiveField(20)
  String? csFlightIata;

  @HiveField(21)
  String? status;

  @HiveField(22)
  int? duration;

  @HiveField(23)
  int? delayed;

  @HiveField(24)
  int? depDelayed;

  @HiveField(25)
  int? arrDelayed;

  @HiveField(26)
  String? aircraftIcao;

  @HiveField(27)
  int? arrTimeTs;

  @HiveField(28)
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

  factory ScheduleFlights.fromJson(Map<String, dynamic> json) {
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
      // Add other columns based on ScheduleFlights fields
    };
  }

  factory ScheduleFlights.fromMap(Map<String, dynamic> map) {
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
