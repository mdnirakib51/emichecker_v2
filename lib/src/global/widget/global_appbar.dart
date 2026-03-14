import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/colors_resources.dart';
import 'global_sized_box.dart';
import 'global_text.dart';

class GlobalAppbarWidget extends StatelessWidget {
  final String title;
  final List<Widget>? action;
  const GlobalAppbarWidget({
    super.key,
    required this.title,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 30, bottom: 10),
      color: ColorRes.black.withAlpha(50),
      child: Row(
        children: [
          GestureDetector(
            onTap: (){
              Get.back();
            },
            child: Container(
              color: Colors.transparent,
              height: 40,
              width: 30,
              child: const Center(
                child: Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: ColorRes.white,
                  size: 20,
                ),
              ),
            ),
          ),
          sizedBoxW(5),
          Expanded(
            child: GlobalText(
              str: title,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),

          action?.isNotEmpty ?? false ? Row(
            children: action ?? [],
          ) : const SizedBox.shrink()
        ],
      ),
    );
  }
}


class GlobalAppBar extends StatelessWidget {
  const GlobalAppBar({
    super.key,
    this.titleText,
    this.isBackIc = true,
    this.centerTitle,
    this.titleColor,
    this.fontSize,
    this.fontWeight,
    this.backColor,
    this.title,
    this.leading,
    this.actions
  });
  final String? titleText;
  final Color? titleColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? backColor;
  final bool? isBackIc;
  final bool? centerTitle;
  final Widget? title;
  final Widget? leading;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backColor ?? ColorRes.appColor,
      automaticallyImplyLeading: false,
      leadingWidth: isBackIc == true ? 56 : 0,
      leading: leading ?? (isBackIc == true ? IconButton(
        splashRadius: 0.1,
        icon: const Icon(Icons.arrow_back, color: ColorRes.white, size: 22),
        onPressed: (){
          Get.back();
        },
      ) : const SizedBox.shrink()),
      centerTitle: centerTitle,
      title: title ?? GlobalText(
        str: titleText ?? "",
        color: titleColor ?? ColorRes.white,
        fontSize: fontSize ?? 16,
        fontWeight: fontWeight ?? FontWeight.w500,
        textAlign: TextAlign.center,
        fontFamily: 'Rubik',
      ),
      actions: actions,
    );
  }
}