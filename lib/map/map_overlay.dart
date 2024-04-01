import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import '../util/const.dart';
import 'map_painter.dart';

typedef Pair = Tuple2<Location, Location>;

class MapOverlay extends StatefulWidget {
  MapOverlay({
    super.key,
    required this.navList,
  });
  final List<Location> navList;

  @override
  State<MapOverlay> createState() => _MapOverlayState();
}

class _MapOverlayState extends State<MapOverlay> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    List<Pair> navPair = createPairs(widget.navList);
    for (var i = 0; i < navPair.length; i++) {
      print("Step: ${i + 1}");
      print(
          "Terminal: ${navPair[i].item1.terminal}, ${navPair[i].item2.terminal}");
      print(
          "Category: ${navPair[i].item1.category}, ${navPair[i].item2.category}");
      print("Floor: ${navPair[i].item1.floor}, ${navPair[i].item2.floor}");
    }
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.white,
          child: Stack(
            children: [
              InteractiveViewer(
                minScale: 1.0,
                maxScale: 7.0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 360,
                    height: 360,
                    child: Stack(
                      children: [
                        Image.asset(mapLink(navPair[index].item1.terminal,
                            navPair[index].item1.floor)),
                        FutureBuilder<PathMap>(
                          future: createPathMap(
                              navPair[index].item1, navPair[index].item2),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return CustomPaint(
                                painter: snapshot.data,
                              );
                            } else {
                              return Center(
                                  child: CircularProgressIndicator(
                                color: Colors.deepOrange.shade400,
                              ));
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
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
                          IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: const Icon(Icons.arrow_back_rounded)),
                          Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: Text(
                              "Terminal ${navPair[index].item1.terminal}, Floor ${navPair[index].item1.floor}",
                              style: const TextStyle(fontSize: 18),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                  // Button to change map
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
                      children: [
                        Container(
                          margin: const EdgeInsets.all(8.0),
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Text(
                                  navPair[index].item1.name,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20),
                                ),
                              ),
                              const Expanded(
                                  flex: 1,
                                  child: Icon(
                                    Icons.arrow_forward_rounded,
                                    size: 30,
                                  )),
                              Expanded(
                                flex: 3,
                                child: Text(
                                  navPair[index].item2.name,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: index == 0 || index == navPair.length - 1
                              ? GestureDetector(
                                  onTap: () {
                                    if (index == 0) {
                                      setState(() {
                                        index += 1;
                                      });
                                    } else {
                                      setState(() {
                                        index -= 1;
                                      });
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(15.0),
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        color: Colors.deepOrange.shade400,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Visibility(
                                            visible: index != 0,
                                            child: const Icon(
                                              Icons.arrow_back_ios_new_rounded,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            index == 0 ? "Next" : "Previous",
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 18),
                                          ),
                                          Visibility(
                                            visible: index == 0,
                                            child: const Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            index -= 1;
                                          });
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(15.0),
                                          margin:
                                              const EdgeInsets.only(right: 5.0),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                              color: Colors.deepOrange.shade400,
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: const Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Icon(
                                                  Icons
                                                      .arrow_back_ios_new_rounded,
                                                  color: Colors.white,
                                                ),
                                                Text(
                                                  "Previous",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 18),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            index += 1;
                                          });
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(15.0),
                                          margin:
                                              const EdgeInsets.only(left: 5.0),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                              color: Colors.deepOrange.shade400,
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: const Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(
                                                  "Next",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 18),
                                                ),
                                                Icon(
                                                  Icons
                                                      .arrow_forward_ios_rounded,
                                                  color: Colors.white,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Pair> createPairs(List<Location> data) {
    List<Pair> pairs = [];

    for (int i = 0; i < data.length - 1; i++) {
      if (data[i].category == "Skytrain" &&
          data[i + 1].category == "Skytrain") {
        continue;
      } else if (data[i].category == "Elevate" &&
          data[i + 1].category == "Elevate") {
      } else {
        pairs.add(Pair(data[i], data[i + 1]));
      }
    }

    return pairs;
  }
}
