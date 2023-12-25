import 'package:admin_web_app/models/memory_file_model.dart';
import 'package:admin_web_app/models/metal_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VisualDetailModel {
  List<MetalModel> metalTypeList;
  Rx<String?> selectedMetalType;
  List<String> rhodiumPlatedList;
  Rx<String?> selectedRhodiumPlated;
  RxList<MemoryFileModel> imageList = <MemoryFileModel>[].obs;
  TextEditingController priceController;
  Rx<MemoryFileModel?> videoBytesData;
  RxInt version;
  RxBool isImageError;
  RxBool isVideoError;

  VisualDetailModel({
    required this.metalTypeList,
    required this.selectedMetalType,
    required this.rhodiumPlatedList,
    required this.selectedRhodiumPlated,
    required this.imageList,
    required this.priceController,
    required this.videoBytesData,
    required this.version,
    required this.isImageError,
    required this.isVideoError,
  });
}
