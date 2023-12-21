import 'package:admin_web_app/utils/colors.dart';
import 'package:admin_web_app/utils/route_management/route_generator.dart';
import 'package:admin_web_app/utils/scrollers/custom_scroll.dart';
import 'package:admin_web_app/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:oktoast/oktoast.dart';
import 'package:url_strategy/url_strategy.dart';

///Flutter 3.7.6
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await GetStorage.init();

  setPathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return OKToast(
      animationCurve: Curves.easeIn,
      animationDuration: const Duration(milliseconds: 200),
      duration: const Duration(seconds: 3),
      position: const ToastPosition(align: Alignment.topRight),
      // Get.rootDelegate.popHistory();
      // Get.rootDelegate.offNamed(RouteNames.kIndexPageRoute);
      child: GlobalLoaderOverlay(
        overlayColor: Clr.transparentColor,
        child: GetMaterialApp.router(
          title: "GreenWave",
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: Str.fontFamily,
            primarySwatch: Clr.primarySwatchColor,
            scaffoldBackgroundColor: Clr.lightGreyColor,
          ),
          getPages: RouteGenerator.generate(),
          scrollBehavior: MyCustomScrollBehavior(),
          defaultTransition: Transition.native,
          // initialRoute: RouteNames.kIndexPageRoute,
        ),
      ),
    );
  }
}
