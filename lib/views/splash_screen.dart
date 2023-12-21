import 'package:admin_web_app/utils/assets.dart';
import 'package:admin_web_app/utils/consts.dart';
import 'package:admin_web_app/utils/route_management/route_names.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    onIndexPageCalled();
    super.initState();
  }

  Future<void> onIndexPageCalled() async {
    await Future.delayed(const Duration(seconds: 2))
        .then((value) {
      Get.rootDelegate.toNamed(RouteNames.kSignInScreenRoute);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 250,
          width: 250,
          decoration: const BoxDecoration(
              image: DecorationImage(
            fit: BoxFit.contain,
            image: AssetImage(LocalPNG.faviconIcon),
          )),
        ),
      ),
    );
  }
}
