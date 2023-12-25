import 'package:get/get.dart';

class FilterModel {
  String filterText;
  RxBool isSelected;
  String categoryText;
  String? paramName;
  num? minPrice;
  num? maxPrice;

  FilterModel(
      {required this.filterText,
      required this.isSelected,
      required this.categoryText,
      this.paramName,
      this.minPrice,
      this.maxPrice});
}
