import 'package:admin_web_app/utils/route_management/route_names.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class OTPVerificationController extends GetxController {
  TextEditingController otpController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();


  void onContinueBtnTapped() {
    if(formKey.currentState?.validate() == true){
      Get.rootDelegate.offNamed(RouteNames.kIndexPageRoute);
    }
  }
}
