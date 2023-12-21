import 'package:admin_web_app/utils/route_management/route_names.dart';
import 'package:admin_web_app/views/index_page.dart';
import 'package:admin_web_app/views/otp_verification_screen.dart';
import 'package:admin_web_app/views/signin_screen.dart';
import 'package:admin_web_app/views/splash_screen.dart';
import 'package:get/get.dart';

class RouteGenerator {
  static List<GetPage<dynamic>> generate() {
    return <GetPage<dynamic>>[
      GetPage(
        name: RouteNames.kIndexPageRoute,
        page: () => const IndexPage(),
      ),
      GetPage(
        name: RouteNames.kSplashScreenRoute,
        page: () => const SplashScreen(),
      ),
      GetPage(
        name: RouteNames.kSignInScreenRoute,
        page: () => const SignInScreen(),
      ),
      GetPage(
        name: RouteNames.kOTPVerificationScreenRoute,
        page: () => const OTPVerificationScreen(),
      ),
    ];
  }
}
