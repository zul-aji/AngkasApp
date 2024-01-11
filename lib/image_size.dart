import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

class GetImageDimensionsUsingWidgetListener extends StatelessWidget {
  final String imagePath;
  const GetImageDimensionsUsingWidgetListener(
      {Key? key, required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Image image = Image.asset(
      imagePath,
    );

    Completer<ImageDetail> completer = Completer<ImageDetail>();

    image.image
        .resolve(const ImageConfiguration())
        .addListener(ImageStreamListener((ImageInfo imageInfo, bool _) {
      final dimensions = ImageDetail(
        width: imageInfo.image.width,
        height: imageInfo.image.height,
      );
      completer.complete(dimensions);
    }));

    return FutureBuilder(
      future: completer.future,
      builder: (BuildContext context, AsyncSnapshot<ImageDetail> snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }

        return Column(
          children: [
            image,
            Text('1: ${snapshot.data?.width} x ${snapshot.data?.height}')
          ],
        );
      },
    );
  }
}

class GetAssetImageDimensions extends StatelessWidget {
  const GetAssetImageDimensions({Key? key}) : super(key: key);

  Future<ImageDetail> _getImageDimensions(String assetPath) async {
    final byteData = await rootBundle.load(assetPath);
    final bytes = byteData.buffer.asUint8List();
    final decodedImage = await decodeImageFromList(bytes);

    return ImageDetail(
      width: decodedImage.width,
      height: decodedImage.height,
      bytes: bytes,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getImageDimensions('assets/images/flutter.png'),
      builder: (BuildContext context, AsyncSnapshot<ImageDetail> snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }

        return Column(
          children: [
            Image.memory((snapshot.data?.bytes)!),
            Text('${snapshot.data?.width} x ${snapshot.data?.height}')
          ],
        );
      },
    );
  }
}

Future<ImageDetail> getImageDimension(String assetPath) async {
  final byteData = await rootBundle.load(assetPath);
  final bytes = byteData.buffer.asUint8List();
  final decodedImage = await decodeImageFromList(bytes);

  return ImageDetail(
    width: decodedImage.width,
    height: decodedImage.height,
    bytes: bytes,
  );
}

Widget buildImageWidget(ImageDetail imageDetail) {
  return Column(
    children: [
      Image.memory(imageDetail.bytes!),
      Text('4: ${imageDetail.width} x ${imageDetail.height}')
    ],
  );
}
