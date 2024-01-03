// import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class CompressionProvider {
  CompressionProvider._();

  static CompressionProvider instance = CompressionProvider._();

  // Future<File?> compressImageFile({File? imageFile, int? targetSizeKB}) async {
  //   debugPrint("compressImageFile -----------------> ");
  //   try {
  //     if (imageFile == null) {
  //       return null;
  //     }
  //
  //     Uint8List imageBytes = await imageFile.readAsBytes();
  //     int originalSizeKB = imageBytes.length ~/ 1024;
  //
  //     if (originalSizeKB <= (targetSizeKB ?? 1024)) {
  //       return imageFile;
  //     }
  //
  //     int quality = (((targetSizeKB ?? 1024) / originalSizeKB) * 100).round();
  //     if (quality > 100) {
  //       quality = 100; // Ensure quality is within the valid range (0 to 100)
  //     }
  //
  //     List<int> compressedBytes = await FlutterImageCompress.compressWithList(
  //       imageBytes,
  //       quality: quality.toInt(),
  //     );
  //
  //     File compressedFile = File('${imageFile.path}_compressed.jpg');
  //     await compressedFile.writeAsBytes(compressedBytes);
  //
  //     return compressedFile;
  //   } catch (e) {
  //     debugPrint("Error compressing and optimizing image: $e");
  //     return null;
  //   }
  // }
  //
  // Future<List<File>> compressImageFileList({required List<File> files}) async {
  //   debugPrint("compressImageFileList -----------------> ");
  //
  //   List<File> fileList = [];
  //   for (var element in files) {
  //     File? compFile = await compressImageFile(imageFile: element);
  //
  //     if (compFile != null) {
  //       fileList.add(compFile);
  //     } else {
  //       debugPrint("Image Compress Error: Compress File is null");
  //     }
  //   }
  //
  //   return fileList;
  // }

  Future<Uint8List?> compressImageBytes(
      {Uint8List? imageBytes, int? targetSizeKB}) async {
    debugPrint("compressImageBytes -----------------> ");
    try {
      if (imageBytes == null || imageBytes.isEmpty == true) {
        return null;
      }

      Uint8List iBytes = imageBytes;
      int originalSizeKB = iBytes.length ~/ 1024;

      if (originalSizeKB <= (targetSizeKB ?? 1024)) {
        return imageBytes;
      }

      int quality = (((targetSizeKB ?? 1024) / originalSizeKB) * 100).round();
      if (quality > 100) {
        quality = 100; // Ensure quality is within the valid range (0 to 100)
      }

      Uint8List compressedBytes = await FlutterImageCompress.compressWithList(
        iBytes,
        quality: quality.toInt(),
      );

      return compressedBytes;
    } catch (e) {
      debugPrint("Error compressing and optimizing image: $e");
      return null;
    }
  }

  Future<List<Uint8List>> compressImageBytesList(
      {required List<Uint8List> byteList}) async {
    debugPrint("compressImageBytesList -----------------> ");

    List<Uint8List> bList = [];
    for (var element in byteList) {
      Uint8List? compBytes = await compressImageBytes(imageBytes: element);

      if (compBytes != null) {
        bList.add(compBytes);
      } else {
        debugPrint("Image Compress Error: Compress Bytes is null");
      }
    }

    return bList;
  }

  void compressVideoFile() {
    debugPrint("compressVideoFile -----------------> ");
  }
}
