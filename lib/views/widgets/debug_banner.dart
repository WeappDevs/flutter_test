import 'package:admin_web_app/utils/colors.dart';
import 'package:flutter/material.dart';

class DebugBanner extends StatelessWidget {
  final Widget child;

  const DebugBanner({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    // assert(() {
    //   return true; // Always true in debug mode
    // }(), 'Debug banner is only meant to be shown in debug mode.');

    return Tooltip(
      message:
          "This banner is for testing purposes only and is intended for developers.",
      child: Banner(
        message: 'DEBUG',
        location: BannerLocation.topEnd,
        color: Clr.redColor,
        child: child,
      ),
    );
  }
}
