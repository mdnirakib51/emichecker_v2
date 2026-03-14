
import 'package:flutter/material.dart';
import '../../global/constants/colors_resources.dart';
import '../../global/constants/images.dart';
import '../../global/widget/global_image_loader.dart';
import '../../global/widget/global_sized_box.dart';
import '../../global/widget/global_text.dart';

class EmptyDataWidget extends StatelessWidget {
  const EmptyDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Center(
        child: Stack(
          children: [
            const SizedBox(height: 180, width: 150),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SizedBox(
                width: size(context).width,
                child: const Center(
                  child: GlobalImageLoader(
                      imagePath: Images.emptyIc,
                      height: 120, width: 150
                  ),
                ),
              ),
            ),
            Positioned(
              top: 110,
              left: 0,
              right: 0,
              child: SizedBox(
                width: size(context).width,
                child: Center(
                  child: GlobalText(
                    str: "No Data Found!!",
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: ColorRes.grey,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
