import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/colors_resources.dart';
import '../constants/input_decoration.dart';
import 'global_sized_box.dart';

class GlobalDropDownFormField extends StatefulWidget {
  final String? titleText;
  final String? hintText;
  final String? labelText;
  final TextStyle? titleStyle;
  final TextStyle? hintTextStyle;
  final TextStyle? labelTextStyle;
  final String value;
  final bool? filled;
  final Color? fillColor;
  final double? height;
  final double? menuMaxHeight;
  final bool? isDense;
  final List<String> items;
  final Widget? prefixIcon;
  final Widget? sufixIcon;
  final bool? isRequired;
  final EdgeInsetsGeometry? contentPadding;
  final InputDecoration? decoration;
  final ValueChanged<String?> onChanged;
  final Function()? onTab;
  final String? Function(String?)? validator;

  const GlobalDropDownFormField({
    super.key,
    this.titleText,
    this.labelText,
    this.hintText,
    this.titleStyle,
    this.labelTextStyle,
    this.hintTextStyle,
    required this.value,
    this.decoration,
    this.filled = false,
    this.fillColor,
    this.height,
    this.menuMaxHeight,
    required this.items,
    required this.onChanged,
    this.onTab,
    this.prefixIcon,
    this.sufixIcon,
    this.validator,
    this.isRequired = false,
    this.contentPadding,
    this.isDense = false,
  });

  @override
  State<GlobalDropDownFormField> createState() => _GlobalDropDownFormFieldState();
}

class _GlobalDropDownFormFieldState extends State<GlobalDropDownFormField> {

