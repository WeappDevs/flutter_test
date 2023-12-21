import 'dart:typed_data';
import 'package:get/get.dart';

class MemoryFileModel {
  Rx<Uint8List?> byteList;
  String? fileName;
  String? netImagePath;

  MemoryFileModel({
    required this.byteList,
    this.fileName,
    this.netImagePath,
  });
}
