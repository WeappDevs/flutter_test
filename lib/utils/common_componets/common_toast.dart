import 'package:admin_web_app/utils/assets.dart';
import 'package:admin_web_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oktoast/oktoast.dart';

class MyToasts {
  static void successToast({Color? color, required String toast}) {
    final Widget widget = Container(
      width: 400,
      decoration: const BoxDecoration(
          color: Clr.successBgClr,
          border: Border(
            bottom: BorderSide(
              color: Clr.successBottomClr,
              width: 5,
              style: BorderStyle.solid,
            ),
          )),
      margin: const EdgeInsets.only(right: 15, top: 15),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Row(
        children: [
          const SizedBox(width: 10),
          SvgPicture.asset(LocalSVG.successToastIcon),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              toast,
              style: const TextStyle(color: Clr.toastTextClr, fontWeight: FontWeight.w400, fontSize: 16),
            ),
          ),
        ],
      ),
    );

    showToastWidget(
      widget,
      onDismiss: () {
        debugPrint('Toast has been dismissed.');
      },
    );
  }

  static void errorToast({Color? color, required String toast}) {
    final Widget widget = Container(
      width: 400,
      decoration: const BoxDecoration(
          color: Clr.errorBgClr,
          border: Border(
            bottom: BorderSide(
              color: Clr.errorBottomClr,
              width: 5,
              style: BorderStyle.solid,
            ),
          )),
      margin: const EdgeInsets.only(right: 15, top: 15),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Row(
        children: [
          const SizedBox(width: 10),
          SvgPicture.asset(LocalSVG.errorToastIcon),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              toast,
              style: const TextStyle(color: Clr.toastTextClr, fontWeight: FontWeight.w400, fontSize: 16),
            ),
          ),
        ],
      ),
    );

    showToastWidget(
      widget,
      onDismiss: () {
        debugPrint('Toast has been dismissed.');
      },
    );
  }

  static void warningToast({Color? color, required String toast}) {
    final Widget widget = Container(
      width: 400,
      decoration: const BoxDecoration(
          color: Clr.warningBgClr,
          border: Border(
            bottom: BorderSide(
              color: Clr.warningBottomClr,
              width: 5,
              style: BorderStyle.solid,
            ),
          )),
      margin: const EdgeInsets.only(right: 15, top: 15),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Row(
        children: [
          const SizedBox(width: 10),
          SvgPicture.asset(LocalSVG.warningToastIcon),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              toast,
              style: const TextStyle(color: Clr.toastTextClr, fontWeight: FontWeight.w400, fontSize: 16),
            ),
          ),
        ],
      ),
    );

    showToastWidget(
      widget,
      onDismiss: () {
        debugPrint('Toast has been dismissed.');
      },
    );
  }

  static void infoToast({Color? color, required String toast}) {
    final Widget widget = Container(
      width: 400,
      decoration: const BoxDecoration(
          color: Clr.infoBgClr,
          border: Border(
            bottom: BorderSide(
              color: Clr.infoBottomClr,
              width: 5,
              style: BorderStyle.solid,
            ),
          )),
      margin: const EdgeInsets.only(right: 15, top: 15),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Row(
        children: [
          const SizedBox(width: 10),
          SvgPicture.asset(LocalSVG.infoToastIcon),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              toast,
              style: const TextStyle(color: Clr.toastTextClr, fontWeight: FontWeight.w400, fontSize: 16),
            ),
          ),
        ],
      ),
    );

    showToastWidget(
      widget,
      onDismiss: () {
        debugPrint('Toast has been dismissed.');
      },
    );
  }
}
