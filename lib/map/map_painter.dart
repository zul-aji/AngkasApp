import 'package:flutter/material.dart';

import '../map_path_set.dart';

class Path1 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final Path path1 = Path()
      ..moveTo(55, 240)
      ..lineTo(75, 200);

    final Path path2 = Path()
      ..moveTo(75, 200)
      ..lineTo(95, 200);

    final Path path3 = Path()
      ..moveTo(95, 200)
      ..lineTo(100, 190);

    final Paint paintDot = Paint()
      ..color = Colors.blue // Dot color
      ..style = PaintingStyle.fill; // Fill the dot

    const Offset center = Offset(1, 1);

    canvas.drawPath(path1, paint);
    canvas.drawPath(path2, paint);
    canvas.drawPath(path3, paint);

    canvas.drawCircle(center, 1, paintDot);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class DotMap extends CustomPainter {
  final String path;
  final List<List<int>> grid;

  DotMap({
    required this.path,
    required this.grid,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paintDot = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    // Loop through the grid
    for (int i = 0; i < grid.length; i++) {
      for (int j = 0; j < grid[i].length; j++) {
        if (grid[i][j] == 1) {
          // If the cell has a value of 1, paint it with a specific color
          final Offset coordinate = Offset(j.toDouble(), i.toDouble());
          canvas.drawCircle(coordinate, 1, paintDot);
        }
      }
    }

    canvas.drawCircle(
      const Offset(200, 180),
      3,
      Paint()
        ..color = Colors.green
        ..style = PaintingStyle.fill,
    );

    print('paint done');
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

Future<DotMap> createDotMap(String path) async {
  List<List<int>> grid = await setMapList(path);
  return DotMap(path: path, grid: grid);
}
