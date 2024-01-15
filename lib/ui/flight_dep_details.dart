import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:timezone/timezone.dart';

import '../response/schedule_flights.dart';
import '../local_notifications.dart';
import '../response/flight_details.dart';
import '../service/airlabs_request.dart';
import 'package:timezone/data/latest.dart' as tz;

class FlightDepDetails extends StatefulWidget {
  final String flightIata;
  final ScheduleFlights forReminder;
  final bool isArr;

  const FlightDepDetails({
    Key? key,
    required this.flightIata,
    required this.forReminder,
    required this.isArr,
  }) : super(key: key);

  @override
  State<FlightDepDetails> createState() => _FlightDepDetailsState();
}

class _FlightDepDetailsState extends State<FlightDepDetails> {
  bool _isLoading = true;
  FlightDetails? scheduleFlights;

  void getScheduleFlights() async {
    var _scheduleFlights = await API.getFlightDetail(widget.flightIata);
    setState(() {
      scheduleFlights = _scheduleFlights;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    getScheduleFlights();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String depTime = scheduleFlights?.depTime ?? "[Unavailable]";
    String depEstimated = scheduleFlights?.depEstimated ?? "[Unavailable]";
    String depActual = scheduleFlights?.depActual ?? "[Unavailable]";
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              title: Text("Departing Flight"),
              pinned: true,
              floating: true,
              actions: [
                IconButton(
                    onPressed: () async {
                      tz.initializeTimeZones();
                      DateTime flightDateTime = stringToDateTime(depTime);
                      TZDateTime jakartaTime =
                          TZDateTime.now(getLocation('Asia/Jakarta'));
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
                        LocalNotifications.showScheduledNotification(
                          title: scheduleFlights?.flightIata ??
                              'Flight code unavailable',
                          body: 'flight is departing',
                          payload: 'payload',
                          flightTime: depTime,
                          isArr: false,
                        );
                      }
                    },
                    icon: Icon(Icons.notification_add))
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
                          "https://airlabs.co/img/airline/m/${scheduleFlights!.airlineIata}.png",
                          errorBuilder: (context, error, stackTrace) {
                            // This function will be called if the image fails to load
                            return Icon(
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
                              scheduleFlights!.airlineName ??
                                  "[Name Unavailble]",
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
                              Text(scheduleFlights!.depName ??
                                  "[Departure Airport Unavailable]")
                            ],
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("To: "),
                              Text(scheduleFlights!.arrName ??
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
                              Text(scheduleFlights!.status ??
                                  "[Flight Status Unavailable]")
                            ],
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Duration: "),
                              Text(
                                scheduleFlights!.duration == null
                                    ? "[Unavailable]"
                                    : scheduleFlights!.duration.toString(),
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
                        Text(scheduleFlights!.depTerminal ?? "[Unavailable]")
                      ],
                    ),
                    const SizedBox(height: 3.0),
                    Row(
                      children: [
                        const Text("Gate: "),
                        Text(scheduleFlights!.depGate ?? "[Unavailable]")
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
                        Text(scheduleFlights!.depDelayed == null
                            ? "[Unavailable]"
                            : "${scheduleFlights!.depDelayed.toString()} Minutes")
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
