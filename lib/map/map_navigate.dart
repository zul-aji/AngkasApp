import 'package:angkasapp/util/map_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../util/const.dart';
import 'map_overlay.dart';

class MapNavigate extends StatefulWidget {
  const MapNavigate({super.key});

  @override
  State<MapNavigate> createState() => _MapNavigateState();
}

class _MapNavigateState extends State<MapNavigate> {
  Location? initialLoc;
  Location? destLoc;

  String? fromTerminal;
  String? fromCategory;
  String? fromLocation;
  String? toTerminal;
  String? toCategory;
  String? toLocation;

  List<Location> filFromCategory = [];
  List<Location> filFromLocation = [];
  List<Location> filToCategory = [];
  List<Location> filToLocation = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios)),
        title: const Text("Pick Locations"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // From Section =================================================
            Container(
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.all(20.0),
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
                  const Text(
                    "From: ",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Divider(),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // From Terminal Section =====================================
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
                              value: fromTerminal,
                              onChanged: (String? terminalValue) {
                                setState(() {
                                  fromTerminal = terminalValue;
                                  filFromCategory = locList
                                      .where((location) =>
                                          location.terminal == fromTerminal &&
                                          location.category != 'Skytrain')
                                      .toList();
                                  fromCategory = null;
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
                      // From Category Section =====================================
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
                              hint: fromTerminal == null
                                  ? const Text("Pick Terminal First")
                                  : const Text("Select Category"),
                              value: fromCategory,
                              onChanged: (String? categoryMap) {
                                setState(() {
                                  fromCategory = categoryMap;
                                  filFromLocation = filFromCategory
                                      .where((location) =>
                                          location.category == fromCategory)
                                      .toList();
                                  fromLocation = null;
                                });
                              },
                              items: fromTerminal != null
                                  ? [
                                      ...filFromCategory
                                          .where((location) =>
                                              location.terminal == fromTerminal)
                                          .map((location) => location.category)
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
                  // From Location Section =====================================
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
                        hint: fromCategory == null
                            ? const Text("Pick Category First")
                            : const Text("Select Location"),
                        value: fromLocation,
                        onChanged: (String? locationValue) {
                          setState(() {
                            fromLocation = locationValue;
                            toTerminal = null;
                            if (fromTerminal != null &&
                                fromCategory != null &&
                                fromLocation != null) {
                              initialLoc = locList.firstWhere((loc) =>
                                  loc.terminal == fromTerminal &&
                                  loc.category == fromCategory &&
                                  loc.name == fromLocation);
                            }
                          });
                        },
                        items: fromTerminal != null && fromCategory != null
                            ? [
                                ...filFromLocation
                                    .where((location) =>
                                        location.terminal == fromTerminal &&
                                        location.category == fromCategory)
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
                ],
              ),
            ),

            //To Section =================================================
            Container(
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.all(20.0),
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
                  const Text(
                    "To: ",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Divider(),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // To Terminal Section =====================================
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
                                hint: fromLocation == null
                                    ? const Text("Pick From First")
                                    : const Text("Select Terminal"),
                                value: toTerminal,
                                onChanged: (String? terminalValue) {
                                  setState(() {
                                    toTerminal = terminalValue;
                                    filToCategory = locList
                                        .where((location) =>
                                            location.terminal == toTerminal)
                                        .toList();
                                    toCategory = null;
                                  });
                                },
                                items: fromLocation != null
                                    ? [
                                        ...locList
                                            .map(
                                                (location) => location.terminal)
                                            .toSet()
                                            .map<DropdownMenuItem<String>>(
                                                (String terminalName) {
                                          return DropdownMenuItem<String>(
                                            value: terminalName,
                                            child: Text(terminalName),
                                          );
                                        }),
                                      ]
                                    : [])
                          ],
                        ),
                      ),
                      // To Category Section =====================================
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
                              hint: toTerminal == null
                                  ? const Text("Pick Terminal First")
                                  : const Text("Select Category"),
                              value: toCategory,
                              onChanged: (String? categoryMap) {
                                setState(() {
                                  toCategory = categoryMap;
                                  filToLocation = filToCategory
                                      .where((location) =>
                                          location.category == toCategory)
                                      .toList();
                                  toLocation = null;
                                });
                              },
                              items: toTerminal != null
                                  ? [
                                      ...filToCategory
                                          .where((location) =>
                                              location.terminal == toTerminal &&
                                              location.category !=
                                                  'Arrival Gate')
                                          .map((location) => location.category)
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
                  // To Location Section =====================================
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
                        hint: toCategory == null
                            ? const Text("Pick Category First")
                            : const Text("Select Location"),
                        value: toLocation,
                        onChanged: (String? locationValue) {
                          setState(() {
                            toLocation = locationValue;
                            if (toTerminal != null &&
                                toCategory != null &&
                                toLocation != null) {
                              destLoc = locList.firstWhere((loc) =>
                                  loc.terminal == toTerminal &&
                                  loc.category == toCategory &&
                                  loc.name == toLocation);
                            }
                          });
                        },
                        items: (toTerminal != null && toCategory != null)
                            ? [
                                ...filToLocation
                                    .where((location) =>
                                        location.terminal == toTerminal &&
                                        location.category == toCategory)
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
                ],
              ),
            ),
            GestureDetector(
              onTap: () async {
                if (initialLoc == null) {
                  const AlertDialog(
                    title: Text("Empty Source"),
                    content: Text("From not picked"),
                  );
                } else if (destLoc == null) {
                  const AlertDialog(
                    title: Text("Empty Destination"),
                    content: Text("To not picked"),
                  );
                } else {
                  List<Location> navList =
                      await setNavigationList(initialLoc!, destLoc!);
                  if (navList.isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MapOverlay(
                          navList: navList,
                        ),
                      ),
                    );
                  } else {
                    const AlertDialog(
                      title: Text("You have arrived"),
                      content: Text("Source and Destination is the same"),
                    );
                  }
                }
              },
              child: Container(
                margin: const EdgeInsets.all(10.0),
                padding: const EdgeInsets.all(15.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.deepOrange.shade400,
                    borderRadius: BorderRadius.circular(8)),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.directions,
                      color: Colors.white,
                    ),
                    SizedBox(width: 8),
                    Text(
                      "Get Directions",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
