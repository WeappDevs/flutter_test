import 'package:get/get.dart';

class ShapeModel {
  String shapeName;
  String shapePath;
  RxBool isSelectedTab;

  ShapeModel({
    required this.shapeName,
    required this.shapePath,
    required this.isSelectedTab,
  });
}
