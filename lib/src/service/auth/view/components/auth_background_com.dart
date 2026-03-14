import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../global/constants/colors_resources.dart';
import '../../../../global/widget/global_container.dart';
import '../../../../global/widget/global_sized_box.dart';
import '../../controller/auth_controller.dart';

class AuthBackGroundCom extends StatefulWidget {
  final List<Widget> children;
  const AuthBackGroundCom({
    super.key,
    this.children = const <Widget>[],
  });

  @override
  State<AuthBackGroundCom> createState() => _AuthBackGroundComState();
}

class _AuthBackGroundComState extends State<AuthBackGroundCom>
    with TickerProviderStateMixin {
  late AnimationController _circuitController;
  late AnimationController _pulseController;
  late AnimationController _floatController;

  late Animation<double> _circuitAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _floatAnimation;

  @override
  void initState() {
    super.initState();

    _circuitController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );
    _circuitAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _circuitController, curve: Curves.linear),
    );

    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _floatController = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );
    _floatAnimation = Tween<double>(begin: -8, end: 8).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOutSine),
    );

    _circuitController.repeat();
    _pulseController.repeat(reverse: true);
    _floatController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _circuitController.dispose();
    _pulseController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return GetBuilder<AuthController>(builder: (authController) {
      return GlobalContainer(
        height: h,
        width: w,
        color: Colors.white,
        child: Stack(
          children: [
            // ── White base background
            Container(width: w, height: h, color: Colors.white),

            // ── Top curved shape (static)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: CustomPaint(
                size: Size(w, h * 0.34),
                painter: TopElectronicsCurvePainter(),
              ),
            ),

            // ── Bottom curved shape (static)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: CustomPaint(
                size: Size(w, h * 0.22),
                painter: BottomElectronicsCurvePainter(),
              ),
            ),

            // ── Animated circuit lines on top area
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: h * 0.34,
              child: AnimatedBuilder(
                animation: _circuitAnimation,
                builder: (context, child) => CustomPaint(
                  painter: TopCircuitAnimationPainter(_circuitAnimation.value),
                ),
              ),
            ),

            // ── Animated circuit lines on bottom area
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: h * 0.22,
              child: AnimatedBuilder(
                animation: _circuitAnimation,
                builder: (context, child) => CustomPaint(
                  painter: BottomCircuitAnimationPainter(
                      _circuitAnimation.value),
                ),
              ),
            ),

            // ── Floating tech icons — top area
            AnimatedBuilder(
              animation: Listenable.merge([_floatAnimation, _pulseAnimation]),
              builder: (context, child) {
                return Stack(children: [
                  // Smartphone icon top-right
                  Positioned(
                    top: 18 + _floatAnimation.value * 0.6,
                    right: 22,
                    child: Opacity(
                      opacity: 0.35,
                      child: CustomPaint(
                        size: const Size(32, 52),
                        painter: MiniSmartphonePainter(),
                      ),
                    ),
                  ),

                  // WiFi arcs top-left
                  Positioned(
                    top: 30 + _floatAnimation.value * 0.4,
                    left: 20,
                    child: Opacity(
                      opacity: 0.3,
                      child: CustomPaint(
                        size: const Size(40, 40),
                        painter: MiniWifiPainter(_pulseAnimation.value),
                      ),
                    ),
                  ),

                  // Laptop icon top-center-right
                  Positioned(
                    top: 55 + _floatAnimation.value * 0.5,
                    right: 80,
                    child: Opacity(
                      opacity: 0.25,
                      child: CustomPaint(
                        size: const Size(42, 30),
                        painter: MiniLaptopPainter(),
                      ),
                    ),
                  ),

                  // Small pulse rings
                  Positioned(
                    top: 70 + _floatAnimation.value * 0.3,
                    left: 70,
                    child: Transform.scale(
                      scale: 0.8 + _pulseAnimation.value * 0.4,
                      child: Opacity(
                        opacity: (1 - _pulseAnimation.value) * 0.3,
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 1.5,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Bottom floating icons
                  Positioned(
                    bottom: h * 0.22 - 10 - _floatAnimation.value.abs(),
                    left: 18,
                    child: Opacity(
                      opacity: 0.28,
                      child: CustomPaint(
                        size: const Size(36, 22),
                        painter: MiniBatteryPainter(),
                      ),
                    ),
                  ),

                  Positioned(
                    bottom: h * 0.22 + 20 + _floatAnimation.value * 0.5,
                    right: 25,
                    child: Opacity(
                      opacity: 0.25,
                      child: Transform.scale(
                        scale: 0.9 + _pulseAnimation.value * 0.2,
                        child: CustomPaint(
                          size: const Size(38, 38),
                          painter: MiniTvPainter(),
                        ),
                      ),
                    ),
                  ),
                ]);
              },
            ),

            // ── Main content
            Positioned(
              left: 10,
              right: 10,
              bottom: 0,
              top: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widget.children,
              ),
            ),
          ],
        ),
      );
    });
  }
}

