import 'package:flutter/material.dart';

import '../util_funcs.dart';
import '../response/flight_details.dart';
import '../service/airlabs_request.dart';

class FlightArrDetails extends StatefulWidget {
  final String flightIata;

  const FlightArrDetails({
    Key? key,
    required this.flightIata,
  }) : super(key: key);

  @override
  State<FlightArrDetails> createState() => _FlightArrDetailsState();
}

class _FlightArrDetailsState extends State<FlightArrDetails> {
  bool _isLoading = true;
  CurrentFlightDetails? flightDetails;

  void getFlightDetails() async {
    var _flightDetails = await API.getFlightDetail(widget.flightIata);
    setState(() {
      flightDetails = _flightDetails;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    getFlightDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String arrTime = flightDetails?.arrTime ?? "[Unavailable]";
    String arrEstimated = flightDetails?.arrEstimated ?? "[Unavailable]";
    String arrActual = flightDetails?.arrActual ?? "[Unavailable]";
    String depTime = flightDetails?.depTime ?? "[Unavailable]";
    String depEstimated = flightDetails?.depEstimated ?? "[Unavailable]";
    String depActual = flightDetails?.depActual ?? "[Unavailable]";
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            const SliverAppBar(
              title: Text("Arriving Flight"),
              pinned: true,
              floating: true,
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
                          "https://airlabs.co/img/airline/m/${flightDetails!.airlineIata}.png",
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
                              flightDetails!.airlineName ?? "[Name Unavailble]",
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
                              Text(flightDetails!.depName ??
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
                              Text(flightDetails!.arrName ??
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
                              Text(flightDetails!.status ??
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
                                flightDetails!.duration == null
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
                      "Arriving at",
                      style: TextStyle(fontSize: 20.0),
                    ),
                    const Divider(thickness: 2.0),
                    Row(
                      children: [
                        const Text("Terminal: "),
                        Text(flightDetails!.arrTerminal ?? "[Unavailable]")
                      ],
                    ),
                    const SizedBox(height: 3.0),
                    Row(
                      children: [
                        const Text("Gate: "),
                        Text(flightDetails!.arrGate ?? "[Unavailable]")
                      ],
                    ),
                    const SizedBox(height: 3.0),
                    Row(
                      children: [
                        const Text("Time: "),
                        Text(formatDateTime(arrTime))
                      ],
                    ),
                    const SizedBox(height: 3.0),
                    Row(
                      children: [
                        const Text("Estimated: "),
                        Text(formatDateTime(arrEstimated))
                      ],
                    ),
                    const SizedBox(height: 3.0),
                    Row(
                      children: [
                        const Text("Actual: "),
                        Text(formatDateTime(arrActual))
                      ],
                    ),
                    const SizedBox(height: 3.0),
                    Row(
                      children: [
                        const Text("Delayed: "),
                        Text(flightDetails!.arrDelayed == null
                            ? "[Unavailable]"
                            : "${flightDetails!.arrDelayed.toString()} Minutes")
                      ],
                    ),
                    const SizedBox(height: 5.0),
                    const Text(
                      "Departing from",
                      style: TextStyle(fontSize: 20.0),
                    ),
                    const Divider(thickness: 2.0),
                    Row(
                      children: [
                        const Text("Terminal: "),
                        Text(flightDetails!.depTerminal ?? "[Unavailable]")
                      ],
                    ),
                    const SizedBox(height: 3.0),
                    Row(
                      children: [
                        const Text("Gate: "),
                        Text(flightDetails!.depGate ?? "[Unavailable]")
                      ],
                    ),
                    const SizedBox(height: 3.0),
                    Row(
                      children: [
                        const Text("Time: "),
                        Text(formatDateTime(depTime))
                      ],
                    ),
                    const SizedBox(height: 3.0),
                    Row(
                      children: [
                        const Text("Estimated: "),
                        Text(formatDateTime(depEstimated))
                      ],
                    ),
                    const SizedBox(height: 3.0),
                    Row(
                      children: [
                        const Text("Actual: "),
                        Text(formatDateTime(depActual))
                      ],
                    ),
                    const SizedBox(height: 3.0),
                    Row(
                      children: [
                        const Text("Delayed: "),
                        Text(flightDetails!.depDelayed == null
                            ? "[Unavailable]"
                            : "${flightDetails!.depDelayed.toString()} Minutes"),
                      ],
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}