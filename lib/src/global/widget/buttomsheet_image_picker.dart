import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../constants/colors_resources.dart';
import 'global_sized_box.dart';
import 'global_text.dart';

class BottomSheetImagePicker extends StatefulWidget {
  final Widget? title;
  final String? titleText;
  final Widget? cameraTitle;
  final String? cameraTitleText;
  final Widget? galleryTitle;
  final String? galleryTitleText;
  final Widget? cancel;
  final String? cancelText;
  final TextStyle? style;
  const BottomSheetImagePicker({
    super.key,
    this.title,
    this.titleText,
    this.cameraTitle,
    this.cameraTitleText,
    this.galleryTitle,
    this.galleryTitleText,
    this.cancel,
    this.cancelText,
    this.style,
  });

  @override
  State<BottomSheetImagePicker> createState() => _BottomSheetImagePickerState();
}

class _BottomSheetImagePickerState extends State<BottomSheetImagePicker> {
  ImagePicker picker = ImagePicker();

  Future<void> _pickImageFromCamera() async {
    final navigator = Navigator.of(context);
    final XFile? file = await picker.pickImage(source: ImageSource.camera);

    if (!mounted) return;

    if (file != null) {
      navigator.pop(file);
    } else {
      navigator.pop();
    }
  }

  Future<void> _pickImageFromGallery() async {
    final navigator = Navigator.of(context);
    final XFile? file = await picker.pickImage(source: ImageSource.gallery);

    if (!mounted) return;

    if (file != null) {
      navigator.pop(file);
    } else {
      navigator.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
        builder: (ctx, buildSetState){
          return Container(
            height: 220,
            width: size(context).width,
            margin: const EdgeInsets.only(bottom: 18, left: 8, right: 8),
            decoration: BoxDecoration(
                color: ColorRes.appBackColor,
                borderRadius: BorderRadius.circular(16)
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                sizedBoxH(10),
                Container(
                  height: 4,
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ColorRes.grey.withValues(alpha: 50/255),
                  ),
                ),

                sizedBoxH(12),
                Row(
                  children: [
                    GlobalText(
                      str: widget.titleText ??  "Please choose your media",
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    )
                  ],
                ),

                ListTile(
                  leading: const Icon(
                    Icons.camera_alt,
                    color: ColorRes.appColor,
                  ),
                  title: widget.cameraTitle ?? Text(widget.cameraTitleText ?? "Take a picture"),
                  onTap: _pickImageFromCamera,
                ),

                ListTile(
                  onTap: _pickImageFromGallery,
                  leading: const Icon(
                    Icons.photo,
                    color: ColorRes.appColor,
                  ),
                  title: widget.galleryTitle ?? Text(widget.galleryTitleText ?? "Choose from gallery"),
                ),

                const Spacer(),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      child: widget.cancel ?? Text(widget.cancelText ?? "Cancel", style: const TextStyle(color: ColorRes.red)),
                    ),
                  ),
                ),

                sizedBoxH(5)
              ],
            ),
          );
        }
    );
  }
}