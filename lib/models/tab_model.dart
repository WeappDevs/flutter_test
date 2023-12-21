import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class TabModel {
  String tabName;
  IconData tabIcon;
  RxBool isSelectedTab;
  Color? activeColor;

  TabModel({
    required this.tabName,
    required this.tabIcon,
    required this.isSelectedTab,
    this.activeColor,
  });
}
