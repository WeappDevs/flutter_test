import 'package:admin_web_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddBtn extends StatelessWidget {
  final void Function()? onTap;
  final String btnText;
  final TextStyle? btnTextStyle;
  final double? height;
  final double? width;

  const AddBtn({super.key, this.onTap, required this.btnText, this.btnTextStyle, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    RxBool isHover = false.obs;

    return GestureDetector(
      onTap: onTap,
      child: MouseRegion(
        onHover: (event) {
          isHover.value = true;
        },
        onExit: (event) {
          isHover.value = false;
        },
        child: Obx(() {
          return Container(
            height: height ?? 60,
            width: width ?? 700,
            decoration: BoxDecoration(
              color: (isHover.value == true) ? Clr.primaryColor : Clr.blackColor,
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: Text(
              btnText,
              style: btnTextStyle ??
                  const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Clr.whiteColor,
                  ),
            ),
          );
        }),
      ),
    );
  }
}
