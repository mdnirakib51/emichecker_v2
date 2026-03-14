
import 'package:flutter/material.dart';
import '../constants/colors_resources.dart';

class GlobalRealDropDown extends StatelessWidget {
  final List<String> dataArray;
  final String title;
  final TextStyle? titleStyle;
  final TextStyle? hintTextStyle;
  final String hint;
  final double height;
  final bool isIgnore;
  final bool isRequired;
  final String? seletcedValue;
  final Function? selecetTap;
  final double? titleHeight;
  final double? titleSize;
  final double? dropdownValueSize;
  final Color? dropdownValueColor;
  final Color? hintTextColor;


  const GlobalRealDropDown(
      {super.key,
        required this.dataArray,
        required this.title,
        this.titleStyle,
        required this.hint,
        this.hintTextStyle,
        this.isRequired=false,
        this.height = 40,
        this.selecetTap,
        this.seletcedValue,
        this.titleHeight=7,
        this.titleSize= 13,
        this.dropdownValueSize= 14,
        this.dropdownValueColor,
        this.hintTextColor,
        this.isIgnore = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Container(
          child: isRequired ? Text.rich(
            TextSpan(
              children: [
                TextSpan(
                    text: title,
                    style: titleStyle
                        ?? const TextStyle(
                          color: ColorRes.deep100,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Rubik',
                        ),
                ),
                const TextSpan(
                  text: '*',
                  style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red),
                ),
              ],
            ),
          ):Text(title, textAlign: TextAlign.left,
            style: titleStyle
                ?? const TextStyle(
                  color: ColorRes.deep100,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Rubik',
                ),
          )),
        /*     Text(
          title,
          style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault),
        ),*/
        SizedBox(height: titleHeight),
        Container(
          height: height,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: const Color(0xffffffff),
              border: Border.all(width: 1, color: Colors.black45),
              borderRadius: const BorderRadius.all(Radius.circular(5))),
          child: Center(
            child: IgnorePointer(
              ignoring: isIgnore,
              child: DropdownButton<String>(
                // iconDisabledColor: iconColor,
                iconEnabledColor: Theme.of(context).primaryColor,
                isExpanded: true,
                underline: const SizedBox(),
                value: seletcedValue,
                elevation: 4,
                hint: Text(hint,
                  style: hintTextStyle ?? const TextStyle(
                      fontSize: 14,
                      color: ColorRes.white200,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Rubik'
                  ),
                ),
                isDense: true,
                items: dataArray.map((String ds) {
                  return DropdownMenuItem<String>(
                    value: ds,
                    child: Text(ds,
                      style: const TextStyle(
                          color: ColorRes.textColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 17,
                          fontFamily: 'Rubik'
                      ),
                      textAlign: TextAlign.center,
                    ),
                  );
                }).toList(),
                onChanged: (value) =>
                selecetTap != null ? selecetTap!(value) : null,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
