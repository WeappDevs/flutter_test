import 'dart:typed_data';
import 'package:get/get.dart';

class MemoryFileModel {
  Rx<Uint8List?> byteList;
  String? fileName;
  String? netImagePath;
  String? netImageUrl;
  RxBool isRefreshVideo;

  MemoryFileModel({
    required this.byteList,
    this.fileName,
    this.netImagePath,
    this.netImageUrl,
    required this.isRefreshVideo,
  });
}
