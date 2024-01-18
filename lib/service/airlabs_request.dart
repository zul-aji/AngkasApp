import 'dart:convert';
import 'package:http/http.dart' as http;
import '../const.dart';
import '../response/airline_details.dart';
import '../response/flight_details.dart';
import '../response/schedule_flights.dart';

class API {
  static Future<List<ScheduleFlights>?> getArrDep(bool isArr) async {
    List<ScheduleFlights>? scheduleFlights;
    String isDep = isArr ? 'arr_iata' : 'dep_iata';

    final Uri url = Uri.parse('$baseAirlabsURL/schedules');

    final Map<String, String> queryParams = {
      'api_key': apiKey,
      isDep: 'CGK',
    };

    final Uri requestUrl = url.replace(queryParameters: queryParams);
    final response = await http.get(requestUrl);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> responseList = data['response'];
      scheduleFlights = responseList
          .map((flightJson) => ScheduleFlights.fromJson(flightJson))
          .toList();

      return scheduleFlights;
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<List<AirlineDetails>?> getAirlineDetail(String iataCode) async {
    List<AirlineDetails>? airlineDetails;

    final Uri url = Uri.parse('$baseAirlabsURL/airlines');

    final Map<String, String> queryParams = {
      'api_key': apiKey,
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

  static getFlightDetail(String flightIata) async {
    FlightDetails? flightDetails;

    final Uri url = Uri.parse('$baseAirlabsURL/flight');

    final Map<String, String> queryParams = {
      'api_key': apiKey,
      'flight_iata': flightIata,
    };

    final Uri requestUrl = url.replace(queryParameters: queryParams);
    final response = await http.get(requestUrl);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      if (data.containsKey('response')) {
        final Map<String, dynamic> responseData = data['response'];
        flightDetails = FlightDetails.fromJson(responseData);
        return flightDetails;
      } else {
        return false;
      }
    } else {
      return 'Unknown Error';
    }
  }
}
