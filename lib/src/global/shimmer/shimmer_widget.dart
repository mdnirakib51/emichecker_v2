import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../constants/colors_resources.dart' show ColorRes;

class ShimmerWidget extends StatelessWidget {
  final double height;
  final double width;
  final ShapeBorder shapeBorder;

  const ShimmerWidget.rectangular({
    super.key,
    required this.height,
    this.width = double.infinity,
  }) : shapeBorder = const RoundedRectangleBorder();

  const ShimmerWidget.circular({
    super.key,
    required this.height,
    this.width = double.infinity,
    this.shapeBorder = const CircleBorder()
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: ColorRes.bottomColor,
      highlightColor: ColorRes.appBackColor,
      child: Container(
        height: height,
        width: width,
        decoration: ShapeDecoration(
          color: Colors.grey,
          shape: shapeBorder
        ),
      ),
    );
  }
}
