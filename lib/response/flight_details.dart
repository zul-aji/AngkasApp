import 'request_terms.dart';

class AirportSchedule {
  final Request request;
  final CurrentFlightDetails response;
  final String terms;

  AirportSchedule({
    required this.request,
    required this.response,
    required this.terms,
  });

  factory AirportSchedule.fromJson(Map<String, dynamic> json) {
    return AirportSchedule(
      request: Request.fromJson(json['request']),
      response: CurrentFlightDetails.fromJson(json['response']),
      terms: json['terms'],
    );
  }
}

class CurrentFlightDetails {
  final String? aircraftIcao;
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
  final String? depEstimated;
  final String? depActual;
  final String? depTimeUtc;
  final String? depEstimatedUtc;
  final String? depActualUtc;
  final int? depTimeTs;
  final String? arrIata;
  final String? arrIcao;
  final String? arrTerminal;
  final String? arrGate;
  final String? arrBaggage;
  final String? arrTime;
  final String? arrEstimated;
  final String? arrActual;
  final String? arrTimeUtc;
  final String? arrEstimatedUtc;
  final String? arrActualUtc;
  final int? arrTimeTs;
  final String? csAirlineIata;
  final String? csFlightNumber;
  final String? csFlightIata;
  final String? regNumber;
  final String? status;
  final int? duration;
  final int? delayed;
  final int? depDelayed;
  final int? arrDelayed;
  final int? updated;
  final String? depName;
  final String? depCity;
  final String? depCountry;
  final String? arrName;
  final String? arrCity;
  final String? arrCountry;
  final String? airlineName;
  final String? flag;
  final int? percent;
  final String? utc;

  CurrentFlightDetails({
    this.aircraftIcao,
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
    this.depEstimated,
    this.depActual,
    this.depTimeUtc,
    this.depEstimatedUtc,
    this.depActualUtc,
    this.depTimeTs,
    this.arrIata,
    this.arrIcao,
    this.arrTerminal,
    this.arrGate,
    this.arrBaggage,
    this.arrTime,
    this.arrEstimated,
    this.arrActual,
    this.arrTimeUtc,
    this.arrEstimatedUtc,
    this.arrActualUtc,
    this.arrTimeTs,
    this.csAirlineIata,
    this.csFlightNumber,
    this.csFlightIata,
    this.regNumber,
    this.status,
    this.duration,
    this.delayed,
    this.depDelayed,
    this.arrDelayed,
    this.updated,
    this.depName,
    this.depCity,
    this.depCountry,
    this.arrName,
    this.arrCity,
    this.arrCountry,
    this.airlineName,
    this.flag,
    this.percent,
    this.utc,
  });

  factory CurrentFlightDetails.fromJson(Map<String, dynamic> json) {
    return CurrentFlightDetails(
      aircraftIcao: json['aircraft_icao'],
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
      depEstimated: json['dep_estimated'],
      depActual: json['dep_actual'],
      depTimeUtc: json['dep_time_utc'],
      depEstimatedUtc: json['dep_estimated_utc'],
      depActualUtc: json['dep_actual_utc'],
      depTimeTs: json['dep_time_ts'],
      arrIata: json['arr_iata'],
      arrIcao: json['arr_icao'],
      arrTerminal: json['arr_terminal'],
      arrGate: json['arr_gate'],
      arrBaggage: json['arr_baggage'],
      arrTime: json['arr_time'],
      arrEstimated: json['arr_estimated'],
      arrActual: json['arr_actual'],
      arrTimeUtc: json['arr_time_utc'],
      arrEstimatedUtc: json['arr_estimated_utc'],
      arrActualUtc: json['arr_actual_utc'],
      arrTimeTs: json['arr_time_ts'],
      csAirlineIata: json['cs_airline_iata'],
      csFlightNumber: json['cs_flight_number'],
      csFlightIata: json['cs_flight_iata'],
      regNumber: json['reg_number'],
      status: json['status'],
      duration: json['duration'],
      delayed: json['delayed'],
      depDelayed: json['dep_delayed'],
      arrDelayed: json['arr_delayed'],
      updated: json['updated'],
      depName: json['dep_name'],
      depCity: json['dep_city'],
      depCountry: json['dep_country'],
      arrName: json['arr_name'],
      arrCity: json['arr_city'],
      arrCountry: json['arr_country'],
      airlineName: json['airline_name'],
      flag: json['flag'],
      percent: json['percent'],
      utc: json['utc'],
    );
  }
}
