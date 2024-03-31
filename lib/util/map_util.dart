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
  final byteData = await rootBundle.load(assetPath);
  final bytes = byteData.buffer.asUint8List();
  final decodedImage = await decodeImageFromList(bytes);

  return ImageDetail(
    width: decodedImage.width,
    height: decodedImage.height,
    bytes: bytes,
  );
}

Future<img.Image?> loadImage(String path) async {
  // Load the image from the given path
  ImageDetail imageDetail = await getImageDimensions(path);
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

void RGBaValue(img.Image image, int x, int y) {
  final pixel = image.getPixel(x, y);
  final red = img.getRed(pixel);
  final green = img.getGreen(pixel);
  final blue = img.getBlue(pixel);
  final alpha = img.getAlpha(pixel);

  print('RGBa value at pixel ($x, $y): ($red, $green, $blue, $alpha)');
}

class ImageProcessor {
  static Future<List<List<int>>> processCustomMap(String path) async {
    // Load the image
    img.Image? originalImage = await loadImage(path);

    if (originalImage == null) {
      throw Exception('Failed to load the image');
    }

    // RGBaValue(originalImage, 200, 180);

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

  // Define your target color values
  int targetRed = 0;
  int targetGreen = 255;
  int targetBlue = 0;

  // Define a tolerance range for each color channel
  int tolerance = 0;

  // Check if the pixel is a path based on the tolerance range
  if ((red >= targetRed - tolerance && red <= targetRed + tolerance) &&
      (green >= targetGreen - tolerance && green <= targetGreen + tolerance) &&
      (blue >= targetBlue - tolerance && blue <= targetBlue + tolerance)) {
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
  navigations.add(tempInit);
  //private source and public destination
  if (!tempInit.public && destination.public) {
    security = false;
    tempDest = destination;
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
          navigations.add(destination);
          tempInit = destination;
          destination = tempDest;
          security = true;
          // public source and public destination
          while (tempInit.terminal != destination.terminal &&
              tempInit.floor != destination.floor &&
              tempInit.xValue != destination.xValue &&
              tempInit.yValue != destination.yValue) {
            if (tempInit.terminal == destination.terminal) {
              if (tempInit.floor == destination.floor) {
                // NavDone
                navigations.add(destination);
                tempInit = destination;
              } else {
                Elevate tempLV =
                    await closestElevate(tempInit, destination.floor);
                navigations.add(createLoc(false, tempLV.terminal,
                    tempLV.inFloor, tempLV.xValue, tempLV.yValue));
                Location currLoc = createLoc(false, tempLV.terminal,
                    tempLV.toFloor, tempLV.xTo, tempLV.yTo);
                navigations.add(currLoc);
                tempInit = currLoc;
              }
            } else {
              if (tempInit.terminal != '3' && tempInit.floor == '1') {
                navigations.add(await closestDest(tempInit, "Skytrain"));
                var newTerminal = locList.firstWhere((loc) =>
                    loc.terminal == destination.terminal &&
                    loc.category == "Skytrain");
                navigations.add(newTerminal);
                tempInit = newTerminal;
              } else if (tempInit.terminal != '3' && tempInit.floor != '1') {
                Elevate tempLV = await closestElevate(tempInit, '1');
                navigations.add(createLoc(false, tempLV.terminal,
                    tempLV.inFloor, tempLV.xValue, tempLV.yValue));
                Location currLoc = createLoc(false, tempLV.terminal,
                    tempLV.toFloor, tempLV.xTo, tempLV.yTo);
                navigations.add(currLoc);
                tempInit = currLoc;
              } else if (tempInit.terminal == '3' && tempInit.floor == '3') {
                navigations.add(await closestDest(tempInit, "Skytrain"));
                var newTerminal = locList.firstWhere((loc) =>
                    loc.terminal == destination.terminal &&
                    loc.category == "Skytrain");
                navigations.add(newTerminal);
                tempInit = newTerminal;
              } else if (tempInit.terminal == '3' && tempInit.floor != '3') {
                Elevate tempLV = await closestElevate(tempInit, '3');
                navigations.add(createLoc(false, tempLV.terminal,
                    tempLV.inFloor, tempLV.xValue, tempLV.yValue));
                Location currLoc = createLoc(false, tempLV.terminal,
                    tempLV.toFloor, tempLV.xTo, tempLV.yTo);
                navigations.add(currLoc);
                tempInit = currLoc;
              }
            }
          }
        } else {
          Elevate tempLV = await closestElevate(tempInit, destination.floor);
          navigations.add(createLoc(false, tempLV.terminal, tempLV.inFloor,
              tempLV.xValue, tempLV.yValue));
          Location currLoc = createLoc(
              false, tempLV.terminal, tempLV.toFloor, tempLV.xTo, tempLV.yTo);
          navigations.add(currLoc);
          tempInit = currLoc;
        }
      } else {
        if (tempInit.terminal != '3' && tempInit.floor == '1') {
          navigations.add(await closestDest(tempInit, "Skytrain"));
          var newTerminal = locList.firstWhere((loc) =>
              loc.terminal == destination.terminal &&
              loc.category == "Skytrain");
          navigations.add(newTerminal);
          tempInit = newTerminal;
        } else if (tempInit.terminal != '3' && tempInit.floor != '1') {
          Elevate tempLV = await closestElevate(tempInit, '1');
          navigations.add(createLoc(false, tempLV.terminal, tempLV.inFloor,
              tempLV.xValue, tempLV.yValue));
          Location currLoc = createLoc(
              false, tempLV.terminal, tempLV.toFloor, tempLV.xTo, tempLV.yTo);
          navigations.add(currLoc);
          tempInit = currLoc;
        } else if (tempInit.terminal == '3' && tempInit.floor == '3') {
          navigations.add(await closestDest(tempInit, "Skytrain"));
          var newTerminal = locList.firstWhere((loc) =>
              loc.terminal == destination.terminal &&
              loc.category == "Skytrain");
          navigations.add(newTerminal);
          tempInit = newTerminal;
        } else if (tempInit.terminal == '3' && tempInit.floor != '3') {
          Elevate tempLV = await closestElevate(tempInit, '3');
          navigations.add(createLoc(false, tempLV.terminal, tempLV.inFloor,
              tempLV.xValue, tempLV.yValue));
          Location currLoc = createLoc(
              false, tempLV.terminal, tempLV.toFloor, tempLV.xTo, tempLV.yTo);
          navigations.add(currLoc);
          tempInit = currLoc;
        }
      }
    }
  }
  //private destination
  if (!destination.public) {
    security = false;
    tempDest = destination;
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
          navigations.add(destination);
          tempInit = destination;
          destination = tempDest;
          security = true;
          // public source and public destination
          while (tempInit.terminal != destination.terminal &&
              tempInit.floor != destination.floor &&
              tempInit.xValue != destination.xValue &&
              tempInit.yValue != destination.yValue) {
            if (tempInit.terminal == destination.terminal) {
              if (tempInit.floor == destination.floor) {
                // NavDone
                navigations.add(destination);
                tempInit = destination;
              } else {
                Elevate tempLV =
                    await closestElevate(tempInit, destination.floor);
                navigations.add(createLoc(false, tempLV.terminal,
                    tempLV.inFloor, tempLV.xValue, tempLV.yValue));
                Location currLoc = createLoc(false, tempLV.terminal,
                    tempLV.toFloor, tempLV.xTo, tempLV.yTo);
                navigations.add(currLoc);
                tempInit = currLoc;
              }
            } else {
              if (tempInit.terminal != '3' && tempInit.floor == '1') {
                navigations.add(await closestDest(tempInit, "Skytrain"));
                var newTerminal = locList.firstWhere((loc) =>
                    loc.terminal == destination.terminal &&
                    loc.category == "Skytrain");
                navigations.add(newTerminal);
                tempInit = newTerminal;
              } else if (tempInit.terminal != '3' && tempInit.floor != '1') {
                Elevate tempLV = await closestElevate(tempInit, '1');
                navigations.add(createLoc(false, tempLV.terminal,
                    tempLV.inFloor, tempLV.xValue, tempLV.yValue));
                Location currLoc = createLoc(false, tempLV.terminal,
                    tempLV.toFloor, tempLV.xTo, tempLV.yTo);
                navigations.add(currLoc);
                tempInit = currLoc;
              } else if (tempInit.terminal == '3' && tempInit.floor == '3') {
                navigations.add(await closestDest(tempInit, "Skytrain"));
                var newTerminal = locList.firstWhere((loc) =>
                    loc.terminal == destination.terminal &&
                    loc.category == "Skytrain");
                navigations.add(newTerminal);
                tempInit = newTerminal;
              } else if (tempInit.terminal == '3' && tempInit.floor != '3') {
                Elevate tempLV = await closestElevate(tempInit, '3');
                navigations.add(createLoc(false, tempLV.terminal,
                    tempLV.inFloor, tempLV.xValue, tempLV.yValue));
                Location currLoc = createLoc(false, tempLV.terminal,
                    tempLV.toFloor, tempLV.xTo, tempLV.yTo);
                navigations.add(currLoc);
                tempInit = currLoc;
              }
            }
          }
        } else {
          Elevate tempLV = await closestElevate(tempInit, destination.floor);
          navigations.add(createLoc(false, tempLV.terminal, tempLV.inFloor,
              tempLV.xValue, tempLV.yValue));
          Location currLoc = createLoc(
              false, tempLV.terminal, tempLV.toFloor, tempLV.xTo, tempLV.yTo);
          navigations.add(currLoc);
          tempInit = currLoc;
        }
      } else {
        if (tempInit.terminal != '3' && tempInit.floor == '1') {
          navigations.add(await closestDest(tempInit, "Skytrain"));
          var newTerminal = locList.firstWhere((loc) =>
              loc.terminal == destination.terminal &&
              loc.category == "Skytrain");
          navigations.add(newTerminal);
          tempInit = newTerminal;
        } else if (tempInit.terminal != '3' && tempInit.floor != '1') {
          Elevate tempLV = await closestElevate(tempInit, '1');
          navigations.add(createLoc(false, tempLV.terminal, tempLV.inFloor,
              tempLV.xValue, tempLV.yValue));
          Location currLoc = createLoc(
              false, tempLV.terminal, tempLV.toFloor, tempLV.xTo, tempLV.yTo);
          navigations.add(currLoc);
          tempInit = currLoc;
        } else if (tempInit.terminal == '3' && tempInit.floor == '3') {
          navigations.add(await closestDest(tempInit, "Skytrain"));
          var newTerminal = locList.firstWhere((loc) =>
              loc.terminal == destination.terminal &&
              loc.category == "Skytrain");
          navigations.add(newTerminal);
          tempInit = newTerminal;
        } else if (tempInit.terminal == '3' && tempInit.floor != '3') {
          Elevate tempLV = await closestElevate(tempInit, '3');
          navigations.add(createLoc(false, tempLV.terminal, tempLV.inFloor,
              tempLV.xValue, tempLV.yValue));
          Location currLoc = createLoc(
              false, tempLV.terminal, tempLV.toFloor, tempLV.xTo, tempLV.yTo);
          navigations.add(currLoc);
          tempInit = currLoc;
        }
      }
    }
  }
  return navigations;
}
