
import 'package:flutter/material.dart';
import '../../global/constants/colors_resources.dart';
import '../../global/widget/global_sized_box.dart';

class StudentMenuBackgroundContainer extends StatefulWidget {
  final Widget child;
  const StudentMenuBackgroundContainer({
    super.key,
    required this.child
  });

  @override
  State<StudentMenuBackgroundContainer> createState() => _StudentMenuBackgroundContainerState();
}

class _StudentMenuBackgroundContainerState extends State<StudentMenuBackgroundContainer> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size(context).width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: ColorRes.white,
          boxShadow: [
            BoxShadow(
                color: ColorRes.grey.withValues(alpha: 0.2),
                blurRadius: 2,
                spreadRadius: 2,
                offset: Offset(2, 2)
            ),
            BoxShadow(
                color: ColorRes.grey.withValues(alpha: 0.2),
                blurRadius: 2,
                spreadRadius: 2,
                offset: Offset(-2, -2)
            ),
          ]
      ),
      child: Stack(
        children: [
          // Positioned(
          //   top: -20,
          //   right: -40,
          //   child: Container(
          //     width: 100,
          //     height: 100,
          //     decoration: BoxDecoration(
          //       shape: BoxShape.circle,
          //       gradient: RadialGradient(
          //         colors: [
          //           ColorRes.appColor.withValues(alpha: 0.15),
          //           ColorRes.appColor.withValues(alpha: 0.08),
          //           ColorRes.appColor.withValues(alpha: 0.02),
          //           Colors.transparent,
          //         ],
          //         stops: [0.0, 0.4, 0.7, 1.0],
          //       ),
          //     ),
          //   ),
          // ),

          // Large background circle with enhanced glow effect
          // Positioned(
          //   top: -30,
          //   left: -50,
          //   child: Container(
          //     width: 120,
          //     height: 120,
          //     decoration: BoxDecoration(
          //       shape: BoxShape.circle,
          //       gradient: RadialGradient(
          //         colors: [
          //           ColorRes.appColor.withValues(alpha: 0.12),
          //           ColorRes.appColor.withValues(alpha: 0.06),
          //           ColorRes.appColor.withValues(alpha: 0.02),
          //           Colors.transparent,
          //         ],
          //         stops: [0.0, 0.3, 0.6, 1.0],
          //       ),
          //       boxShadow: [
          //         BoxShadow(
          //           color: ColorRes.appColor.withValues(alpha: 0.08),
          //           blurRadius: 25,
          //           spreadRadius: 5,
          //         ),
          //       ],
          //     ),
          //   ),
          // ),

          // Medium floating elements with enhanced visibility
          Positioned(
            top: 15,
            right: 25,
            child: Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    ColorRes.appColor.withValues(alpha: 0.10),
                    ColorRes.appColor.withValues(alpha: 0.05),
                    ColorRes.appColor.withValues(alpha: 0.02),
                    Colors.transparent,
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: ColorRes.appColor.withValues(alpha: 0.05),
                    blurRadius: 12,
                    spreadRadius: 2,
                  ),
                ],
              ),
            ),
          ),

          // Small accent circles with better contrast
          // Positioned(
          //   top: 55,
          //   left: 15,
          //   child: Container(
          //     width: 40,
          //     height: 40,
          //     decoration: BoxDecoration(
          //       shape: BoxShape.circle,
          //       color: ColorRes.appColor.withValues(alpha: 0.08),
          //       boxShadow: [
          //         BoxShadow(
          //           color: ColorRes.appColor.withValues(alpha: 0.06),
          //           blurRadius: 10,
          //           spreadRadius: 2,
          //         ),
          //       ],
          //     ),
          //   ),
          // ),

          // Bottom decorative elements with enhanced visibility
          Positioned(
            bottom: 25,
            left: 5,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    ColorRes.appColor.withValues(alpha: 0.12),
                    ColorRes.appColor.withValues(alpha: 0.06),
                    ColorRes.appColor.withValues(alpha: 0.02),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // Positioned(
          //   bottom: 35,
          //   right: 15,
          //   child: Container(
          //     width: 35,
          //     height: 35,
          //     decoration: BoxDecoration(
          //       shape: BoxShape.circle,
          //       color: ColorRes.appColor.withValues(alpha: 0.10),
          //       boxShadow: [
          //         BoxShadow(
          //           color: ColorRes.appColor.withValues(alpha: 0.04),
          //           blurRadius: 8,
          //           spreadRadius: 1,
          //         ),
          //       ],
          //     ),
          //   ),
          // ),

          // Abstract shapes for modern look with better visibility
          Positioned(
            top: 25,
            left: 12,
            child: Transform.rotate(
              angle: 0.5,
              child: Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  gradient: LinearGradient(
                    colors: [
                      ColorRes.appColor.withValues(alpha: 0.08),
                      ColorRes.appColor.withValues(alpha: 0.04),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: ColorRes.appColor.withValues(alpha: 0.03),
                      blurRadius: 6,
                      spreadRadius: 1,
                    ),
                  ],
                ),
              ),
            ),
          ),

          Positioned(
            top: 35,
            right: 12,
            child: Transform.rotate(
              angle: -0.3,
              child: Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  gradient: LinearGradient(
                    colors: [
                      ColorRes.appColor.withValues(alpha: 0.10),
                      ColorRes.appColor.withValues(alpha: 0.05),
                    ],
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            bottom: 20,
            left: 35,
            child: Transform.rotate(
              angle: 0.8,
              child: Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: ColorRes.appColor.withValues(alpha: 0.08),
                ),
              ),
            ),
          ),

          // Additional decorative elements for better design
          Positioned(
            top: 70,
            right: 45,
            child: Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: ColorRes.appColor.withValues(alpha: 0.15),
                  width: 2,
                ),
              ),
            ),
          ),

          Positioned(
            bottom: 50,
            right: 35,
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: ColorRes.appColor.withValues(alpha: 0.12),
                  width: 1.5,
                ),
              ),
            ),
          ),

          // Enhanced wave pattern overlay
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: CustomPaint(
              painter: StudentInfoWavePatternPainter(),
            ),
          ),

          // Main content with proper spacing
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: widget.child,
          ),
        ],
      ),
    );
  }
  // Widget _buildSummaryItem(String title, String amount, IconData icon) {
  //   return Row(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Icon(icon, color: ColorRes.appColor.withValues(alpha: 0.8), size: 16),
  //       sizedBoxW(5),
  //       Flexible(
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             GlobalText(
  //               str: title,
  //               color: Colors.black.withValues(alpha: 0.9),
  //               fontSize: 13,
  //               fontWeight: FontWeight.w500,
  //             ),
  //
  //             GlobalText(
  //               str: amount,
  //               color: Colors.black,
  //               fontSize: 16,
  //               fontWeight: FontWeight.bold,
  //             ),
  //           ],
  //         ),
  //       ),
  //     ],
  //   );
  // }
}

class StudentInfoWavePatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = ColorRes.appColor.withValues(alpha: 0.06)
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;

    final fillPaint = Paint()
      ..color = ColorRes.appColor.withValues(alpha: 0.02)
      ..style = PaintingStyle.fill;

    // Create more visible wave patterns
    for (int i = 0; i < 4; i++) {
      final path = Path();
      double yOffset = size.height * 0.15 + (i * 25);
      double amplitude = 8 + (i * 2);

      path.moveTo(0, yOffset);

      for (double x = 0; x <= size.width; x += 10) {
        double y = yOffset + amplitude *
            (0.5 + 0.3 * (x / size.width)) *
            (1 + 0.2 * (x / 60)) *
            (0.8 + 0.4 * (i / 4));

        if (x == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }

      // Create filled wave for the first pattern
      if (i == 0) {
        path.lineTo(size.width, size.height);
        path.lineTo(0, size.height);
        path.close();
        canvas.drawPath(path, fillPaint);
      }

      // Draw stroke for all patterns
      canvas.drawPath(path, paint);
    }

    // Add some decorative dots
    final dotPaint = Paint()
      ..color = ColorRes.appColor.withValues(alpha: 0.08)
      ..style = PaintingStyle.fill;

    for (int i = 0; i < 8; i++) {
      double x = (size.width / 8) * i + (size.width / 16);
      double y = size.height * 0.3 + (i % 2) * 30;
      canvas.drawCircle(Offset(x, y), 1.5, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}