import 'package:angkasapp/map/map_overlay.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../const.dart';
import 'map_navigate.dart';

class MapPick extends StatefulWidget {
  const MapPick({Key? key}) : super(key: key);

  @override
  State<MapPick> createState() => _MapPickState();
}

class _MapPickState extends State<MapPick> {
  String? selectedTerminal;
  String? selectedCategory;
  String? selectedLocation;

  List<Location> filteredCategory = [];
  List<Location> filteredLocation = [];

  // String tMap = locList[0].tPath;
  // double xMap = locList[0].xValue;
  // double yMap = locList[0].yValue;
  String? lName;
  String? tMap;
  double? xMap;
  double? yMap;

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
                        tMap != null ? Image.asset(tMap!) : Image.asset(T1L1),
                        Visibility(
                          visible:
                              (xMap == null && yMap == null) ? false : true,
                          child: Positioned(
                              left: xMap,
                              top: yMap,
                              child: Image.asset(
                                'assets/Pin.png',
                                scale: 5,
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
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      margin: const EdgeInsets.all(15.0),
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: Icon(Icons.arrow_back_ios)),
                          Text(lName ?? "Pick a Location"),
                          IconButton(
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MapNavigate())),
                              icon: Image.asset(
                                'assets/Navigate.png',
                                scale: 20,
                              ))
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
                          offset: Offset(0, 3),
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
                                  Text(
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
                                  Text(
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
                        SizedBox(height: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
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
                        SizedBox(height: 15),
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
                                tMap = location.tMap;
                                xMap = location.xMap;
                                yMap = (360 - location.yMap);
                                lName =
                                    "Terminal ${location.terminal}, Floor ${location.floor}, ${location.name}";
                                print("coordinate: $xMap, $yMap");
                              }
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(15.0),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Colors.deepOrange.shade400,
                                borderRadius: BorderRadius.circular(8)),
                            child: Center(
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
