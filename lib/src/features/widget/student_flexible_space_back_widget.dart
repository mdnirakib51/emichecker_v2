import 'package:flutter/material.dart';

class StudentFlexibleSpaceBackWidget extends StatefulWidget {
  final Widget child;
  const StudentFlexibleSpaceBackWidget({
    super.key,
    required this.child
  });

  @override
  State<StudentFlexibleSpaceBackWidget> createState() => _StudentFlexibleSpaceBackWidgetState();
}

class _StudentFlexibleSpaceBackWidgetState extends State<StudentFlexibleSpaceBackWidget>
    with TickerProviderStateMixin {

  late AnimationController _floatingController;
  late AnimationController _rotationController;
  late AnimationController _pulseController;
  late AnimationController _waveController;

  late Animation<double> _floatingAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _waveAnimation;

  @override
  void initState() {
    super.initState();

    // Floating animation for bubbles
    _floatingController = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );
    _floatingAnimation = Tween<double>(
      begin: -10,
      end: 10,
    ).animate(CurvedAnimation(
      parent: _floatingController,
      curve: Curves.easeInOut,
    ));

    // Rotation animation for abstract shapes
    _rotationController = AnimationController(
      duration: Duration(seconds: 8),
      vsync: this,
    );
    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 2,
    ).animate(CurvedAnimation(
      parent: _rotationController,
      curve: Curves.linear,
    ));

    // Pulse animation for circles
    _pulseController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    // Wave animation
    _waveController = AnimationController(
      duration: Duration(seconds: 4),
      vsync: this,
    );
    _waveAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _waveController,
      curve: Curves.linear,
    ));

    // Start all animations
    _floatingController.repeat(reverse: true);
    _rotationController.repeat();
    _pulseController.repeat(reverse: true);
    _waveController.repeat();
  }

  @override
  void dispose() {
    _floatingController.dispose();
    _rotationController.dispose();
    _pulseController.dispose();
    _waveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
      background: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0A67DE),
              Color(0xFF1B75E8),
              Color(0xFF2D83F2),
              Color(0xFF3F91FF),
            ],
            stops: [0.0, 0.3, 0.7, 1.0],
          ),
        ),
        child: Stack(
          children: [
            // Animated floating bubbles/circles
            AnimatedBuilder(
              animation: _floatingAnimation,
              builder: (context, child) => Positioned(
                top: 20 + _floatingAnimation.value,
                right: -50,
                child: AnimatedBuilder(
                  animation: _pulseAnimation,
                  builder: (context, child) => Transform.scale(
                    scale: _pulseAnimation.value,
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            Colors.white.withValues(alpha: 0.15),
                            Colors.white.withValues(alpha: 0.05),
                            Colors.transparent,
                          ],
                          stops: [0.0, 0.7, 1.0],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Large background circle with glow effect and floating animation
            AnimatedBuilder(
              animation: _floatingAnimation,
              builder: (context, child) => Positioned(
                top: 50 + (_floatingAnimation.value * 0.7),
                left: -60,
                child: AnimatedBuilder(
                  animation: _pulseAnimation,
                  builder: (context, child) => Transform.scale(
                    scale: _pulseAnimation.value * 0.9,
                    child: Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            Colors.white.withValues(alpha: 0.12),
                            Colors.white.withValues(alpha: 0.06),
                            Colors.transparent,
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withValues(alpha: 0.1),
                            blurRadius: 30,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Medium floating elements with different animation timing
            AnimatedBuilder(
              animation: _floatingAnimation,
              builder: (context, child) => Positioned(
                top: 80 + (_floatingAnimation.value * -0.8),
                right: 60,
                child: AnimatedBuilder(
                  animation: _pulseAnimation,
                  builder: (context, child) => Transform.scale(
                    scale: 1 + (_pulseAnimation.value - 1) * 0.5,
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            Colors.white.withValues(alpha: 0.1),
                            Colors.white.withValues(alpha: 0.03),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Small accent circles with floating animation
            AnimatedBuilder(
              animation: _floatingAnimation,
              builder: (context, child) => Positioned(
                top: 120 + (_floatingAnimation.value * 0.6),
                left: 50,
                child: AnimatedBuilder(
                  animation: _pulseAnimation,
                  builder: (context, child) => Transform.scale(
                    scale: _pulseAnimation.value * 0.95,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.08),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withValues(alpha: 0.05),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Bottom decorative elements with floating animation
            AnimatedBuilder(
              animation: _floatingAnimation,
              builder: (context, child) => Positioned(
                bottom: 140 + (_floatingAnimation.value * -0.5),
                left: 20,
                child: AnimatedBuilder(
                  animation: _pulseAnimation,
                  builder: (context, child) => Transform.scale(
                    scale: 1 + (_pulseAnimation.value - 1) * 0.3,
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            Colors.white.withValues(alpha: 0.12),
                            Colors.white.withValues(alpha: 0.04),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            AnimatedBuilder(
              animation: _floatingAnimation,
              builder: (context, child) => Positioned(
                bottom: 160 + (_floatingAnimation.value * 0.4),
                right: 30,
                child: AnimatedBuilder(
                  animation: _pulseAnimation,
                  builder: (context, child) => Transform.scale(
                    scale: _pulseAnimation.value * 0.9,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.1),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Abstract shapes with rotation and floating animation
            AnimatedBuilder(
              animation: _floatingAnimation,
              builder: (context, child) => Positioned(
                top: 40 + (_floatingAnimation.value * 0.3),
                left: 30,
                child: AnimatedBuilder(
                  animation: _rotationAnimation,
                  builder: (context, child) => Transform.rotate(
                    angle: 0.5 + (_rotationAnimation.value * 3.14159),
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white.withValues(alpha: 0.06),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            AnimatedBuilder(
              animation: _floatingAnimation,
              builder: (context, child) => Positioned(
                top: 90 + (_floatingAnimation.value * -0.4),
                right: 20,
                child: AnimatedBuilder(
                  animation: _rotationAnimation,
                  builder: (context, child) => Transform.rotate(
                    angle: -0.3 + (_rotationAnimation.value * -3.14159),
                    child: Container(
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        gradient: LinearGradient(
                          colors: [
                            Colors.white.withValues(alpha: 0.08),
                            Colors.white.withValues(alpha: 0.03),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Additional floating decorative elements
            AnimatedBuilder(
              animation: _floatingAnimation,
              builder: (context, child) => Positioned(
                top: 150 + (_floatingAnimation.value * 0.8),
                right: 80,
                child: AnimatedBuilder(
                  animation: _pulseAnimation,
                  builder: (context, child) => Transform.scale(
                    scale: 1 + (_pulseAnimation.value - 1) * 0.4,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.07),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            AnimatedBuilder(
              animation: _floatingAnimation,
              builder: (context, child) => Positioned(
                bottom: 100 + (_floatingAnimation.value * -0.6),
                right: 120,
                child: AnimatedBuilder(
                  animation: _rotationAnimation,
                  builder: (context, child) => Transform.rotate(
                    angle: _rotationAnimation.value * 3.14159 * 0.5,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.white.withValues(alpha: 0.05),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Animated wave pattern overlay
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: AnimatedBuilder(
                animation: _waveAnimation,
                builder: (context, child) => CustomPaint(
                  painter: AnimatedWavePatternPainter(_waveAnimation.value),
                ),
              ),
            ),

            // Main content with enhanced styling
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: widget.child,
            ),
          ],
        ),
      ),
    );
  }
}

class AnimatedWavePatternPainter extends CustomPainter {
  final double animationValue;

  AnimatedWavePatternPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.03)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    // Create animated wave patterns
    for (int i = 0; i < 4; i++) {
      final path = Path();
      double yOffset = size.height * 0.2 + (i * 45);
      double waveOffset = animationValue * 40; // Wave movement

      path.moveTo(0, yOffset);

      for (double x = 0; x <= size.width; x += 15) {
        double y = yOffset + (8 * (i + 1)) *
            (0.5 + 0.5 * ((x + waveOffset) / size.width)) *
            (1 + 0.3 * ((x + waveOffset) / 80)) *
            (1 + 0.2 * (animationValue * 2 - 1));

        if (x == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }

      canvas.drawPath(path, paint);
    }

    // Add animated dots
    final dotPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.04 + (animationValue * 0.02))
      ..style = PaintingStyle.fill;

    for (int i = 0; i < 10; i++) {
      double x = (size.width / 10) * i + (animationValue * 20);
      double y = size.height * 0.4 + (i % 2) * 40 + (animationValue * 15);
      double radius = 1 + (animationValue * 0.5);

      if (x >= 0 && x <= size.width) {
        canvas.drawCircle(Offset(x, y), radius, dotPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// class FlexibleSpaceBackWidget extends StatelessWidget {
//   final Widget child;
//   const FlexibleSpaceBackWidget({
//     super.key,
//     required this.child
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return FlexibleSpaceBar(
//       background: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [
//               Color(0xFF0A67DE),
//               Color(0xFF1B75E8),
//               Color(0xFF2D83F2),
//             ],
//             stops: [0.0, 0.5, 1.0],
//           ),
//         ),
//         child: Stack(
//           children: [
//             // Background decorative elements with better positioning
//             Positioned(
//               top: 30,
//               right: -40,
//               child: Container(
//                 width: 120,
//                 height: 120,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: Colors.white.withValues(alpha: 0.12),
//                 ),
//               ),
//             ),
//             Positioned(
//               top: 60,
//               left: -35,
//               child: Container(
//                 width: 90,
//                 height: 90,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: Colors.white.withValues(alpha: 0.08),
//                 ),
//               ),
//             ),
//             // Additional decorative elements
//             Positioned(
//               top: 100,
//               right: 40,
//               child: Container(
//                 width: 60,
//                 height: 60,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: Colors.white.withValues(alpha: 0.06),
//                 ),
//               ),
//             ),
//             Positioned(
//               bottom: 120,
//               left: 30,
//               child: Container(
//                 width: 40,
//                 height: 40,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: Colors.white.withValues(alpha: 0.1),
//                 ),
//               ),
//             ),
//
//             // Main content with enhanced styling
//             Positioned(
//               bottom: 20,
//               left: 20,
//               right: 20,
//               child: child,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
