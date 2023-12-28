import 'package:admin_web_app/models/product/product_detail_model.dart';
import 'package:get/get.dart';

class VMediaTabModel {
  VisualDetails visualDetails;
  RxBool? isVideoSelected;
  Rx<String?> selectedMediaPath;
  RxBool isSelected;
  int index;

  VMediaTabModel({
    required this.visualDetails,
    this.isVideoSelected,
    required this.selectedMediaPath,
    required this.isSelected,
    required this.index,
  });
}
