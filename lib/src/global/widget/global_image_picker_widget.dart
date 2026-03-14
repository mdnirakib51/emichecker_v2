import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/colors_resources.dart';
import '../constants/enum.dart';
import 'buttomsheet_image_picker.dart';
import 'global_image_loader.dart';
import 'global_sized_box.dart';
import 'global_text.dart';

class GlobalImagePickerWidget extends StatefulWidget {
  final Function(XFile?) onImageSelected;
  final XFile? selectImage;
  final String? initialImage;
  final String? title;
  final double width;
  final double height;
  final bool? isRequired;

  const GlobalImagePickerWidget({
    super.key,
    required this.onImageSelected,
    this.selectImage,
    this.initialImage,
    this.title = "Image",
    this.width = 180,
    this.height = 100,
    this.isRequired = false,
  });

  @override
  State<GlobalImagePickerWidget> createState() => _GlobalImagePickerWidgetState();
}

class _GlobalImagePickerWidgetState extends State<GlobalImagePickerWidget> {
  XFile? selectedImage;

  @override
  void initState() {
    super.initState();
    selectedImage = widget.selectImage;
  }

  Future<void> _pickImage() async {
    final file = await showModalBottomSheet<XFile?>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return const BottomSheetImagePicker();
      },
    );

    if (file != null) {
      setState(() {
        selectedImage = XFile(file.path);
      });

      widget.onImageSelected(selectedImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.isRequired == false ?
        widget.title == null
            ? const SizedBox.shrink()
            : Text(widget.title ?? "",
          style: GoogleFonts.roboto(
                  color: ColorRes.black,
                  fontSize: 11,
                  fontWeight: FontWeight.w700
              ),
        ) : SizedBox(
          child: Row(
            children: [
              widget.title == null
                  ? const SizedBox.shrink()
                  : Text(widget.title ?? "",
                style: GoogleFonts.roboto(
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

        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                width: widget.width,
                height: widget.height,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: ColorRes.grey,
                    width: (selectedImage != null || widget.initialImage != null) ? 0.8 : 1,
                  ),
                ),
                child: selectedImage != null
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: GlobalImageLoader(
                    imagePath: selectedImage?.path ?? "",
                    height: widget.height,
                    width: widget.width,
                    fit: BoxFit.fill,
                    imageFor: ImageFor.local,
                  ),
                )
                    : widget.initialImage != null
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: GlobalImageLoader(
                    imagePath: widget.initialImage ?? "",
                    height: widget.height,
                    width: widget.width,
                    fit: BoxFit.fill,
                    imageFor: ImageFor.network,
                  ),
                )
                    : const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.camera_alt_outlined, size: 18),
                    GlobalText(
                      str: "Add Image",
                      color: ColorRes.black,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}