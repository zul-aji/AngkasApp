import 'dart:convert';
import 'package:http/http.dart' as http;
import '../const.dart';
import '../response/airline_details.dart';
import '../response/airport_schedule.dart';
import '../response/flight_details.dart';

class API {
  static Future<List<FlightDetails>?> getArrDep(bool isArr) async {
    List<FlightDetails>? flightDetails;
    String isDep = isArr ? 'arr_iata' : 'dep_iata';

    final Uri url = Uri.parse('${Const.baseAirlabsURL}/schedules');

    final Map<String, String> queryParams = {
      'api_key': Const.apiKey,
      isDep: 'CGK',
    };

    final Uri requestUrl = url.replace(queryParameters: queryParams);
    final response = await http.get(requestUrl);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> responseList = data['response'];
      flightDetails = responseList
          .map((flightJson) => FlightDetails.fromJson(flightJson))
          .toList();

      return flightDetails;
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<List<AirlineDetails>?> getAirlineDetail(String iataCode) async {
    List<AirlineDetails>? airlineDetails;

    final Uri url = Uri.parse('${Const.baseAirlabsURL}/airlines');

    final Map<String, String> queryParams = {
      'api_key': Const.apiKey,
      'iata_code': iataCode,
    };

    final Uri requestUrl = url.replace(queryParameters: queryParams);
    final response = await http.get(requestUrl);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> responseList = data['response'];
      airlineDetails = responseList
          .map((flightJson) => AirlineDetails.fromJson(flightJson))
          .toList();

      return airlineDetails;
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<CurrentFlightDetails?> getFlightDetail(
      String flightIata) async {
    CurrentFlightDetails? currentFlightDetails;

    final Uri url = Uri.parse('${Const.baseAirlabsURL}/flight');

    final Map<String, String> queryParams = {
      'api_key': Const.apiKey,
      'flight_iata': flightIata,
    };

    final Uri requestUrl = url.replace(queryParameters: queryParams);
    final response = await http.get(requestUrl);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final Map<String, dynamic> responseData = data['response'];
      currentFlightDetails = CurrentFlightDetails.fromJson(responseData);

      return currentFlightDetails;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
