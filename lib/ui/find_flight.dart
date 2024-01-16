import 'package:flutter/material.dart';

class FindFlight extends StatefulWidget {
  const FindFlight({super.key});

  @override
  State<FindFlight> createState() => _FindFlightState();
}

class _FindFlightState extends State<FindFlight> {
  TextEditingController controllerSearch = TextEditingController();
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
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 0.0),
                  child: Expanded(
                      flex: 1,
                      child: Icon(Icons.search, color: Color(0xff737373))),
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
                    child:
                        ElevatedButton(onPressed: () {}, child: const Text("Enter")))
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(5.0),
            child: Text("Input IATA or ICAO flight code only"),
          )
        ],
      ),
    );
  }
}
