import 'package:flutter/material.dart';

class VerticalDottedLinPainter extends CustomPainter {
  final Color color;
  final double dotRadius;
  final double spacing;

  VerticalDottedLinPainter({
    required this.color,
    this.dotRadius = 1.5,
    this.spacing = 3.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = dotRadius * 2;

    for (double y = 0; y < size.height; y += dotRadius * 2 + spacing) {
      canvas.drawCircle(Offset(size.width / 2, y), dotRadius, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
