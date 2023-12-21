import 'package:admin_web_app/models/auth/login_model.dart';
import 'package:admin_web_app/providers/common_api_provider.dart';
import 'package:admin_web_app/utils/common_componets/common_toast.dart';
import 'package:admin_web_app/utils/consts.dart';
import 'package:admin_web_app/utils/route_management/route_names.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  RxBool isRememberMe = true.obs;
  RxBool isLoginBtnLoading = false.obs;

  Future<void> onSignInBtnTapped() async {
    debugPrint("onSignInBtnTapped----------------------->");
    if (formKey.currentState?.validate() == true) {
      isLoginBtnLoading.value = true;

      Map<String, dynamic> passingData = {
        Consts.emailAddressKey: emailController.text,
        Consts.passwordKey: passController.text,
      };

      ///API Calling
      dynamic data = await ApiProvider.commonProvider(
        url: URLs.adminLoginUri,
        bodyData: passingData,
        header: {
          // "Access-Control-Allow-Origin": "*",
          // 'Content-Type': 'multipart/form-data; boundary=<calculated when request is sent>',
          // 'Accept': '*/*',
          // "Authorization":
          //     'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY1Nzg5ZmE4MGIxZTYyODMxODgyMjI3MiIsImlhdCI6MTcwMjQwNDAwOH0.8aHdi6qHLMVQMh9Ew4IrT2UCOqJ0RwX-uUBj45XFV3Y'
        },
      );

      if (data != null) {
        LoginModel loginModel = LoginModel.fromJson(data);

        if (loginModel.success == true) {
          MyToasts.successToast(toast: loginModel.message.toString());
          Get.rootDelegate.offNamed(RouteNames.kIndexPageRoute);
        } else {
          debugPrint("API Success is false: ${loginModel.message}");
          MyToasts.errorToast(toast: loginModel.message.toString());
        }
      } else {
        debugPrint("Data is null");
      }

      isLoginBtnLoading.value = false;
    }
  }

  void onForgotPassBtnTapped() {
    debugPrint("onForgotPassBtnTapped----------------------->");
    Get.rootDelegate.toNamed(RouteNames.kOTPVerificationScreenRoute);
  }

  void onRememberMeChanged({required bool? newValue}) {
    debugPrint("onRememberMeChanged----------------------->");
    if (newValue != null) {
      isRememberMe.value = newValue;
    } else {
      debugPrint("Checkbox value is null");
    }
  }
}
