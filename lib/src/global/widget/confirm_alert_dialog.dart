
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/colors_resources.dart';
import 'global_bottom_widget.dart';
import 'global_sized_box.dart';
import 'global_text.dart';

class ConfirmAlertDialog extends StatelessWidget {
  final String? title;
  final String? subTitle;
  final String? yesText;
  final String? noText;
  final Function() yesOnTap;
  final Function() noOnTap;
  const ConfirmAlertDialog({
    super.key,
    required this.title,
    this.subTitle,
    this.yesText,
    this.noText,
    required this.yesOnTap,
    required this.noOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
        builder: (ctx, buildSetState){
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: AlertDialog(
              backgroundColor: ColorRes.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 15),
              content: SizedBox(
                width: Get.width,
                child: NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: (overScroll) {
                    overScroll.disallowIndicator();
                    return true;
                  },
                  child: SingleChildScrollView(
                      child: Column(
                        children: [

                          sizedBoxH(20),
                          GlobalText(
                            str: title ?? "",
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: ColorRes.black,
                          ),

                          subTitle != null ? sizedBoxH(10) : const SizedBox.shrink(),
                          subTitle != null ? GlobalText(
                            str: subTitle ?? "",
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: ColorRes.grey,
                            textAlign: TextAlign.center,
                          ) : const SizedBox.shrink(),

                          sizedBoxH(20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: GlobalButtonWidget(
                                      str: noText ?? "No",
                                      height: 30,
                                      radius: 5,
                                      textSize: 11,
                                      buttomColor: Colors.transparent,
                                      borderColor: ColorRes.grey,
                                      textColor: ColorRes.grey,
                                      onTap: noOnTap
                                  ),
                                ),

                                sizedBoxW(10),
                                Expanded(
                                  child: GlobalButtonWidget(
                                    str: noText ?? "Yes",
                                    height: 30,
                                    radius: 5,
                                    textSize: 11,
                                    onTap: yesOnTap,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          sizedBoxH(12),
                        ],
                      )
                  ),
                ),
              ),
            ),
          );
        }
    );
  }
}
