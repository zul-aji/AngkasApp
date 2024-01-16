import 'request_terms.dart';

class CurrentFlightDetails {
  final Request request;
  final FlightDetails response;
  final String terms;

  CurrentFlightDetails({
    required this.request,
    required this.response,
    required this.terms,
  });

  factory CurrentFlightDetails.fromJson(Map<String, dynamic> json) {
    return CurrentFlightDetails(
      request: Request.fromJson(json['request']),
      response: FlightDetails.fromJson(json['response']),
      terms: json['terms'],
    );
  }
}

class FlightDetails {
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

  FlightDetails({
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

  factory FlightDetails.fromJson(Map<String, dynamic> json) {
    return FlightDetails(
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

  Map<String, dynamic> toJson() {
    return {
      'aircraft_icao': aircraftIcao,
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
      'dep_estimated': depEstimated,
      'dep_actual': depActual,
      'dep_time_utc': depTimeUtc,
      'dep_estimated_utc': depEstimatedUtc,
      'dep_actual_utc': depActualUtc,
      'dep_time_ts': depTimeTs,
      'arr_iata': arrIata,
      'arr_icao': arrIcao,
      'arr_terminal': arrTerminal,
      'arr_gate': arrGate,
      'arr_baggage': arrBaggage,
      'arr_time': arrTime,
      'arr_estimated': arrEstimated,
      'arr_actual': arrActual,
      'arr_time_utc': arrTimeUtc,
      'arr_estimated_utc': arrEstimatedUtc,
      'arr_actual_utc': arrActualUtc,
      'arr_time_ts': arrTimeTs,
      'cs_airline_iata': csAirlineIata,
      'cs_flight_number': csFlightNumber,
      'cs_flight_iata': csFlightIata,
      'reg_number': regNumber,
      'status': status,
      'duration': duration,
      'delayed': delayed,
      'dep_delayed': depDelayed,
      'arr_delayed': arrDelayed,
      'updated': updated,
      'dep_name': depName,
      'dep_city': depCity,
      'dep_country': depCountry,
      'arr_name': arrName,
      'arr_city': arrCity,
      'arr_country': arrCountry,
      'airline_name': airlineName,
      'flag': flag,
      'percent': percent,
      'utc': utc,
    };
  }

  factory FlightDetails.fromMap(Map<dynamic, dynamic> map) {
    return FlightDetails(
      aircraftIcao: map['aircraft_icao'],
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
      depEstimated: map['dep_estimated'],
      depActual: map['dep_actual'],
      depTimeUtc: map['dep_time_utc'],
      depEstimatedUtc: map['dep_estimated_utc'],
      depActualUtc: map['dep_actual_utc'],
      depTimeTs: map['dep_time_ts'],
      arrIata: map['arr_iata'],
      arrIcao: map['arr_icao'],
      arrTerminal: map['arr_terminal'],
      arrGate: map['arr_gate'],
      arrBaggage: map['arr_baggage'],
      arrTime: map['arr_time'],
      arrEstimated: map['arr_estimated'],
      arrActual: map['arr_actual'],
      arrTimeUtc: map['arr_time_utc'],
      arrEstimatedUtc: map['arr_estimated_utc'],
      arrActualUtc: map['arr_actual_utc'],
      arrTimeTs: map['arr_time_ts'],
      csAirlineIata: map['cs_airline_iata'],
      csFlightNumber: map['cs_flight_number'],
      csFlightIata: map['cs_flight_iata'],
      regNumber: map['reg_number'],
      status: map['status'],
      duration: map['duration'],
      delayed: map['delayed'],
      depDelayed: map['dep_delayed'],
      arrDelayed: map['arr_delayed'],
      updated: map['updated'],
      depName: map['dep_name'],
      depCity: map['dep_city'],
      depCountry: map['dep_country'],
      arrName: map['arr_name'],
      arrCity: map['arr_city'],
      arrCountry: map['arr_country'],
      airlineName: map['airline_name'],
      flag: map['flag'],
      percent: map['percent'],
      utc: map['utc'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'aircraft_icao': aircraftIcao,
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
      'dep_estimated': depEstimated,
      'dep_actual': depActual,
      'dep_time_utc': depTimeUtc,
      'dep_estimated_utc': depEstimatedUtc,
      'dep_actual_utc': depActualUtc,
      'dep_time_ts': depTimeTs,
      'arr_iata': arrIata,
      'arr_icao': arrIcao,
      'arr_terminal': arrTerminal,
      'arr_gate': arrGate,
      'arr_baggage': arrBaggage,
      'arr_time': arrTime,
      'arr_estimated': arrEstimated,
      'arr_actual': arrActual,
      'arr_time_utc': arrTimeUtc,
      'arr_estimated_utc': arrEstimatedUtc,
      'arr_actual_utc': arrActualUtc,
      'arr_time_ts': arrTimeTs,
      'cs_airline_iata': csAirlineIata,
      'cs_flight_number': csFlightNumber,
      'cs_flight_iata': csFlightIata,
      'reg_number': regNumber,
      'status': status,
      'duration': duration,
      'delayed': delayed,
      'dep_delayed': depDelayed,
      'arr_delayed': arrDelayed,
      'updated': updated,
      'dep_name': depName,
      'dep_city': depCity,
      'dep_country': depCountry,
      'arr_name': arrName,
      'arr_city': arrCity,
      'arr_country': arrCountry,
      'airline_name': airlineName,
      'flag': flag,
      'percent': percent,
      'utc': utc,
    };
  }
}
