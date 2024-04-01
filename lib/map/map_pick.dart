import 'package:flutter/material.dart';
import '../util/const.dart';
import 'map_navigate.dart';

class MapPick extends StatefulWidget {
  const MapPick({super.key});

  @override
  State<MapPick> createState() => _MapPickState();
}

class _MapPickState extends State<MapPick> {
  String? selectedTerminal;
  String? selectedCategory;
  String? selectedLocation;

  List<Location> filteredCategory = [];
  List<Location> filteredLocation = [];

  String? lName;
  String? tMap;
  int? xMap;
  int? yMap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.white,
          child: Stack(
            children: [
              InteractiveViewer(
                maxScale: 7.0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 6),
                  child: SizedBox(
                    width: 360,
                    height: 360,
                    child: Stack(
                      children: [
                        tMap != null
                            ? Image.asset(tMap!)
                            : Image.asset(mapLink('1', '1')),
                        Visibility(
                          visible: true,
                          // (xMap == null && yMap == null) ? false : true,
                          child: Positioned(
                              // left: xMap?.toDouble() ?? 0,
                              // top: yMap?.toDouble() ?? 0,
                              left: 360,
                              top: 0,
                              child: Icon(
                                Icons.location_pin,
                                color: Colors.grey,
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              //Pick place
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SafeArea(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 3,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      margin: const EdgeInsets.all(15.0),
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 1,
                            child: IconButton(
                                onPressed: () => Navigator.pop(context),
                                icon: const Icon(Icons.arrow_back_ios)),
                          ),
                          Expanded(
                              flex: 5,
                              child: Text(
                                lName ?? "Pick a Location",
                                textAlign: TextAlign.center,
                              )),
                          Expanded(
                            flex: 1,
                            child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const MapNavigate()));
                                },
                                icon: Image.asset(
                                  'assets/Navigate.png',
                                  scale: 20,
                                )),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(15.0),
                    padding: const EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(7),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Terminal",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  DropdownButton<String>(
                                    hint: const Text("Select Terminal"),
                                    value: selectedTerminal,
                                    onChanged: (String? terminalValue) {
                                      setState(() {
                                        selectedTerminal = terminalValue;
                                        filteredCategory = locList
                                            .where((location) =>
                                                location.terminal ==
                                                selectedTerminal)
                                            .toList();
                                        selectedCategory = null;
                                      });
                                    },
                                    items: [
                                      ...locList
                                          .map((location) => location.terminal)
                                          .toSet()
                                          .map<DropdownMenuItem<String>>(
                                              (String terminalName) {
                                        return DropdownMenuItem<String>(
                                          value: terminalName,
                                          child: Text(terminalName),
                                        );
                                      }),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Category",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  DropdownButton<String>(
                                    hint: selectedTerminal == null
                                        ? const Text("Pick Terminal First")
                                        : const Text("Select Category"),
                                    value: selectedCategory,
                                    onChanged: (String? categoryMap) {
                                      setState(() {
                                        selectedCategory = categoryMap;
                                        filteredLocation = filteredCategory
                                            .where((location) =>
                                                location.category ==
                                                selectedCategory)
                                            .toList();
                                        selectedLocation = null;
                                      });
                                    },
                                    items: selectedTerminal != null
                                        ? [
                                            ...filteredCategory
                                                .where((location) =>
                                                    location.terminal ==
                                                    selectedTerminal)
                                                .map((location) =>
                                                    location.category)
                                                .toSet()
                                                .map<DropdownMenuItem<String>>(
                                                    (String category) {
                                              return DropdownMenuItem<String>(
                                                value: category,
                                                child: Text(category),
                                              );
                                            }),
                                          ]
                                        : [],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Location",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            DropdownButton<String>(
                              hint: selectedCategory == null
                                  ? const Text("Pick Category First")
                                  : const Text("Select Location"),
                              value: selectedLocation,
                              onChanged: (String? locationValue) {
                                setState(() {
                                  selectedLocation = locationValue;
                                });
                              },
                              items: selectedTerminal != null &&
                                      selectedCategory != null
                                  ? [
                                      ...filteredLocation
                                          .where((location) =>
                                              location.terminal ==
                                                  selectedTerminal &&
                                              location.category ==
                                                  selectedCategory)
                                          .map((location) => location.name)
                                          .toSet()
                                          .map<DropdownMenuItem<String>>(
                                              (String name) {
                                        return DropdownMenuItem<String>(
                                          value: name,
                                          child: Text(name),
                                        );
                                      }),
                                    ]
                                  : [],
                            )
                          ],
                        ),
                        const SizedBox(height: 15),
                        // Button to change map
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (selectedTerminal != null &&
                                  selectedCategory != null &&
                                  selectedLocation != null) {
                                final location = locList.firstWhere((loc) =>
                                    loc.terminal == selectedTerminal &&
                                    loc.category == selectedCategory &&
                                    loc.name == selectedLocation);
                                tMap =
                                    mapLink(location.terminal, location.floor);
                                xMap = location.xMap;
                                yMap = location.yMap;
                                lName =
                                    'Terminal ${location.terminal}, Floor ${location.floor}\n${location.name}';
                                print("coordinate: $xMap, $yMap");
                              }
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(15.0),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Colors.deepOrange.shade400,
                                borderRadius: BorderRadius.circular(8)),
                            child: const Center(
                              child: Text(
                                "Find Location",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
