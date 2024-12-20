import 'package:angkasapp/util/a_star_algo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;

import 'const.dart';

class ImageDetail {
  final int width;
  final int height;
  final Uint8List? bytes;

  ImageDetail({required this.width, required this.height, this.bytes});
}

Future<ImageDetail> getImageDimensions(String assetPath) async {
  // Load the image data as a byte array from the asset bundle.
  final byteData = await rootBundle.load(assetPath);
  final bytes = byteData.buffer.asUint8List();

  // Decode the image data to access its intrinsic dimensions.
  final decodedImage = await decodeImageFromList(bytes);

  // Return the image details including width, height, and the raw bytes.
  return ImageDetail(
    width: decodedImage.width,
    height: decodedImage.height,
    bytes: bytes,
  );
}

/// Loads an image from the given path and returns an `img.Image` object.

Future<img.Image?> loadImage(String path) async {
  // Get the image details (width, height, and bytes) first.
  ImageDetail imageDetail = await getImageDimensions(path);

  // Decode the raw image bytes into a full `img.Image` object.
  return img.decodeImage(Uint8List.fromList(imageDetail.bytes!));
}

List<List<int>> convertImageToGrid(img.Image image) {
  // Convert the resized image to a grid
  return List.generate(
    image.height,
    (i) => List.generate(
      image.width,
      (j) {
        final pixel = image.getPixel(j, i);
        return isPath(pixel) ? 1 : 0;
      },
    ),
  );
}

// void RGBaValue(img.Image pixel, int x, int y) {
//   final color = pixel.getPixel(x, y);
//   final red = img.getRed(color);
//   final green = img.getGreen(color);
//   final blue = img.getBlue(color);
//   final alpha = img.getAlpha(color);

//   print('RGBa value at pixel ($x, $y): ($red, $green, $blue, $alpha)');
// }

class ImageProcessor {
  static Future<List<List<int>>> processCustomMap(String path) async {
    // Load the image
    img.Image? originalImage = await loadImage(path);

    if (originalImage == null) {
      throw Exception('Failed to load the image');
    }

    // Convert the resized image to a grid
    List<List<int>> grid = convertImageToGrid(originalImage);

    return grid;
  }
}

bool isPath(int pixel) {
  // Get the R, G, and B components of the pixel color
  int red = img.getRed(pixel);
  int green = img.getGreen(pixel);
  int blue = img.getBlue(pixel);

  // Define target color values
  int targetRed = 0;
  int targetGreen = 255;
  int targetBlue = 0;

  // Check if the pixel is a path based on the tolerance range
  if ((red >= targetRed && red <= targetRed) &&
      (green >= targetGreen && green <= targetGreen) &&
      (blue >= targetBlue && blue <= targetBlue)) {
    return true; // It's a path
  } else {
    return false; // It's an obstacle
  }
}

setMapList(String path) async {
  List<List<int>> grid = await ImageProcessor.processCustomMap(path);

  return grid;
}

int lowestIntIndex(List<int> lengths) {
  int lowest = lengths[0];
  int lowestIndex = 0;

  for (int i = 1; i < lengths.length; i++) {
    if (lengths[i] < lowest) {
      lowest = lengths[i];
      lowestIndex = i;
    }
  }

  return lowestIndex;
}

createLoc(
    bool security, String terminal, String floor, int xValue, int yValue) {
  Location tempLoc =
      Location('blank', 'blank', 'blank', 'blank', 0, 0, 0, 0, true, null);
  if (security) {
    tempLoc = Location('Security Check', 'Security', terminal, floor, xValue,
        yValue, 0, 0, true, null);
  } else {
    tempLoc = Location('Change Floor', 'Elevate', terminal, floor, xValue,
        yValue, 0, 0, true, null);
  }
  return tempLoc;
}

closestDest(Location initial, String category) async {
  List<Location> tempLoc = locList
      .where((loc) =>
          mapLink(loc.terminal, loc.floor) ==
              mapLink(initial.terminal, initial.floor) &&
          loc.category == category)
      .toList();
  if (tempLoc.length > 1) {
    List<int> lengths = [];
    for (var location in tempLoc) {
      List<Pair> trace = await aStarTry(
        initial.xValue,
        initial.yValue,
        location.xValue,
        location.yValue,
        pathLink(initial.terminal, initial.floor),
      );
      lengths.add(trace.length);
    }
    Location temp = tempLoc[lowestIntIndex(lengths)];
    return temp;
  } else {
    Location temp = tempLoc[0];
    return temp;
  }
}

