import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import '../a_star_algo.dart';
import '../map_path_set.dart';

typedef Pair = Tuple2<int, int>;

class PathMap extends CustomPainter {
  final List<Pair> trace;

  PathMap({required this.trace});
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    for (int i = 0; i < trace.length; i++) {
      if (i + 1 < trace.length) {
        final Path path = Path()
          ..moveTo(
              trace[i].item2.toDouble() - 1.5, trace[i].item1.toDouble() - 1.5)
          ..lineTo(trace[i + 1].item2.toDouble() - 1.5,
              trace[i + 1].item1.toDouble() - 1.5);
        canvas.drawPath(path, paint);
      }
    }
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
          // final Offset coordinate = Offset(j.toDouble() - 1.5, i.toDouble() - 1.5);
          final Offset coordinate = Offset(j.toDouble(), i.toDouble());
          canvas.drawCircle(coordinate, 0.3, paintDot);
          // print("(x = $j, y = $i)");
        }
      }
    }

    canvas.drawCircle(
      const Offset(302, 240),
      1,
      Paint()
        ..color = Colors.green
        ..style = PaintingStyle.fill,
    );
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

Future<PathMap> createPathMap() async {
  List<Pair> trace = await aStarTry();
  return PathMap(trace: trace);
}
