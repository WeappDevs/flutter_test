import 'package:admin_web_app/utils/assets.dart';
import 'package:admin_web_app/utils/colors.dart';
import 'package:admin_web_app/utils/common_componets/hover_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CustomDialog {
  static void dialog({
    double? height,
    double? width,
    Widget? child,
    AlignmentGeometry? alignment,
    bool barrierDismissible = true,
  }) {
    Get.dialog(
      barrierDismissible: barrierDismissible,
      Dialog(
        insetPadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        child: Container(
          height: height,
          width: width ?? 450,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Clr.whiteColor),
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
          child: child,
        ),
      ),
    );
  }

  ///Use the hero widget for better effect
  static void successDialog({
    double? width,
    bool barrierDismissible = true,
    required String title,
    String? subtitle,
    bool? isSingleBtn,
    String? btnText,
    String? btnText2,
    void Function()? callback,
    void Function()? callback2,
  }) {
    Get.dialog(
      barrierDismissible: barrierDismissible,
      Dialog(
        insetPadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: width ?? 430,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Clr.whiteColor),
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
            child: WillPopScope(
              onWillPop: () {
                return Future(() => barrierDismissible);
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SvgPicture.asset(LocalSVG.tickDialogIcon),
                  const SizedBox(height: 20),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 10),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Clr.dialogGreyColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                  const SizedBox(height: 30),
                  if (isSingleBtn == true) ...[
                    HoverButton(
                      width: double.infinity,
                      btnText: btnText ?? "Back to Home",
                      callback: callback ??
                          () {
                            Get.back();
                          },
                    )
                  ] else ...[
                    Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: HoverUnderlineButton(
                            btnText: btnText2 ?? "Back",
                            callback: callback2 ??
                                () {
                                  Get.back();
                                },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Flexible(
                          flex: 1,
                          child: HoverButton(
                            btnText: btnText ?? "Confirm",
                            callback: callback ??
                                () {
                                  Get.back();
                                },
                          ),
                        ),
                      ],
                    )
                  ]
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  static void failureDialog({
    double? width,
    bool barrierDismissible = true,
    required String title,
    String? subtitle,
    bool? isSingleBtn,
    String? btnText,
    String? btnText2,
    void Function()? callback,
    void Function()? callback2,
    RxBool? isLoading,
  }) {
    Get.dialog(
      barrierDismissible: barrierDismissible,
      Dialog(
        insetPadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: width ?? 430,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Clr.whiteColor),
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
            child: WillPopScope(
              onWillPop: () {
                return Future(() => barrierDismissible);
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SvgPicture.asset(LocalSVG.untickDialogIcon),
                  const SizedBox(height: 20),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 10),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Clr.dialogGreyColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                  const SizedBox(height: 30),
                  if (isSingleBtn == true) ...[
                    HoverButton(
                      width: double.infinity,
                      btnText: btnText ?? "Back to Home",
                      callback: callback ??
                          () {
                            Get.back();
                          },
                    )
                  ] else ...[
                    Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: HoverUnderlineButton(
                            btnText: btnText2 ?? "Back",
                            callback: callback2 ??
                                () {
                                  Get.back();
                                },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Flexible(
                          flex: 1,
                          child: HoverButton(
                            btnText: btnText ?? "Confirm",
                            isLoading: isLoading,
                            callback: callback ??
                                () {
                                  Get.back();
                                },
                          ),
                        ),
                      ],
                    )
                  ]
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
