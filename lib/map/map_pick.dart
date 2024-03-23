import 'package:angkasapp/map/map_overlay.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../const.dart';

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

  String terminalPath = locList[0].terminalPath;
  double xMap = locList[0].xValue;
  double yMap = locList[0].yValue;
  // String? terminalPath;
  // double? xMap;
  // double? yMap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new_rounded)),
        title: const Text('Airport Map'),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(14.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: SizedBox(
              width: 360.72727272727275,
              height: 360.72727272727275,
              child: InteractiveViewer(
                boundaryMargin: EdgeInsets.zero,
                maxScale: 7.0,
                child: Stack(
                  children: [
                    terminalPath != null
                        ? Image.asset(terminalPath!)
                        : Image.asset(T1L2),
                    Visibility(
                      visible: (xMap == null && yMap == null) ? false : true,
                      child: Positioned(
                          left: xMap,
                          bottom: yMap,
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

          //Drop down button
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
            child: Row(
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
                                    location.terminal == selectedTerminal)
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
                                    location.category == selectedCategory)
                                .toList();
                            selectedLocation = null;
                          });
                        },
                        items: selectedTerminal != null
                            ? [
                                ...filteredCategory
                                    .where((location) =>
                                        location.terminal == selectedTerminal)
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
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
            width: MediaQuery.of(context).size.width,
            child: Column(
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
                  items: selectedTerminal != null && selectedCategory != null
                      ? [
                          ...filteredLocation
                              .where((location) =>
                                  location.terminal == selectedTerminal &&
                                  location.category == selectedCategory)
                              .map((location) => location.name)
                              .toSet()
                              .map<DropdownMenuItem<String>>((String name) {
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
          ),
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
                  terminalPath = location.terminalPath;
                  xMap = location.xMap;
                  yMap = location.yMap;
                }
              });
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 18.0, vertical: 15.0),
              padding: EdgeInsets.all(15.0),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.deepOrange.shade600,
                  borderRadius: BorderRadius.circular(8)),
              child: Center(
                  child: Text(
                "Find Location",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 18),
              )),
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const MapOverlay())),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 18.0, vertical: 15.0),
              padding: EdgeInsets.all(15.0),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.deepOrange.shade600,
                  borderRadius: BorderRadius.circular(8)),
              child: Center(
                  child: Text(
                "Map Navigate",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 18),
              )),
            ),
          )
        ],
      ),
    );
  }
}
