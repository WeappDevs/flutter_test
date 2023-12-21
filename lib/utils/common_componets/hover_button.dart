import 'package:admin_web_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class HoverButton extends StatelessWidget {
  const HoverButton({
    Key? key,
    required this.btnText,
    this.height,
    this.width,
    this.isLoading,
    required this.callback,
  }) : super(key: key);
  final String btnText;
  final double? height;
  final double? width;
  final RxBool? isLoading;
  final void Function()? callback;

  @override
  Widget build(BuildContext context) {
    Rx<Color> buttonColor = Clr.blackColor.obs;

    void onHover({required bool value}) {
      if (value == true) {
        buttonColor.value = Clr.primaryColor;
      } else {
        buttonColor.value = Clr.blackColor;
      }
    }

    return Obx(() {
      return AbsorbPointer(
        absorbing: isLoading?.value == true ? true : false,
        child: InkWell(
          onTap: callback,
          onHover: (value) {
            onHover(value: value);
          },
          child: Container(
            height: height ?? 45,
            width: width ?? 400,
            decoration: BoxDecoration(
              color: buttonColor.value,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: (isLoading?.value == true)
                  ? LoadingAnimationWidget.fallingDot(color: Clr.whiteColor, size: 32)
                  : Text(
                      btnText,
                      style: const TextStyle(color: Colors.white),
                    ),
            ),
          ),
        ),
      );
    });
  }
}

class HoverUnderlineButton extends StatelessWidget {
  const HoverUnderlineButton({
    Key? key,
    required this.btnText,
    this.height,
    this.width,
    this.isLoading,
    required this.callback,
  }) : super(key: key);
  final String btnText;
  final double? height;
  final double? width;
  final bool? isLoading;
  final void Function()? callback;

  @override
  Widget build(BuildContext context) {
    Rx<Color> buttonColor = Clr.greyColor.obs;

    void onHover({required bool value}) {
      if (value == true) {
        buttonColor.value = Clr.primaryColor;
      } else {
        buttonColor.value = Clr.greyColor;
      }
    }

    return Obx(() {
      return AbsorbPointer(
        absorbing: isLoading == true ? true : false,
        child: InkWell(
          onTap: callback,
          onHover: (value) {
            onHover(value: value);
          },
          child: Container(
            height: height ?? 45,
            width: width ?? 400,
            decoration: BoxDecoration(
              border: Border.all(color: buttonColor.value),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: /*(isLoading == true)
                  ? LoadingAnimationWidget.fallingDot(color: Clr.whiteColor, size: 32)
                  :*/
                  Text(
                btnText,
                style: TextStyle(
                    color: buttonColor.value,
                    fontWeight: (buttonColor.value == Clr.primaryColor) ? FontWeight.w600 : null),
              ),
            ),
          ),
        ),
      );
    });
  }
}
