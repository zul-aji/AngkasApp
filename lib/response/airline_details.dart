import 'request_terms.dart';

class AirlineResponse {
  final Request request;
  final List<AirlineDetails> response;
  final String terms;

  AirlineResponse({
    required this.request,
    required this.response,
    required this.terms,
  });

  factory AirlineResponse.fromJson(Map<String, dynamic> json) {
    return AirlineResponse(
      request: Request.fromJson(json['request']),
      response: List<AirlineDetails>.from(
        json['response'].map((flight) => AirlineDetails.fromJson(flight)),
      ),
      terms: json['terms'],
    );
  }
}

class AirlineDetails {
  final String? name;
  final int? iataCode;
  final String? icaoCode;

  AirlineDetails({
    this.name,
    this.iataCode,
    this.icaoCode,
  });

  factory AirlineDetails.fromJson(Map<String, dynamic> json) {
    return AirlineDetails(
      name: json['name'],
      iataCode: json['iata_code'],
      icaoCode: json['icao_code'],
    );
  }
}
