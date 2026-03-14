import 'dart:developer';
import 'package:flutter_image_compress/flutter_image_compress.dart';

/// Pass an [Image] [<XFile>], and the targetted size in megabyte(MB).
Future<XFile?> compressImageMb(XFile image, double mb) async {
  try {
    const byteToMb = 1000000;
    final size = (await image.length()) / byteToMb;
    if (size < mb) return image;
    final filePath = image.path;
    final pathStart = filePath.lastIndexOf("/");
    final typeStart = filePath.lastIndexOf(".");
    final folderPath = filePath.substring(0, pathStart);
    final type = filePath.substring(typeStart);
    final outPath = "$folderPath/compressed_image$type";
    final compressedImage = await FlutterImageCompress.compressAndGetFile(
        image.path, outPath,
        quality: ((mb * 100) ~/ size));
    if (compressedImage == null) return null;
    final newSize = (await compressedImage.length()) / byteToMb;
    if (newSize < mb) {
      return compressedImage;
    } else {
      return compressImageMb(compressedImage, mb);
    }
  } catch (e, s) {
    log("Error On fun(compressImageMb) :", error: e, stackTrace: s);
    rethrow;
  }
}
