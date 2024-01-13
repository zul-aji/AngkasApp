import 'package:flutter/material.dart';

import 'response/schedule_flights.dart';
import 'ui/flight_arr_details.dart';
import 'ui/flight_dep_details.dart';
import 'local_notifications.dart';

class ScheduleListView extends StatelessWidget {
  const ScheduleListView({
    super.key,
    required List<ScheduleFlights>? scheduleList,
    required int scheduleLength,
    required bool isArr,
  })  : _scheduleList = scheduleList,
        _scheduleLength = scheduleLength,
        _isArr = isArr;

  final List<ScheduleFlights>? _scheduleList;
  final int _scheduleLength;
  final bool _isArr;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _scheduleLength,
      itemBuilder: (context, index) {
        var currentIndex = _scheduleList?[index];
        String flightIata = currentIndex?.flightIata ?? "[Unavailable]";
        String arrivalTime = currentIndex?.arrTime ?? "[Unavailable]";
        String departureTime = currentIndex?.depTime ?? "[Unavailable]";
        return GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => _isArr
                  ? FlightArrDetails(
                      flightIata: flightIata,
                      forReminder: _scheduleList![index],
                      isArr: _isArr)
                  : FlightDepDetails(
                      flightIata: flightIata,
                      forReminder: _scheduleList![index],
                      isArr: _isArr),
            ),
          ),
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 6.0),
            child: ListTile(
                title: Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      child: Image.network(
                        "https://airlabs.co/img/airline/s/${currentIndex?.airlineIata}.png",
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          // This function will be called if the image fails to load
                          return const Icon(
                            Icons.error,
                            color: Colors.red,
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      currentIndex?.flightIata ?? "[Flight code unavailable]",
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                subtitle: _isArr
                    ? Text("Arriving in: ${dateTimetoString(arrivalTime)}")
                    : Text("Departing in: ${dateTimetoString(departureTime)}"),
                trailing: Text(currentIndex?.status ?? '[Unavailable]')),
          ),
        );
      },
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  List<ScheduleFlights>? flightList;
  bool boolIsArr;

  CustomSearchDelegate({
    required this.flightList,
    required this.boolIsArr,
  });

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back_ios_new_rounded),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<ScheduleFlights>? matchQuery = _filterResults();
    return _buildResultListView(matchQuery);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<ScheduleFlights>? matchQuery = _filterResults();
    return _buildResultListView(matchQuery);
  }

  List<ScheduleFlights>? _filterResults() {
    List<ScheduleFlights>? matchQuery = [];
    for (var flight in flightList!) {
      if (_isMatch(flight)) {
        matchQuery.add(flight);
      }
    }
    return matchQuery;
  }

  Widget _buildResultListView(List<ScheduleFlights>? matchQuery) {
    return ListView.builder(
      itemCount: matchQuery?.length ?? 0,
      itemBuilder: (context, index) {
        var result = matchQuery?[index];
        String flightIata = result?.flightIata ?? "[Unavailable]";
        String arrivalTime = result?.arrTime ?? "[Unavailable]";
        String departureTime = result?.depTime ?? "[Unavailable]";
        return GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => boolIsArr
                  ? FlightArrDetails(
                      flightIata: flightIata,
                      forReminder: matchQuery![index],
                      isArr: boolIsArr)
                  : FlightDepDetails(
                      flightIata: flightIata,
                      forReminder: matchQuery![index],
                      isArr: boolIsArr),
            ),
          ),
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 6.0),
            child: ListTile(
                title: Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      child: Image.network(
                        "https://airlabs.co/img/airline/s/${result?.airlineIata}.png",
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          // This function will be called if the image fails to load
                          return const Icon(
                            Icons.error,
                            color: Colors.red,
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      result?.flightIata ?? "[Flight code unavailable]",
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                subtitle: boolIsArr
                    ? Text("Arriving in: ${dateTimetoString(arrivalTime)}")
                    : Text("Departing in: ${dateTimetoString(departureTime)}"),
                trailing: Text(result?.status ?? '[Unavailable]')),
          ),
        );
      },
    );
  }

  bool _isMatch(ScheduleFlights flight) {
    return (flight.flightIata != null &&
            flight.flightIata!.toLowerCase().contains(query.toLowerCase())) ||
        (flight.flightIcao != null &&
            flight.flightIcao!.toLowerCase().contains(query.toLowerCase())) ||
        (flight.flightNumber != null &&
            flight.flightNumber!.toLowerCase().contains(query.toLowerCase()));
  }
}
