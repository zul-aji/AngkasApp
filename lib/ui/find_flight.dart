import 'package:flutter/material.dart';

import '../response/flight_details.dart';
import '../service/airlabs_request.dart';
import 'flight_details.dart';

class FindFlight extends StatefulWidget {
  const FindFlight({super.key});

  @override
  State<FindFlight> createState() => _FindFlightState();
}

class _FindFlightState extends State<FindFlight> {
  TextEditingController controllerSearch = TextEditingController();
  bool isCardVisibile = false;
  FlightDetails? flightDetails;

  void findFlightDetails(String flightIata) async {
    var _flightDetails = await API.getFlightDetail(flightIata);
    setState(() {
      flightDetails = _flightDetails;
      isCardVisibile = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Find a Flight"),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
            width: MediaQuery.of(context).size.width - 32,
            decoration: BoxDecoration(
              border: Border.all(width: 0.8),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 0.0),
                  child: Expanded(
                    flex: 1,
                    child: Icon(Icons.search, color: Color(0xff737373)),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: TextField(
                    controller: controllerSearch,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      labelStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                      labelText: 'Search for Flight',
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () {
                      findFlightDetails(controllerSearch.text);
                    },
                    child: const Text("Find"),
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(5.0),
            child: Text("Input IATA flight code only"),
          ),
          Visibility(
            visible: isCardVisibile,
            child: GestureDetector(
              onTap: () {
                FlightDetailsPage(
                  flightIata: flightDetails?.flightIata ?? '[Unavailable]',
                  isArr: true,
                );
              },
              child: Card(
                margin:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
                child: ListTile(
                  title: Row(
                    children: [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: Image.network(
                          "https://airlabs.co/img/airline/s/${flightDetails?.airlineIata}.png",
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.error,
                              color: Colors.red,
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        flightDetails?.flightIata ?? "[Unavailable]",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  subtitle: Text(flightDetails?.airlineName ?? '[Unavailable]'),
                  trailing: Text(flightDetails?.status ?? '[Unavailable]'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
