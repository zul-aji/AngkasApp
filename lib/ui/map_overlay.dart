import 'dart:typed_data';
import 'package:image/image.dart' as img;
import 'package:flutter/material.dart';
import '../const.dart';
import '../map_path_set.dart';
import 'map_painter.dart';

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

  static Future<Uint8List> getResizedImageData(String path) async {
    // Load the image
    img.Image? originalImage = await loadImage(path);

    if (originalImage == null) {
      throw Exception('Failed to load the image');
    }
    // Resize the image to 400x400
    img.Image resizedImage = resizeImage(originalImage);

    return Uint8List.fromList(img.encodePng(resizedImage));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map Overlay'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Container(
              width: 400,
              height: 400,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(5)),
              child: InteractiveViewer(
                maxScale: 5.0,
                child: Stack(
                  children: [
                    // Image.asset(Const.pT2L1r),
                    FutureBuilder<Uint8List>(
                      future: getResizedImageData(pT2L1r),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return Image.memory(
                            snapshot.data!,
                            width: 400,
                            height: 400,
                          );
                        } else {
                          return const CircularProgressIndicator();
                        }
                      },
                    ),
                    FutureBuilder<DotMap>(
                      future: createDotMap(pT2L1r),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return CustomPaint(
                            painter: snapshot.data!,
                          );
                        } else {
                          return const CircularProgressIndicator();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                printNumberOfOnes(await setMapList(pT2L1r));
              },
              child: const Text('test'),
            ),
          ],
        ),
      ),
    );
  }
}
