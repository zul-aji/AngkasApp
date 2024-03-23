import 'dart:typed_data';
import 'package:angkasapp/a_star_algo.dart';
import 'package:image/image.dart' as img;
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import '../const.dart';
import '../map_path_set.dart';
import 'map_painter.dart';

typedef Pair = Tuple2<int, int>;

void printNumberOfOnes(List<List<int>> grid) {
  // Flatten the 2D grid to a 1D list
  List<int> flatList = grid.expand((row) => row).toList();

  // Count the occurrences of 1
  int numberOfOnes = flatList.where((element) => element == 1).length;
  int numberOfZeros = flatList.where((element) => element == 0).length;

  // Print the result
  print(
      '"1"s: $numberOfOnes, "0"s: $numberOfZeros, total: ${numberOfOnes + numberOfZeros}');
}

class MapOverlay extends StatelessWidget {
  const MapOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    bool paintTrace = false;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map Overlay'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Center(
              child: Container(
                width: 360,
                height: 360,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(5)),
                child: InteractiveViewer(
                  maxScale: 7.0,
                  child: Stack(
                    children: [
                      Image.asset(T2L1),
                      FutureBuilder<DotMap>(
                        future: createDotMap(T2L1p),
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
                      FutureBuilder<PathMap>(
                        future: createPathMap(),
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
                      )
                    ],
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                // printNumberOfOnes(await setMapList(pT2L2p));
                paintTrace = true;
              },
              child: const Text('test'),
            ),
          ],
        ),
      ),
    );
  }
}
