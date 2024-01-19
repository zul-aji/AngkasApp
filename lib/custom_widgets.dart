import 'package:angkasapp/response/schedule_flights.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:timezone/timezone.dart' as tz;

import 'const.dart';
import 'response/flight_details.dart';
import 'ui/flight_details.dart';
import 'reminder_util.dart';

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
              builder: (context) => FlightDetailsPage(
                flightIata: flightIata,
                isArr: _isArr,
              ),
            ),
          ),
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 6.0),
            child: ListTile(
                title: Row(
                  children: [
                    SizedBox(
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
                    ? Text(
                        "Arriving in: ${DateParse.dateTimetoString(arrivalTime)}")
                    : Text(
                        "Departing in: ${DateParse.dateTimetoString(departureTime)}"),
                trailing: Text(currentIndex?.status ?? '[Unavailable]')),
          ),
        );
      },
    );
  }
}

class ReminderListView extends StatelessWidget {
  const ReminderListView({
    super.key,
    required this.reminderListLength,
    required this.reminderList,
    required this.isArr,
  });

  final int reminderListLength;
  final List<FlightDetails>? reminderList;
  final bool isArr;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: reminderListLength,
      itemBuilder: (context, index) {
        var currentIndex = reminderList?[index];
        String flightIata = currentIndex?.flightIata ?? "[Unavailable]";
        String arrivalTime = currentIndex?.arrTime ?? "[Unavailable]";
        String departureTime = currentIndex?.depTime ?? "[Unavailable]";
        return GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FlightDetailsPage(
                flightIata: flightIata,
                isArr: isArr,
              ),
            ),
          ),
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 6.0),
            child: ListTile(
                title: Row(
                  children: [
                    SizedBox(
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
                subtitle: isArr
                    ? Text(
                        "Arriving in: ${DateParse.dateTimetoString(arrivalTime)}")
                    : Text(
                        "Departing in: ${DateParse.dateTimetoString(departureTime)}"),
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
              builder: (context) => FlightDetailsPage(
                flightIata: flightIata,
                isArr: boolIsArr,
              ),
            ),
          ),
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 6.0),
            child: ListTile(
                title: Row(
                  children: [
                    SizedBox(
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
                    ? Text(
                        "Arriving in: ${DateParse.dateTimetoString(arrivalTime)}")
                    : Text(
                        "Departing in: ${DateParse.dateTimetoString(departureTime)}"),
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

void callDialog(BuildContext context, String flightIata, String arrTime,
    String depTime, bool isInReminder, FlightDetails? flightDetails) {
  bool isArr = true;
  bool isCancel = true;
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Adding a Reminder'),
        content: Text('When do you want to be reminded?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              isArr = true;
              isCancel = false;
            },
            child: Text('On its Arrival'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              isArr = false;
              isCancel = false;
            },
            child: Text('On its Departure'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              isCancel = true;
            },
            child: Text('Cancel'),
          ),
        ],
      );
    },
  ).then((result) {
    var flightDateTime = DateParse.stringToDateTime(isArr ? arrTime : depTime);
    if (isCancel) {
      Fluttertoast.showToast(
        msg: 'Canceled',
        textColor: Colors.black,
      );
    } else if (flightDateTime == "[Unavailable]") {
      Fluttertoast.showToast(
        msg: isArr
            ? 'Arrival time is unavailable'
            : 'Departure time is unavailable',
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    } else if (flightDateTime.isBefore(jakartaTime)) {
      Fluttertoast.showToast(
        msg: isArr
            ? 'Flight has arrived at ${flightDetails?.arrName}'
            : 'Flight has departed from ${flightDetails?.depName}',
      );
    } else {
      LocalNotif.setScheduledNotification(
          title: flightIata,
          body: 'flight is arriving',
          payload: 'payload',
          flightTime: tz.TZDateTime.from(flightDateTime, jakLoc),
          id: isArr ? flightIata.hashCode : flightIata.hashCode + 1);
      HiveFuncs.saveReminder(isArr, flightDetails);
    }
  });
}
