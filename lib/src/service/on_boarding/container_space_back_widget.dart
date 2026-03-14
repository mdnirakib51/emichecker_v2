import 'dart:math';
import 'package:flutter/material.dart';
import '../../global/constants/colors_resources.dart';

class ContainerSpaceBackWidget extends StatefulWidget {
  final Widget child;
  const ContainerSpaceBackWidget({super.key, required this.child});

  @override
  State<ContainerSpaceBackWidget> createState() =>
      _ContainerSpaceBackWidgetState();
}

class _ContainerSpaceBackWidgetState extends State<ContainerSpaceBackWidget>
    with TickerProviderStateMixin {
  late AnimationController _floatController;
  late AnimationController _pulseController;
  late AnimationController _signalController;
  late AnimationController _scanController;

  late Animation<double> _floatAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _signalAnimation;
  late Animation<double> _scanAnimation;

  @override
  void initState() {
    super.initState();

    // Floating devices animation
    _floatController = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );
    _floatAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );

    // Signal/WiFi pulse animation
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeOut),
    );

    // Circuit signal flow animation
    _signalController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    _signalAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _signalController, curve: Curves.linear),
    );

    // Scan line animation
    _scanController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );
    _scanAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _scanController, curve: Curves.linear),
    );

    _floatController.repeat(reverse: true);
    _pulseController.repeat();
    _signalController.repeat();
    _scanController.repeat();
  }

  @override
  void dispose() {
    _floatController.dispose();
    _pulseController.dispose();
    _signalController.dispose();
    _scanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: ColorRes.appBackColor,
      ),
      child: Stack(
        children: [
          // Circuit board pattern background
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _signalAnimation,
              builder: (context, child) => CustomPaint(
                painter: CircuitBoardPainter(_signalAnimation.value),
              ),
            ),
          ),

          // Scan line overlay
          // AnimatedBuilder(
          //   animation: _scanAnimation,
          //   builder: (context, child) => Positioned.fill(
          //     child: CustomPaint(
          //       painter: ScanLinePainter(_scanAnimation.value),
          //     ),
          //   ),
          // ),

          // Smartphone icon - top right floating
          AnimatedBuilder(
            animation: _floatAnimation,
            builder: (context, child) => Positioned(
              top: 25 + (sin(_floatAnimation.value * pi) * 12),
              right: 20 + (cos(_floatAnimation.value * pi * 0.5) * 5),
              child: Opacity(
                opacity: 0.18,
                child: CustomPaint(
                  size: const Size(50, 80),
                  painter: SmartphonePainter(color: ColorRes.appColor),
                ),
              ),
            ),
          ),

          // Laptop/TV icon - top left floating
          AnimatedBuilder(
            animation: _floatAnimation,
            builder: (context, child) => Positioned(
              top: 40 + (cos(_floatAnimation.value * pi + 1) * 10),
              left: 15 + (sin(_floatAnimation.value * pi + 1) * 7),
              child: Opacity(
                opacity: 0.15,
                child: CustomPaint(
                  size: const Size(80, 55),
                  painter: LaptopPainter(color: ColorRes.appColor),
                ),
              ),
            ),
          ),

          // WiFi signal rings - mid right
          AnimatedBuilder(
            animation: _pulseAnimation,
            builder: (context, child) => Positioned(
              top: 160,
              right: 30,
              child: CustomPaint(
                size: const Size(60, 60),
                painter: WifiSignalPainter(
                  animValue: _pulseAnimation.value,
                  color: ColorRes.appColor,
                ),
              ),
            ),
          ),

          // Battery icon floating - bottom left
          AnimatedBuilder(
            animation: _floatAnimation,
            builder: (context, child) => Positioned(
              bottom: 200 + (sin(_floatAnimation.value * pi + 2) * 15),
              left: 20 + (cos(_floatAnimation.value * pi + 2) * 8),
              child: Opacity(
                opacity: 0.15,
                child: CustomPaint(
                  size: const Size(45, 22),
                  painter: BatteryPainter(color: ColorRes.appColor),
                ),
              ),
            ),
          ),

          // Headphone icon - bottom right floating
          AnimatedBuilder(
            animation: _floatAnimation,
            builder: (context, child) => Positioned(
              bottom: 150 + (cos(_floatAnimation.value * pi + 3) * 12),
              right: 25 + (sin(_floatAnimation.value * pi + 3) * 6),
              child: Opacity(
                opacity: 0.14,
                child: CustomPaint(
                  size: const Size(55, 55),
                  painter: HeadphonePainter(color: ColorRes.appColor),
                ),
              ),
            ),
          ),

          // Small floating EMI chip/card
          AnimatedBuilder(
            animation: _floatAnimation,
            builder: (context, child) => Positioned(
              top: 120 + (sin(_floatAnimation.value * pi + 1.5) * 10),
              left: 35 + (cos(_floatAnimation.value * pi + 1.5) * 6),
              child: Opacity(
                opacity: 0.17,
                child: CustomPaint(
                  size: const Size(40, 28),
                  painter: ChipCardPainter(color: ColorRes.appColor),
                ),
              ),
            ),
          ),

          // TV icon
          AnimatedBuilder(
            animation: _floatAnimation,
            builder: (context, child) => Positioned(
              bottom: 280 + (cos(_floatAnimation.value * pi + 4) * 8),
              right: 40 + (sin(_floatAnimation.value * pi + 4) * 5),
              child: Opacity(
                opacity: 0.13,
                child: CustomPaint(
                  size: const Size(60, 45),
                  painter: TvPainter(color: ColorRes.appColor),
                ),
              ),
            ),
          ),

          // Glowing signal dots
          ...List.generate(6, (index) {
            final dotPositions = [
              {'top': 80.0, 'left': 70.0},
              {'top': 200.0, 'right': 90.0},
              {'top': 300.0, 'left': 55.0},
              {'bottom': 250.0, 'left': 90.0},
              {'bottom': 130.0, 'right': 60.0},
              {'top': 170.0, 'left': 30.0},
            ];

            return AnimatedBuilder(
              animation: _pulseAnimation,
              builder: (context, child) {
                double phase = (index / 6);
                double opacity =
                (sin((_pulseAnimation.value - phase) * 2 * pi) * 0.5 + 0.5)
                    .clamp(0.05, 0.3);

                return Positioned(
                  top: dotPositions[index]['top'],
                  left: dotPositions[index]['left'],
                  right: dotPositions[index]['right'],
                  bottom: dotPositions[index]['bottom'],
                  child: Opacity(
                    opacity: opacity,
                    child: Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorRes.appColor,
                        boxShadow: [
                          BoxShadow(
                            color: ColorRes.appColor.withValues(alpha: 0.5),
                            blurRadius: 6,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }),

          // Main content
          Positioned.fill(
            child: widget.child,
          ),
        ],
      ),
    );
  }
}

// ─── Circuit Board Pattern ───────────────────────────────────────────────────
class CircuitBoardPainter extends CustomPainter {
  final double animValue;
  CircuitBoardPainter(this.animValue);

  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = ColorRes.appColor.withValues(alpha: 0.07)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    final nodePaint = Paint()
      ..color = ColorRes.appColor.withValues(alpha: 0.12)
      ..style = PaintingStyle.fill;

    final signalPaint = Paint()
      ..color = ColorRes.appColor.withValues(alpha: 0.25)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    // Horizontal circuit lines
    final hLines = [
      size.height * 0.15,
      size.height * 0.35,
      size.height * 0.55,
      size.height * 0.72,
      size.height * 0.88,
    ];

    // Vertical circuit lines
    final vLines = [
      size.width * 0.1,
      size.width * 0.3,
      size.width * 0.55,
      size.width * 0.75,
      size.width * 0.92,
    ];

    for (var y in hLines) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), linePaint);
    }
    for (var x in vLines) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), linePaint);
    }

    // Draw nodes at intersections
    for (var y in hLines) {
      for (var x in vLines) {
        canvas.drawCircle(Offset(x, y), 3, nodePaint);
        canvas.drawCircle(Offset(x, y), 3, linePaint);
      }
    }

    // Animated signal traveling along horizontal lines
    for (int i = 0; i < hLines.length; i++) {
      double phase = (i / hLines.length);
      double signalX =
          ((animValue + phase) % 1.0) * size.width;

      canvas.drawLine(
        Offset(signalX - 20, hLines[i]),
        Offset(signalX, hLines[i]),
        signalPaint..color = ColorRes.appColor.withValues(alpha: 0.3),
      );

      // Signal dot
      canvas.drawCircle(
        Offset(signalX, hLines[i]),
        3,
        Paint()
          ..color = ColorRes.appColor.withValues(alpha: 0.4)
          ..style = PaintingStyle.fill,
      );
    }

    // Small component boxes along lines
    final compPaint = Paint()
      ..color = ColorRes.appColor.withValues(alpha: 0.09)
      ..style = PaintingStyle.fill;
    final compBorderPaint = Paint()
      ..color = ColorRes.appColor.withValues(alpha: 0.13)
      ..strokeWidth = 0.8
      ..style = PaintingStyle.stroke;

    final components = [
      Offset(size.width * 0.3, size.height * 0.15),
      Offset(size.width * 0.75, size.height * 0.35),
      Offset(size.width * 0.1, size.height * 0.55),
      Offset(size.width * 0.55, size.height * 0.72),
      Offset(size.width * 0.92, size.height * 0.88),
    ];

    for (var pos in components) {
      final rect = Rect.fromCenter(center: pos, width: 18, height: 10);
      canvas.drawRect(rect, compPaint);
      canvas.drawRect(rect, compBorderPaint);
      // Component leads
      canvas.drawLine(
          Offset(pos.dx - 12, pos.dy), Offset(pos.dx - 9, pos.dy), compBorderPaint);
      canvas.drawLine(
          Offset(pos.dx + 9, pos.dy), Offset(pos.dx + 12, pos.dy), compBorderPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// ─── Scan Line ───────────────────────────────────────────────────────────────
class ScanLinePainter extends CustomPainter {
  final double animValue;
  ScanLinePainter(this.animValue);

  @override
  void paint(Canvas canvas, Size size) {
    final y = animValue * size.height;
    final paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          ColorRes.appColor.withValues(alpha: 0.0),
          ColorRes.appColor.withValues(alpha: 0.06),
          ColorRes.appColor.withValues(alpha: 0.0),
        ],
      ).createShader(Rect.fromLTWH(0, y - 30, size.width, 60));

    canvas.drawRect(
      Rect.fromLTWH(0, y - 30, size.width, 60),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// ─── Smartphone Painter ───────────────────────────────────────────────────────
class SmartphonePainter extends CustomPainter {
  final Color color;
  SmartphonePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final fillPaint = Paint()
      ..color = color.withValues(alpha: 0.15)
      ..style = PaintingStyle.fill;

    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      const Radius.circular(8),
    );

    canvas.drawRRect(rrect, fillPaint);
    canvas.drawRRect(rrect, paint);

    // Screen area
    final screenPaint = Paint()
      ..color = color.withValues(alpha: 0.25)
      ..style = PaintingStyle.fill;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(4, 8, size.width - 8, size.height - 18),
        const Radius.circular(4),
      ),
      screenPaint,
    );

    // Home button
    canvas.drawCircle(
      Offset(size.width / 2, size.height - 5),
      3,
      paint,
    );

    // Camera
    canvas.drawCircle(
      Offset(size.width / 2, 4),
      2,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ─── Laptop Painter ───────────────────────────────────────────────────────────
class LaptopPainter extends CustomPainter {
  final Color color;
  LaptopPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.8
      ..style = PaintingStyle.stroke;

    final fillPaint = Paint()
      ..color = color.withValues(alpha: 0.12)
      ..style = PaintingStyle.fill;

    // Screen part
    final screen = RRect.fromRectAndRadius(
      Rect.fromLTWH(5, 0, size.width - 10, size.height * 0.65),
      const Radius.circular(4),
    );
    canvas.drawRRect(screen, fillPaint);
    canvas.drawRRect(screen, paint);

    // Screen content lines
    for (int i = 0; i < 3; i++) {
      double y = 6 + (i * 7.0);
      canvas.drawLine(
        Offset(10, y),
        Offset(size.width - 10, y),
        Paint()
          ..color = color.withValues(alpha: 0.3)
          ..strokeWidth = 1.2,
      );
    }

    // Base/keyboard
    final base = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, size.height * 0.65, size.width, size.height * 0.35),
      const Radius.circular(3),
    );
    canvas.drawRRect(base, fillPaint);
    canvas.drawRRect(base, paint);

    // Touchpad
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
            size.width * 0.35, size.height * 0.72, size.width * 0.3, size.height * 0.2),
        const Radius.circular(2),
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ─── WiFi Signal Painter ──────────────────────────────────────────────────────
class WifiSignalPainter extends CustomPainter {
  final double animValue;
  final Color color;
  WifiSignalPainter({required this.animValue, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height * 0.75);

    for (int i = 3; i >= 1; i--) {
      double progress = (animValue - (i - 1) * 0.2).clamp(0.0, 1.0);
      double radius = (size.width * 0.15 * i);
      double opacity = (0.4 - (i * 0.08)) * (1 - progress * 0.5);

      if (opacity <= 0) continue;

      final paint = Paint()
        ..color = color.withValues(alpha: opacity)
        ..strokeWidth = 1.8
        ..style = PaintingStyle.stroke;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius * progress),
        -3 * pi / 4,
        pi / 2 * -1,
        false,
        paint,
      );
    }

    // Center dot
    canvas.drawCircle(
      center,
      3,
      Paint()
        ..color = color.withValues(alpha: 0.5)
        ..style = PaintingStyle.fill,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// ─── Battery Painter ──────────────────────────────────────────────────────────
class BatteryPainter extends CustomPainter {
  final Color color;
  BatteryPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.8
      ..style = PaintingStyle.stroke;

    // Battery body
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width * 0.88, size.height),
        const Radius.circular(3),
      ),
      paint,
    );

    // Battery tip
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
            size.width * 0.9, size.height * 0.3, size.width * 0.1, size.height * 0.4),
        const Radius.circular(2),
      ),
      Paint()
        ..color = color
        ..style = PaintingStyle.fill,
    );

    // Fill level (70%)
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(3, 3, size.width * 0.55, size.height - 6),
        const Radius.circular(2),
      ),
      Paint()
        ..color = color.withValues(alpha: 0.5)
        ..style = PaintingStyle.fill,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ─── Headphone Painter ────────────────────────────────────────────────────────
