
import 'package:flutter/material.dart';
import '../../constants/colors_resources.dart';

class GlobalDottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashWidth = 5.0, dashSpace = 3.0;
    final paint = Paint()
      ..color = ColorRes.grey
      ..strokeWidth = 1.0;

    double startX = 0;
    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}