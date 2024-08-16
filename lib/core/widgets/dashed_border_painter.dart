import 'dart:ui';
import 'package:filehive/core/utils/colors.dart';
import 'package:flutter/material.dart';

class DashedBorderPainter extends CustomPainter {
  final Color color;
  final double gap;
  final double strokeWidth;
  final double radius;

  DashedBorderPainter({
    this.color = kSecondaryColor,
    this.gap = 11.0,
    this.strokeWidth = 2.0,
    this.radius = 10,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height),
          Radius.circular(radius)));

    Path dashedPath = _createDashedPath(path, gap);

    canvas.drawPath(dashedPath, paint);
  }

  Path _createDashedPath(Path path, double gap) {
    final dashedPath = Path();
    double distance = 0.0;
    for (PathMetric pathMetric in path.computeMetrics()) {
      while (distance < pathMetric.length) {
        final length = distance + gap;
        dashedPath.addPath(
            pathMetric.extractPath(distance, length), Offset.zero);
        distance += gap * 2;
      }
    }
    return dashedPath;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
