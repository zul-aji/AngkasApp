import 'request_terms.dart';

class AirportSchedule {
  final Request request;
  final List<FlightDetails> response;
  final String terms;

  AirportSchedule({
    required this.request,
    required this.response,
    required this.terms,
  });

  factory AirportSchedule.fromJson(Map<String, dynamic> json) {
    return AirportSchedule(
      request: Request.fromJson(json['request']),
      response: List<FlightDetails>.from(
        json['response'].map((flight) => FlightDetails.fromJson(flight)),
      ),
      terms: json['terms'],
    );
  }
}

class FlightDetails {
  final String? airlineIata;
  final String? airlineIcao;
  final String? flightIata;
  final String? flightIcao;
  final String? flightNumber;
  final String? depIata;
  final String? depIcao;
  final String? depTerminal;
  final String? depGate;
  final String? depTime;
  final String? depTimeUtc;
  final String? arrIata;
  final String? arrIcao;
  final String? arrTerminal;
  final String? arrGate;
  final String? arrBaggage;
  final String? arrTime;
  final String? arrTimeUtc;
  final String? csAirlineIata;
  final String? csFlightNumber;
  final String? csFlightIata;
  final String? status;
  final int? duration;
  final int? delayed;
  final int? depDelayed;
  final int? arrDelayed;
  final String? aircraftIcao;
  final int? arrTimeTs;
  final int? depTimeTs;

  FlightDetails({
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

  factory FlightDetails.fromJson(Map<String, dynamic> json) {
    return FlightDetails(
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
}