class HeadphonePainter extends CustomPainter {
  final Color color;
  HeadphonePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Headband arc
    canvas.drawArc(
      Rect.fromLTWH(5, 0, size.width - 10, size.height * 0.8),
      pi,
      pi,
      false,
      paint,
    );

    // Left ear cup
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, size.height * 0.55, size.width * 0.28, size.height * 0.38),
        const Radius.circular(5),
      ),
      paint,
    );

    // Right ear cup
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
            size.width * 0.72, size.height * 0.55, size.width * 0.28, size.height * 0.38),
        const Radius.circular(5),
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ─── Chip/Card Painter ────────────────────────────────────────────────────────
class ChipCardPainter extends CustomPainter {
  final Color color;
  ChipCardPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final fillPaint = Paint()
      ..color = color.withValues(alpha: 0.15)
      ..style = PaintingStyle.fill;

    // Card body
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        const Radius.circular(4),
      ),
      fillPaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        const Radius.circular(4),
      ),
      paint,
    );

    // Chip
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
            size.width * 0.2, size.height * 0.25, size.width * 0.3, size.height * 0.5),
        const Radius.circular(2),
      ),
      Paint()
        ..color = color.withValues(alpha: 0.4)
        ..style = PaintingStyle.fill,
    );

    // Horizontal stripe
    canvas.drawLine(
      Offset(size.width * 0.6, size.height * 0.4),
      Offset(size.width * 0.9, size.height * 0.4),
      paint,
    );
    canvas.drawLine(
      Offset(size.width * 0.6, size.height * 0.6),
      Offset(size.width * 0.9, size.height * 0.6),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ─── TV Painter ───────────────────────────────────────────────────────────────
class TvPainter extends CustomPainter {
  final Color color;
  TvPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.8
      ..style = PaintingStyle.stroke;

    final fillPaint = Paint()
      ..color = color.withValues(alpha: 0.1)
      ..style = PaintingStyle.fill;

    // TV body
    final body = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height * 0.78),
      const Radius.circular(5),
    );
    canvas.drawRRect(body, fillPaint);
    canvas.drawRRect(body, paint);

    // Screen inner
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(5, 5, size.width - 10, size.height * 0.68),
        const Radius.circular(3),
      ),
      Paint()
        ..color = color.withValues(alpha: 0.2)
        ..style = PaintingStyle.fill,
    );

    // Stand
    canvas.drawLine(
      Offset(size.width * 0.4, size.height * 0.78),
      Offset(size.width * 0.4, size.height),
      paint,
    );
    canvas.drawLine(
      Offset(size.width * 0.6, size.height * 0.78),
      Offset(size.width * 0.6, size.height),
      paint,
    );
    canvas.drawLine(
      Offset(size.width * 0.25, size.height),
      Offset(size.width * 0.75, size.height),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}