// ─── Top Curve Painter ───────────────────────────────────────────────────────
class TopElectronicsCurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Accent layer (slightly lighter shade)
    final accentPaint = Paint()
      ..color = ColorRes.appColor.withValues(alpha: 0.55);

    final accentPath = Path();
    accentPath.moveTo(0, 0);
    accentPath.lineTo(size.width, 0);
    accentPath.lineTo(size.width, size.height * 0.55);
    accentPath.quadraticBezierTo(
      size.width * 0.75, size.height * 0.95,
      size.width * 0.45, size.height * 0.85,
    );
    accentPath.quadraticBezierTo(
      size.width * 0.2, size.height * 0.75,
      0, size.height * 0.9,
    );
    accentPath.close();
    canvas.drawPath(accentPath, accentPaint);

    // Main color layer
    final mainPaint = Paint()..color = ColorRes.appColor;

    final mainPath = Path();
    mainPath.moveTo(0, 0);
    mainPath.lineTo(size.width, 0);
    mainPath.lineTo(size.width, size.height * 0.4);
    mainPath.quadraticBezierTo(
      size.width * 0.65, size.height * 0.85,
      size.width * 0.35, size.height * 0.75,
    );
    mainPath.quadraticBezierTo(
      size.width * 0.1, size.height * 0.65,
      0, size.height * 0.75,
    );
    mainPath.close();
    canvas.drawPath(mainPath, mainPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ─── Bottom Curve Painter ────────────────────────────────────────────────────
class BottomElectronicsCurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Accent layer
    final accentPaint = Paint()
      ..color = ColorRes.appColor.withValues(alpha: 0.55);

    final accentPath = Path();
    accentPath.moveTo(0, size.height);
    accentPath.lineTo(size.width, size.height);
    accentPath.lineTo(size.width, size.height * 0.5);
    accentPath.quadraticBezierTo(
      size.width * 0.75, size.height * 0.05,
      size.width * 0.45, size.height * 0.2,
    );
    accentPath.quadraticBezierTo(
      size.width * 0.2, size.height * 0.3,
      0, size.height * 0.15,
    );
    accentPath.close();
    canvas.drawPath(accentPath, accentPaint);

    // Main color layer
    final mainPaint = Paint()..color = ColorRes.appColor;

    final mainPath = Path();
    mainPath.moveTo(0, size.height);
    mainPath.lineTo(size.width, size.height);
    mainPath.lineTo(size.width, size.height * 0.65);
    mainPath.quadraticBezierTo(
      size.width * 0.6, size.height * 0.1,
      size.width * 0.3, size.height * 0.28,
    );
    mainPath.quadraticBezierTo(
      size.width * 0.1, size.height * 0.4,
      0, size.height * 0.3,
    );
    mainPath.close();
    canvas.drawPath(mainPath, mainPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ─── Top Circuit Animation ───────────────────────────────────────────────────
class TopCircuitAnimationPainter extends CustomPainter {
  final double animValue;
  TopCircuitAnimationPainter(this.animValue);

  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.12)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    final signalPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.5)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final nodePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.3)
      ..style = PaintingStyle.fill;

    // Horizontal circuit traces
    final traces = [
      {'y': size.height * 0.25, 'phase': 0.0},
      {'y': size.height * 0.45, 'phase': 0.35},
      {'y': size.height * 0.65, 'phase': 0.7},
    ];

    for (var trace in traces) {
      double y = trace['y']!;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), linePaint);

      // Animated signal dot
      double phase = trace['phase']!;
      double sigX = ((animValue + phase) % 1.0) * size.width;
      double trailLen = 25.0;

      canvas.drawLine(
        Offset((sigX - trailLen).clamp(0, size.width), y),
        Offset(sigX, y),
        signalPaint,
      );
      canvas.drawCircle(Offset(sigX, y), 2.5, nodePaint);
    }

    // Vertical connectors
    final vLines = [size.width * 0.2, size.width * 0.5, size.width * 0.8];
    for (var x in vLines) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), linePaint);
      // Node dots at intersections
      for (var trace in traces) {
        canvas.drawCircle(Offset(x, trace['y']!), 3, nodePaint);
      }
    }

    // Small component rectangles
    final compPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.15)
      ..style = PaintingStyle.fill;
    final compBorder = Paint()
      ..color = Colors.white.withValues(alpha: 0.2)
      ..strokeWidth = 0.8
      ..style = PaintingStyle.stroke;

    final comps = [
      Offset(size.width * 0.2, size.height * 0.25),
      Offset(size.width * 0.5, size.height * 0.45),
      Offset(size.width * 0.8, size.height * 0.65),
    ];
    for (var c in comps) {
      final r = Rect.fromCenter(center: c, width: 14, height: 8);
      canvas.drawRect(r, compPaint);
      canvas.drawRect(r, compBorder);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// ─── Bottom Circuit Animation ────────────────────────────────────────────────
class BottomCircuitAnimationPainter extends CustomPainter {
  final double animValue;
  BottomCircuitAnimationPainter(this.animValue);

  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.12)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    final signalPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.45)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final nodePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.3)
      ..style = PaintingStyle.fill;

    final traces = [
      {'y': size.height * 0.35, 'phase': 0.2},
      {'y': size.height * 0.6, 'phase': 0.6},
    ];

    for (var trace in traces) {
      double y = trace['y']!;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), linePaint);

      double phase = trace['phase']!;
      // Reversed signal direction
      double sigX = size.width - ((animValue + phase) % 1.0) * size.width;
      double trailLen = 22.0;

      canvas.drawLine(
        Offset(sigX, y),
        Offset((sigX + trailLen).clamp(0, size.width), y),
        signalPaint,
      );
      canvas.drawCircle(Offset(sigX, y), 2.5, nodePaint);
    }

    // Vertical lines
    final vLines = [size.width * 0.25, size.width * 0.6];
    for (var x in vLines) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), linePaint);
      for (var trace in traces) {
        canvas.drawCircle(Offset(x, trace['y']!), 3, nodePaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// ─── Mini Icon Painters ───────────────────────────────────────────────────────
class MiniSmartphonePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = Colors.white
      ..strokeWidth = 1.8
      ..style = PaintingStyle.stroke;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height),
          const Radius.circular(6)),
      p,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
          Rect.fromLTWH(3, 5, size.width - 6, size.height - 12),
          const Radius.circular(3)),
      Paint()
        ..color = Colors.white.withValues(alpha: 0.3)
        ..style = PaintingStyle.fill,
    );
    canvas.drawCircle(Offset(size.width / 2, size.height - 4), 2.5, p);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class MiniWifiPainter extends CustomPainter {
  final double animValue;
  MiniWifiPainter(this.animValue);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height * 0.8);
    for (int i = 3; i >= 1; i--) {
      double progress = ((animValue - (i - 1) * 0.25).clamp(0.0, 1.0));
      final p = Paint()
        ..color = Colors.white.withValues(alpha: (0.5 - i * 0.1) * progress)
        ..strokeWidth = 1.8
        ..style = PaintingStyle.stroke;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: (i * 8.0) * progress),
        -3 * pi / 4,
        -pi / 2,
        false,
        p,
      );
    }
    canvas.drawCircle(
      center,
      2.5,
      Paint()
        ..color = Colors.white.withValues(alpha: 0.6)
        ..style = PaintingStyle.fill,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class MiniLaptopPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = Colors.white
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    // Screen
    canvas.drawRRect(
      RRect.fromRectAndRadius(
          Rect.fromLTWH(3, 0, size.width - 6, size.height * 0.65),
          const Radius.circular(3)),
      p,
    );
    // Base
    canvas.drawRRect(
      RRect.fromRectAndRadius(
          Rect.fromLTWH(0, size.height * 0.65, size.width, size.height * 0.35),
          const Radius.circular(2)),
      p,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class MiniBatteryPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = Colors.white
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width * 0.85, size.height),
          const Radius.circular(3)),
      p,
    );
    // Tip
    canvas.drawRRect(
      RRect.fromRectAndRadius(
          Rect.fromLTWH(size.width * 0.87, size.height * 0.3,
              size.width * 0.13, size.height * 0.4),
          const Radius.circular(2)),
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.fill,
    );
    // Fill
    canvas.drawRRect(
      RRect.fromRectAndRadius(
          Rect.fromLTWH(2, 2, size.width * 0.5, size.height - 4),
          const Radius.circular(2)),
      Paint()
        ..color = Colors.white.withValues(alpha: 0.5)
        ..style = PaintingStyle.fill,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class MiniTvPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = Colors.white
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height * 0.75),
          const Radius.circular(4)),
      p,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
          Rect.fromLTWH(4, 4, size.width - 8, size.height * 0.65),
          const Radius.circular(3)),
      Paint()
        ..color = Colors.white.withValues(alpha: 0.2)
        ..style = PaintingStyle.fill,
    );
    // Stand
    canvas.drawLine(Offset(size.width * 0.4, size.height * 0.75),
        Offset(size.width * 0.35, size.height), p);
    canvas.drawLine(Offset(size.width * 0.6, size.height * 0.75),
        Offset(size.width * 0.65, size.height), p);
    canvas.drawLine(
        Offset(size.width * 0.25, size.height), Offset(size.width * 0.75, size.height), p);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}