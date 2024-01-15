import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;

import 'const.dart';
import 'image_size.dart';

Future<img.Image?> loadImage(String path) async {
  // Load the image from the given path
  ImageDetail imageDetail = await getImageDimensions(pT2L1r);
  return img.decodeImage(Uint8List.fromList(imageDetail.bytes!));
}

img.Image resizeImage(img.Image originalImage) {
  // Resize the image to 400x400
  return img.copyResize(originalImage, width: 400, height: 400);
}

List<List<int>> convertImageToGrid(img.Image resizedImage) {
  // Convert the resized image to a grid
  return List.generate(
    resizedImage.height,
    (i) => List.generate(
      resizedImage.width,
      (j) {
        final pixel = resizedImage.getPixel(j, i);
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

    // Resize the image to 400x400
    img.Image resizedImage = resizeImage(originalImage);

    RGBaValue(resizedImage, 200, 180);

    // Convert the resized image to a grid
    List<List<int>> grid = convertImageToGrid(resizedImage);

    return grid;
  }
}

bool isPath(int pixel) {
  // Get the R, G, and B components of the pixel color
  int red = img.getRed(pixel);
  int green = img.getGreen(pixel);
  int blue = img.getBlue(pixel);

  // Define your target color values
  int targetRed = 204;
  int targetGreen = 204;
  int targetBlue = 210;

  // Define a tolerance range for each color channel
  int tolerance = 20;

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
  // Process the image using the ImageProcessor class
  List<List<int>> grid = await ImageProcessor.processCustomMap(path);

  return grid;
}
