import 'package:angkasapp/util/const.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import '../util/a_star_algo.dart';
import '../util/map_util.dart';

typedef Pair = Tuple2<int, int>;

class PathMap extends CustomPainter {
  final List<Pair> trace;

  PathMap({required this.trace});
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    for (int i = 0; i < trace.length; i++) {
      if (i + 1 < trace.length) {
        final Path path = Path()
          ..moveTo(trace[i].item2.toDouble(), trace[i].item1.toDouble())
          ..lineTo(
              trace[i + 1].item2.toDouble(), trace[i + 1].item1.toDouble());
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
      const Offset(307, 234),
      0.5,
      Paint()
        ..color = Colors.red
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

Future<PathMap> createPathMap(Location source, Location dest) async {
  List<Pair> trace = await aStarTry(source.xValue, source.yValue, dest.xValue,
      dest.yValue, pathLink(source.terminal, source.floor));
  return PathMap(trace: trace);
}