  String? selectValue;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.isRequired == false ?
        widget.titleText == null
            ? const SizedBox.shrink()
            : Text(widget.titleText ?? "",
          style: widget.titleStyle
              ?? GoogleFonts.roboto(
                  color: ColorRes.black,
                  fontSize: 11,
                  fontWeight: FontWeight.w700
              ),
        ) : SizedBox(
          child: Row(
            children: [
              widget.titleText == null
                  ? const SizedBox.shrink()
                  : Text(widget.titleText ?? "",
                style: widget.titleStyle
                    ?? GoogleFonts.roboto(
                        color: ColorRes.black,
                        fontSize: 11,
                        fontWeight: FontWeight.w700
                    ),
              ),
              sizedBoxW(2),
              Text("*",
                style: GoogleFonts.roboto(
                    color: ColorRes.red,
                    fontSize: 12,
                    fontWeight: FontWeight.w700
                ),
              ),
            ],
          ),
        ),
        //     : GlobalText(
        //   str: widget.titleText ?? "",
        //   color: ColorRes.textColor,
        //   fontSize: 16,
        //   fontWeight: FontWeight.w400,
        //   textAlign: TextAlign.center,
        //   fontFamily: 'Rubik',
        // ),
        /// When I give the title text it will take the sized box
        widget.titleText != null ? const SizedBox(height: 5) : const SizedBox.shrink(),
        DropdownButtonFormField<String>(
          items: widget.items.map((itemValue) => DropdownMenuItem<String>(
            value: itemValue,
            child: Text(
              itemValue,
              maxLines: 1,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.roboto(
                color: ColorRes.textColor,
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
            ),
          )).toList(),
          dropdownColor: ColorRes.appBackColor,
          menuMaxHeight: widget.menuMaxHeight ?? 500,
          // value: widget.value, /// I can change this line
          value: selectValue,
          isExpanded: true,
          decoration: widget.decoration?.copyWith(
            contentPadding: widget.contentPadding,
            isDense: widget.isDense,
            hintText: widget.hintText,
            hintStyle: widget.hintTextStyle ?? GoogleFonts.roboto(
                fontSize: 12,
                color: ColorRes.white200,
                fontWeight: FontWeight.w400
            ),
            labelText: widget.labelText,
            labelStyle: widget.labelTextStyle,
            prefixIcon: widget.prefixIcon,
            filled: widget.filled,
            fillColor: widget.fillColor,
            // filled: true,
            // fillColor: ColorRes.grey.withValues(alpha: 0.2),
          ) ?? inputDecoration.copyWith(
            contentPadding: widget.contentPadding,
            isDense: widget.isDense,
            hintText: widget.hintText,
            hintStyle: widget.hintTextStyle ?? GoogleFonts.roboto(
                fontSize: 12,
                color: ColorRes.white200,
                fontWeight: FontWeight.w400
            ),
            labelText: widget.labelText,
            labelStyle: widget.labelTextStyle,
            prefixIcon: widget.prefixIcon,
            // filled: true,
            // fillColor: ColorRes.grey.withValues(alpha: 0.2),
            filled: widget.filled,
            fillColor: widget.fillColor,
          ),
          icon: widget.sufixIcon ?? const Icon(
            Icons.keyboard_arrow_down_sharp,
            color: ColorRes.grey,
            size: 15,
          ),
          onChanged: widget.onChanged,
          onTap: widget.onTab,
          validator: widget.validator ?? (val){
            if(val!.isEmpty){
              if (widget.labelText != null){
                return "${widget.labelText} is required!";
              }
              return "This filed is required!";
            }
            return null;
          },
          style: GoogleFonts.roboto(
            color: ColorRes.grey,
            fontWeight: FontWeight.w400,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}


class NameId{
  String id;
  String value;

  NameId({required this.id, required this.value});
}

// stringListToNameId(){
//   return
// }

class GlobalDropdownField2 extends StatefulWidget {
  final String? titleText;
  final String? hintText;
  final String? labelText;
  final TextStyle? titleStyle;
  final TextStyle? hintTextStyle;
  final TextStyle? labelTextStyle;
  final String value; /// I can change this line
  final bool? filled;
  final Color? fillColor;
  final double? height;
  final double? menuMaxHeight;
  final bool? isDense;
  final List<NameId> items;
  final Widget? prefixIcon;
  final Widget? sufixIcon;
  final EdgeInsetsGeometry? contentPadding;
  final InputDecoration? decoration;
  final ValueChanged<NameId?> onChanged;
  final Function()? onTab;
  final String? Function(NameId?)? validator;

  const GlobalDropdownField2({
    super.key,
    this.titleText,
    this.labelText,
    this.hintText,
    this.titleStyle,
    this.labelTextStyle,
    this.hintTextStyle,
    required this.value,
    this.decoration,
    this.filled = false,
    this.fillColor,
    this.height,
    this.menuMaxHeight,
    required this.items,
    required this.onChanged,
    this.onTab,
    this.prefixIcon,
    this.sufixIcon,
    this.validator,
    this.contentPadding,
    this.isDense = false,
  });

  @override
  State<GlobalDropdownField2> createState() => _GlobalDropdownField2State();
}

class _GlobalDropdownField2State extends State<GlobalDropdownField2> {


  NameId? selectValue;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.titleText == null
            ? const SizedBox.shrink()
            : Text(
          widget.titleText ?? "",
          style: widget.titleStyle
              ?? const TextStyle(
                color: ColorRes.deep100,
                fontSize: 16,
                fontWeight: FontWeight.w700,
                fontFamily: 'Rubik',
              ),
          textAlign: TextAlign.center,
        ),
        //     : GlobalText(
        //   str: widget.titleText ?? "",
        //   color: ColorRes.textColor,
        //   fontSize: 16,
        //   fontWeight: FontWeight.w400,
        //   textAlign: TextAlign.center,
        //   fontFamily: 'Rubik',
        // ),
        /// When I give the title text it will take the sizedbox
        widget.titleText != null ? const SizedBox(height: 5) : const SizedBox.shrink(),
        DropdownButtonFormField<NameId>(
          items: widget.items.map((itemValue) => DropdownMenuItem<NameId>(
            value: itemValue,
            child: Text(
              itemValue.value,
              maxLines: 1,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  color: ColorRes.textColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 17,
                  fontFamily: 'Rubik'
              ),
            ),
          ),
          ).toList(),
          menuMaxHeight: widget.menuMaxHeight ?? 500,
          // value: widget.value, /// I can change this line
          value: selectValue,
          isExpanded: true,
          decoration: widget.decoration?.copyWith(
            contentPadding: widget.contentPadding,
            isDense: widget.isDense,
            hintText: widget.hintText,
            hintStyle: widget.hintTextStyle ?? GoogleFonts.roboto(
                fontSize: 12,
                color: ColorRes.white200,
                fontWeight: FontWeight.w400
            ),
            labelText: widget.labelText,
            labelStyle: widget.labelTextStyle,
            prefixIcon: widget.prefixIcon,
            filled: widget.filled,
            fillColor: widget.fillColor,
            // filled: true,
            // fillColor: ColorRes.grey.withValues(alpha: 0.2),
          ) ?? inputDecoration.copyWith(
            contentPadding: widget.contentPadding,
            isDense: widget.isDense,
            hintText: widget.hintText,
            hintStyle: widget.hintTextStyle ?? GoogleFonts.roboto(
                fontSize: 12,
                color: ColorRes.white200,
                fontWeight: FontWeight.w400
            ),
            labelText: widget.labelText,
            labelStyle: widget.labelTextStyle,
            prefixIcon: widget.prefixIcon,
            // filled: true,
            // fillColor: ColorRes.grey.withValues(alpha: 0.2),
            filled: widget.filled,
            fillColor: widget.fillColor,
          ),
          icon: widget.sufixIcon ?? const Icon(
            Icons.keyboard_arrow_down_sharp,
            color: ColorRes.black,
          ),
          onChanged: widget.onChanged,
          onTap: widget.onTab,
          validator:widget.validator ??  (val){
            if(val!.value.isEmpty){
              if (widget.labelText != null){
                return "${widget.labelText} is required!";
              }
              return "This filed is required!";
            }
            return null;
          },
          style: const TextStyle(
            color: ColorRes.grey,
          ),
        ),
      ],
    );
  }
}