closestElevate(Location initial, String toFloor) async {
  List<Elevate> tempLevate = eleList
      .where((lv) =>
          lv.terminal == initial.terminal &&
          lv.inFloor == initial.floor &&
          lv.toFloor == toFloor)
      .toList();
  if (tempLevate.length > 1) {
    List<int> lengths = [];
    for (var elevate in tempLevate) {
      List<Pair> trace = await aStarTry(
        initial.xValue,
        initial.yValue,
        elevate.xValue,
        elevate.yValue,
        pathLink(initial.terminal, initial.floor),
      );
      lengths.add(trace.length);
    }
    Elevate temp = tempLevate[lowestIntIndex(lengths)];
    return temp;
  } else {
    Elevate temp = tempLevate[0];
    return temp;
  }
}

setNavigationList(Location initial, Location destination) async {
  bool security = true;
  Location tempInit = initial;
  Location tempDest = destination;
  List<Location> navigations = [];

  if (initial.name == destination.name) {
    return navigations;
  }

  void addNavigation(Location location) {
    navigations.add(location);
    tempInit = location;
  }

  addNavigation(tempInit);
  //private source and public destination
  if ((!tempInit.public && destination.public) ||
      (!tempInit.public && (tempInit.terminal != destination.terminal))) {
    security = false;
    destination = createLoc(
        true,
        tempInit.security!.terminal,
        tempInit.security!.floorExit,
        tempInit.security!.xExit,
        tempInit.security!.yExit);
    while (security == false) {
      if (tempInit.terminal == destination.terminal) {
        if (tempInit.floor == destination.floor) {
          // NavDone
          addNavigation(destination);
          destination = tempDest;
          security = true;
        } else {
          await changeFloor(tempInit, destination.floor, addNavigation);
        }
      } else {
        await changeTerminal(tempInit, addNavigation, destination);
      }
    }
  }
  //private destination
  if (tempInit.terminal == destination.terminal && !destination.public) {
    security = false;
    destination = createLoc(
        true,
        destination.security!.terminal,
        destination.security!.floorEnter,
        destination.security!.xEnter,
        destination.security!.yEnter);
    while (security == false) {
      if (tempInit.terminal == destination.terminal) {
        if (tempInit.floor == destination.floor) {
          // NavDone
          addNavigation(destination);
          destination = tempDest;
          security = true;
        } else {
          await changeFloor(tempInit, destination.floor, addNavigation);
        }
      } else {
        await changeTerminal(tempInit, addNavigation, destination);
      }
    }
  }

  // public source and public destination
  while (tempInit.name != destination.name) {
    if (tempInit.terminal == destination.terminal) {
      if (tempInit.floor == destination.floor) {
        // NavDone
        addNavigation(destination);
      } else {
        await changeFloor(tempInit, destination.floor, addNavigation);
      }
    } else {
      await changeTerminal(tempInit, addNavigation, destination);
    }
  }
  return navigations;
}

Future<void> changeFloor(Location tempInit, String floor,
    void Function(Location location) addNavigation) async {
  Elevate tempLV = await closestElevate(tempInit, floor);
  addNavigation(createLoc(
      false, tempLV.terminal, tempLV.inFloor, tempLV.xValue, tempLV.yValue));
  addNavigation(createLoc(
      false, tempLV.terminal, tempLV.toFloor, tempLV.xTo, tempLV.yTo));
}

Future<void> changeTerminal(
    Location tempInit,
    void Function(Location location) addNavigation,
    Location destination) async {
  if (tempInit.terminal != '3' && tempInit.floor == '1') {
    addNavigation(await closestDest(tempInit, "Skytrain"));
    addNavigation(locList.firstWhere((loc) =>
        loc.terminal == destination.terminal && loc.category == "Skytrain"));
  } else if (tempInit.terminal != '3' && tempInit.floor != '1') {
    await changeFloor(tempInit, '1', addNavigation);
  } else if (tempInit.terminal == '3' && tempInit.floor == '3') {
    addNavigation(await closestDest(tempInit, "Skytrain"));
    addNavigation(locList.firstWhere((loc) =>
        loc.terminal == destination.terminal && loc.category == "Skytrain"));
  } else if (tempInit.terminal == '3' && tempInit.floor != '3') {
    await changeFloor(tempInit, '3', addNavigation);
  }
}
