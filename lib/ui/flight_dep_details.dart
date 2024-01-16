import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../const.dart';
import '../hive_funcs.dart';
import '../local_notifications.dart';
import '../response/flight_details.dart';
import '../response/schedule_flights.dart';
import '../service/airlabs_request.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class FlightDepDetails extends StatefulWidget {
  final String flightIata;
  final ScheduleFlights forReminder;
  final bool isArr;

  const FlightDepDetails({
    super.key,
    required this.flightIata,
    required this.forReminder,
    required this.isArr,
  });

  @override
  State<FlightDepDetails> createState() => _FlightDepDetailsState();
}

class _FlightDepDetailsState extends State<FlightDepDetails> {
  bool _isLoading = true;
  bool _isInReminder = false;
  FlightDetails? flightDetails;

  void getScheduleFlights() async {
    var _flightDetails = await API.getFlightDetail(widget.flightIata);
    setState(() {
      flightDetails = _flightDetails;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    getScheduleFlights();
    _isInReminder = HiveFuncs.checkCurrentFlight(widget.flightIata, false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String depTime = flightDetails?.depTime ?? "[Unavailable]";
    String depEstimated = flightDetails?.depEstimated ?? "[Unavailable]";
    String depActual = flightDetails?.depActual ?? "[Unavailable]";
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              title: const Text("Departing Flight"),
              pinned: true,
              floating: true,
              actions: [
                IconButton(
                  onPressed: () async {
                    tz.initializeTimeZones();
                    DateTime flightDateTime = stringToDateTime(depTime);
                    tz.TZDateTime jakartaTime =
                        tz.TZDateTime.now(tz.getLocation('Asia/Jakarta'));
                    if (depTime == "[Unavailable]") {
                      Fluttertoast.showToast(
                        msg: 'Arrival time is unavailable',
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                      );
                    } else if (flightDateTime.isBefore(jakartaTime)) {
                      Fluttertoast.showToast(
                        msg: 'Flight have departed from Soekarno-Hatta',
                      );
                    } else {
                      _isInReminder
                          ? {
                              LocalNotifications.stopNotification(
                                  widget.flightIata.hashCode),
                              HiveFuncs.deleteReminder(widget.flightIata, false)
                            }
                          : {
                              LocalNotifications.showScheduledNotification(
                                title: flightDetails?.flightIata ??
                                    'Flight code unavailable',
                                body: 'flight is departing',
                                payload: 'payload',
                                flightTime:
                                    tz.TZDateTime.from(flightDateTime, jakLoc),
                                id: widget.flightIata.hashCode,
                              ),
                              HiveFuncs.saveReminder(
                                  widget.flightIata, false, widget.forReminder)
                            };
                    }
                  },
                  icon: const Icon(Icons.notification_add),
                )
              ],
            ),
          ];
        },
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          width: double.infinity,
          height: double.infinity,
          child: _isLoading
              ? const Center(
                  child: Text('Fetching Data...'),
                )
              : Column(
                  children: [
                    //Logo, Airline name, Flight IATA
                    Row(
                      children: [
                        Image.network(
                          "https://airlabs.co/img/airline/m/${flightDetails?.airlineIata}.png",
                          errorBuilder: (context, error, stackTrace) {
                            // This function will be called if the image fails to load
                            return const Icon(
                              Icons.error,
                              color: Colors.red,
                            );
                          },
                        ),
                        const SizedBox(width: 15.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              flightDetails?.airlineName ?? "[Name Unavailble]",
                              style: const TextStyle(fontSize: 20),
                            ),
                            Text(widget.flightIata)
                          ],
                        )
                      ],
                    ),
                    // Arrival Airport and Departure Airport
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("From: "),
                              Text(flightDetails?.depName ??
                                  "[Departure Airport Unavailable]")
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("To: "),
                              Text(flightDetails?.arrName ??
                                  "[Arrival Airport Unavailable]")
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5.0),
                    // Flight Status and Duration
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Status: "),
                              Text(flightDetails?.status ??
                                  "[Flight Status Unavailable]")
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Duration: "),
                              Text(
                                flightDetails?.duration == null
                                    ? "[Unavailable]"
                                    : flightDetails!.duration.toString(),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5.0),
                    const Text(
                      "Departing at",
                      style: TextStyle(fontSize: 20.0),
                    ),
                    const Divider(thickness: 2.0),
                    Row(
                      children: [
                        const Text("Terminal: "),
                        Text(flightDetails?.depTerminal ?? "[Unavailable]")
                      ],
                    ),
                    const SizedBox(height: 3.0),
                    Row(
                      children: [
                        const Text("Gate: "),
                        Text(flightDetails?.depGate ?? "[Unavailable]")
                      ],
                    ),
                    const SizedBox(height: 3.0),
                    Row(
                      children: [
                        const Text("Time: "),
                        Text(dateTimetoString(depTime))
                      ],
                    ),
                    const SizedBox(height: 3.0),
                    Row(
                      children: [
                        const Text("Estimated: "),
                        Text(dateTimetoString(depEstimated))
                      ],
                    ),
                    const SizedBox(height: 3.0),
                    Row(
                      children: [
                        const Text("Actual: "),
                        Text(dateTimetoString(depActual))
                      ],
                    ),
                    const SizedBox(height: 3.0),
                    Row(
                      children: [
                        const Text("Delayed: "),
                        Text(flightDetails?.depDelayed == null
                            ? "[Unavailable]"
                            : "${flightDetails!.depDelayed.toString()} Minutes")
                      ],
                    ),
                    const SizedBox(height: 5.0),
                  ],
                ),
        ),
      ),
    );
  }
}
