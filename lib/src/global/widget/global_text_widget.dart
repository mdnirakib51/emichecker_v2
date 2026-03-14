import 'package:flutter/material.dart';

import '../../global/constants/colors_resources.dart';
import '../../global/widget/global_text.dart';

class TextValue extends StatelessWidget {
  final String name;
  final String value;
  const TextValue({
    super.key,
    required this.name,
    required this.value
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: GlobalText(
            str: name,
            color: ColorRes.appColor,
            fontSize: 13,
            fontWeight: FontWeight.w700,
          ),
        ),
        GlobalText(
          str: value,
          color: ColorRes.appColor,
          fontSize: 13,
          fontWeight: FontWeight.w400,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class TextValueTwo extends StatelessWidget {
  final String name;
  final String value;
  final Color? color;
  final Color? nameColor;
  final FontWeight? fontWeight;
  const TextValueTwo({
    super.key,
    required this.name,
    required this.value,
    this.nameColor,
    this.color,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GlobalText(
          str: name,
          color: nameColor ?? ColorRes.black,
          fontSize: 11,
          fontWeight: fontWeight ?? FontWeight.w700,
        ),
        Flexible(
          flex: 4,
          child: GlobalText(
            str: value,
            color: color ?? ColorRes.black,
            fontSize: 11,
            fontWeight: fontWeight ?? FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class TextValueTwoBlack extends StatelessWidget {
  final String name;
  final String value;
  const TextValueTwoBlack({
    super.key,
    required this.name,
    required this.value
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: GlobalText(
            str: name,
            color: ColorRes.deep100,
            fontSize: 11,
            fontWeight: FontWeight.w700,
          ),
        ),
        GlobalText(
          str: value,
          color: ColorRes.deep100,
          fontSize: 11,
          fontWeight: FontWeight.w400,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}