import 'package:flutter/material.dart';

class Clr {
  static const Color blackColor = Color(0xFF000000);
  static const Color whiteColor = Color(0xFFffffff);
  static const Color primaryColor = Color(0xFF89c0ae);
  static const Color greyShadeColor = Color(0xFF5e7173);
  static const MaterialColor primarySwatchColor = MaterialColor(
    0xFF89c0ae,
    <int, Color>{
      50: Color(0xFF89c0ae),
      100: Color(0xFF89c0ae),
      200: Color(0xFF89c0ae),
      300: Color(0xFF89c0ae),
      400: Color(0xFF89c0ae),
      500: Color(0xFF89c0ae),
      600: Color(0xFF89c0ae),
      700: Color(0xFF89c0ae),
      800: Color(0xFF89c0ae),
      900: Color(0xFF89c0ae),
    },
  );
  static const Color greyColor = Colors.grey;
  static const Color redColor = Colors.red;
  static const Color blueColor = Colors.blue;
  static const Color amberColor = Colors.amber;
  static const Color greenColor = Colors.green;
  static const Color orangeColor = Colors.orangeAccent;
  static const Color indigoColor = Colors.indigoAccent;
  static const Color greyShadowColor = Color(0xff808080);
  static const Color lightGreyColor = Color(0xfffafafa);
  static const Color veryLightGreyColor = Color(0xfff1f1f1);
  static const Color transparentColor = Colors.transparent;
  static const Color darkGreyColor = Color(0xff4a4a4a);
  static const Color iconGreyColor = Color(0xff6b717f);
  static const Color smallDescGreyColor = Color(0xffa6a7ac);
  static const Color tableHeaderGreyColor = Color(0xfff5f5f5);
  static const Color dialogGreyColor = Color(0xff797979);
  static const Color decentGreyColor = Color(0xffd4d4d4);

  ///Toast Colors
  static const Color toastTextClr = Color(0xFF767676);
  static const Color successBgClr = Color(0xFFEEFFE9);
  static const Color successBottomClr = Color(0xFF359918);
  static const Color errorBgClr = Color(0xFFFFEBE8);
  static const Color errorBottomClr = Color(0xFFD65745);
  static const Color warningBgClr = Color(0xFFFFFAEC);
  static const Color warningBottomClr = Color(0xFFEAC645);
  static const Color infoBgClr = Color(0xFFEEF7FF);
  static const Color infoBottomClr = Color(0xFF5296D5);

  ///Shimmer Colors
  static Color shimmerBaseClr = Colors.grey.shade200;
  static Color shimmerHighlightClr = Colors.grey.shade100;

  ///Image
  static Color imageBGClr = Clr.decentGreyColor.withOpacity(.3);
}
