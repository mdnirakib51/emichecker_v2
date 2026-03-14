import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/colors_resources.dart';
import '../widget/global_text.dart';

void printTest(String text){
  if(kDebugMode){
    print('\x1B[33m$text\x1B[0m');
  }
}

void showLog(String text){
  if(kDebugMode){
    log('\x1B[33m$text\x1B[0m');
  }
}

void showCustomSnackBar(String message, {
  IconData? icon,
  bool isError = true,
  bool isPosition = false,
  double? duration,
}) {
  Get.showSnackbar(
      GetSnackBar(
        backgroundColor: isError ? ColorRes.red : ColorRes.green,
        message: message,
        maxWidth: 1170,
        duration: duration != null ? Duration(seconds: duration.toInt()) : const Duration(seconds: 3),
        snackStyle: SnackStyle.FLOATING,
        margin: const EdgeInsets.all(10),
        borderRadius: 6,
        isDismissible: true,
        snackPosition: isPosition ? SnackPosition.BOTTOM : SnackPosition.TOP,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        messageText: GlobalText(
          str: message,
          color: ColorRes.white,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),

        icon: Icon(
          isError ? Icons.error : Icons.check_circle,
          size: 18,
          color: ColorRes.white,
        ),
      ));
}

class OverlayLoadingIndicator extends StatelessWidget {
  const OverlayLoadingIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black26,
      child: Center(
        child: Container(
          height: 125,
          width: 120,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: ColorRes.appBackColor,
            borderRadius: BorderRadius.circular(6),
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircularProgressIndicator(
                color: ColorRes.appRedColor
              ),
              GlobalText(
                str: 'Loading..',
                fontSize: 12,
                fontWeight: FontWeight.bold,
              )
            ],
          ),
        ),
      ),
    );
  }
}
