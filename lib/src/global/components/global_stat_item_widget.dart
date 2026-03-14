import 'package:flutter/material.dart';
import '../constants/colors_resources.dart';
import '../widget/global_sized_box.dart';
import '../widget/global_text.dart';

class GlobalStatItemModel {
  final String label;
  final String value;

  GlobalStatItemModel({
    required this.label,
    required this.value,
  });
}

class GlobalStatsRowWidget extends StatelessWidget {
  final List<GlobalStatItemModel> items;
  final String? text;
  final Color textColor;
  final Color valueColor;
  final Color labelColor;
  final double textFontSize;
  final double valueFontSize;
  final double labelFontSize;

  const GlobalStatsRowWidget({
    super.key,
    required this.items,
    this.text,
    this.textColor = ColorRes.white,
    this.valueColor = ColorRes.white,
    this.labelColor = const Color(0xFFFFFFFF),
    this.textFontSize = 14,
    this.valueFontSize = 24,
    this.labelFontSize = 14,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        text != null ? GlobalText(
          str: text ?? '',
          color: textColor,
          fontSize: textFontSize,
          fontWeight: FontWeight.w700,
        ) : SizedBox.shrink(),
        text != null ? sizedBoxH(5) : SizedBox.shrink(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: items.map((item) => Column(
            children: [
              GlobalText(
                str: item.value,
                color: valueColor,
                fontSize: valueFontSize,
                fontWeight: FontWeight.bold,
              ),

              GlobalText(
                str: item.label,
                color: labelColor,
                fontSize: labelFontSize,
                fontWeight: FontWeight.w400,
              ),
            ],
          )).toList(),
        ),
      ],
    );
  }
}
