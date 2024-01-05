import 'package:admin_web_app/models/auth/otp_model.dart';
import 'package:admin_web_app/models/auth/remember_me_model.dart';
import 'package:admin_web_app/models/auth/user_model.dart';
import 'package:admin_web_app/providers/common_api_provider.dart';
import 'package:admin_web_app/providers/storage_provider.dart';
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
  RxBool isForgotBtnLoading = false.obs;

  ///OnInit Section...............................................................................
  @override
  void onInit() {
    getRememberMeData();
    super.onInit();
  }

  void getRememberMeData() {
    debugPrint("getRememberMeData----------------------->");
    dynamic rememberMeData = StorageProvider.instance.readStorage(key: Consts.rememberDataKey);

    if (rememberMeData != null) {
      RememberMeModel rememberMeModel = RememberMeModel.fromJson(rememberMeData);
      emailController.text = rememberMeModel.email ?? "";
      passController.text = rememberMeModel.pass ?? "";
    }
  }

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
        body: passingData,
      );

      if (data != null) {
        UserModel userModel = UserModel.fromJson(data);

        if (userModel.success == true) {
          //UserData Storage
          await StorageProvider.instance.writeStorage(key: Consts.userDataKey, value: userModel.toJson());

          dynamic readData = StorageProvider.instance.readStorage(key: Consts.userDataKey);
          Consts.userModel = UserModel.fromJson(readData);

          //Remember Me Storage
          if (isRememberMe.value == true) {
            RememberMeModel rememberMeModel = RememberMeModel(
              email: emailController.text,
              pass: passController.text,
            );

            await StorageProvider.instance.writeStorage(key: Consts.rememberDataKey, value: rememberMeModel.toJson());
          } else {
            await StorageProvider.instance.removeStorage(key: Consts.rememberDataKey);
          }

          MyToasts.successToast(toast: userModel.message.toString());
          Get.rootDelegate.offNamed(RouteNames.kIndexPageRoute);
        } else {
          debugPrint("API Success is false: ${userModel.message}");
          MyToasts.errorToast(toast: userModel.message.toString());
        }
      } else {
        debugPrint("Data is null");
      }

      isLoginBtnLoading.value = false;
    }
  }

  Future<void> onForgotPassBtnTapped() async {
    debugPrint("onForgotPassBtnTapped----------------------->");
    isForgotBtnLoading.value = true;
    await onSentOTPCalled();
    isForgotBtnLoading.value = false;
  }

  Future<void> onSentOTPCalled() async {
    debugPrint("onSentOTPCalled----------------------->");
    Map<String, dynamic> passData = {
      Consts.emailAddressKey: Consts.defaultEmail,
    };

    dynamic data = await ApiProvider.commonProvider(
      url: URLs.adminSendOtpUri,
      body: passData,
    );

    if (data != null) {
      OtpModel otpModel = OtpModel.fromJson(data);

      if (otpModel.success == true) {
        debugPrint("API Success is true");
        MyToasts.successToast(toast: otpModel.message ?? "No message");
        Get.rootDelegate.toNamed(RouteNames.kOTPVerificationScreenRoute);
      } else {
        debugPrint("API Success is false: ${otpModel.message}");
        MyToasts.errorToast(toast: otpModel.message ?? "No message");
      }
    } else {
      debugPrint("Data is null");
    }
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
