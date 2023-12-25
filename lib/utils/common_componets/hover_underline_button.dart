import 'package:admin_web_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HoverTextUnderlineButton extends StatelessWidget {
  const HoverTextUnderlineButton(
      {Key? key, required this.btnText, required this.callBack, this.color, required this.isLoading})
      : super(key: key);
  final void Function()? callBack;
  final String btnText;
  final Color? color;
  final RxBool? isLoading;

  @override
  Widget build(BuildContext context) {
    RxBool isHover = false.obs;

    void onHover({required bool value}) {
      if (value == true) {
        isHover.value = true;
      } else {
        isHover.value = false;
      }
    }

    return Obx(() {
      return AbsorbPointer(
        absorbing: isLoading?.value == true ? true : false,
        child: InkWell(
            onTap: callBack,
            onHover: (value) {
              onHover(value: value);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: Obx(() {
                return (isLoading?.value == true)
                    ? Text("Loading....",
                        style: TextStyle(
                          color: color ?? Clr.blackColor,
                          decoration: (isHover.value == true) ? TextDecoration.underline : null,
                          decorationColor: color ?? Clr.blackColor,
                        ))
                    : Text(btnText,
                        style: TextStyle(
                          color: color ?? Clr.blackColor,
                          decoration: (isHover.value == true) ? TextDecoration.underline : null,
                          decorationColor: color ?? Clr.blackColor,
                        ));
              }),
            )),
      );
    });
  }
}
