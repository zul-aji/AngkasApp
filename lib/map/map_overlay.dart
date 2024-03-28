import 'dart:typed_data';
import 'package:angkasapp/util/a_star_algo.dart';
import 'package:image/image.dart' as img;
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';
import '../util/const.dart';
import '../util/map_util.dart';
import 'map_painter.dart';

typedef Pair = Tuple2<int, int>;

class MapOverlay extends StatelessWidget {
  MapOverlay({
    super.key,
    // required this.navList,
  });
  // final List<Location> navList;

  String mapImage = mapLink(locList[0].terminal, locList[0].floor);
  String mapPath = pathLink(locList[0].terminal, locList[0].floor);
  int xMap = locList[0].xValue;
  int yMap = locList[0].yValue;

  @override
  Widget build(BuildContext context) {
    bool paintTrace = false;
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
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 360,
                    height: 360,
                    child: Stack(
                      children: [
                        Image.asset(mapImage),
                        FutureBuilder<DotMap>(
                          future: createDotMap(mapPath),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return CustomPaint(
                                painter: snapshot.data!,
                              );
                            } else {
                              return const CircularProgressIndicator();
                            }
                          },
                        ),
                        // FutureBuilder<PathMap>(
                        //   future: createPathMap(),
                        //   builder: (context, snapshot) {
                        //     if (snapshot.connectionState ==
                        //         ConnectionState.done) {
                        //       return CustomPaint(
                        //         painter: snapshot.data,
                        //       );
                        //     } else {
                        //       return const CircularProgressIndicator();
                        //     }
                        //   },
                        // ),
                        // Positioned(
                        //     left: xMap!.toDouble(),
                        //     top: yMap!.toDouble(),
                        //     child: Image.asset(
                        //       'assets/Pin.png',
                        //       scale: 5,
                        //     )),
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
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {},
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
