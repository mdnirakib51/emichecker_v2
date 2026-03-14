
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/colors_resources.dart';
import '../constants/images.dart';
import 'global_image_loader.dart';
import 'global_sized_box.dart';
import 'global_text.dart';

class GlobalDialog extends StatefulWidget {
  final String title;
  final List<Widget> children;
  const GlobalDialog({
    super.key,
    required this.title,
    required this.children
  });

  @override
  State<GlobalDialog> createState() => _GlobalDialogState();
}

class _GlobalDialogState extends State<GlobalDialog> {

  final TextEditingController searchCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
        builder: (ctx, buildSetState){
          return AlertDialog(
            backgroundColor: ColorRes.appBackColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
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

                        sizedBoxH(10),
                        SizedBox(
                          height: 20,
                          width: size(context).width,
                          child: Stack(
                            children: [
                              Center(
                                child: GlobalText(
                                  str: widget.title,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: ColorRes.black,
                                ),
                              ),

                              Positioned(
                                right: 0,
                                top: 0,
                                child: GestureDetector(
                                  onTap: (){
                                    Navigator.pop(context);
                                  },
                                  child: GlobalImageLoader(
                                    imagePath: Images.closeIc,
                                    height: 20,
                                    width: 20,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),

                        sizedBoxH(10),
                        Column(
                          children: widget.children,
                        )
                      ],
                    )
                ),
              ),
            ),
          );
        }
    );
  }
}
