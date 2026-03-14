
import 'package:flutter/material.dart';
import '../constants/colors_resources.dart';
import 'global_text.dart';

class TextWidget extends StatelessWidget {
  final double? width;
  final String str;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Color? color;
  final FontStyle? fontStyle;
  final double? letterSpacing;
  final TextDecoration? decoration;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final bool? softWrap;
  final double? height;
  final String? fontFamily;
  const TextWidget({
    super.key,
    this.width,
    required this.str,
    this.fontWeight,
    this.fontSize,
    this.fontStyle,
    this.color,
    this.letterSpacing,
    this.decoration,
    this.maxLines,
    this.textAlign,
    this.overflow,
    this.softWrap,
    this.height,
    this.fontFamily,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: GlobalText(
        str: str,
        fontSize: 11,
        color: color ?? ColorRes.black,
        fontWeight: fontWeight ?? FontWeight.w700,
        decoration: TextDecoration.none,
        textAlign: textAlign ?? TextAlign.center,
        letterSpacing: letterSpacing,
        fontStyle: fontStyle,
        maxLines: maxLines,
        overflow: overflow,
        softWrap: softWrap,
      ),
    );
  }
}
