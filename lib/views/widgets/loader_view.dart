import 'package:admin_web_app/utils/colors.dart';
import 'package:admin_web_app/utils/text_styles.dart';
import 'package:admin_web_app/views/widgets/glassmorphism.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class MyLoader {
  static show() {
    return Get.context!.loaderOverlay.show(widget: const LoaderView());
  }

  static hide() {
    return Get.context!.loaderOverlay.hide();
  }
}

class LoaderView extends StatelessWidget {
  const LoaderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GlassmorphicContainer(
        width: double.infinity,
        height: double.infinity,
        borderRadius: 1,
        blur: 4,
        alignment: Alignment.bottomCenter,
        border: 15,
        linearGradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [
          Clr.greyColor.withOpacity(0.1),
          Clr.greyColor.withOpacity(0.05),
        ], stops: const [
          0.1,
          1,
        ]),
        borderGradient: const LinearGradient(
          colors: [Clr.transparentColor, Clr.transparentColor],
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LoadingAnimationWidget.halfTriangleDot(color: Clr.blackColor, size: 50),
              const SizedBox(height: 20),
              Text("Hold on a moment...", style: CustomTextStyle.mediumGreyStyle.copyWith(color: Clr.primaryColor))
            ],
          ),
        ),
      ),
    );
  }
}
