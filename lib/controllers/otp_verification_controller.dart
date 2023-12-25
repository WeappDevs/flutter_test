import 'package:admin_web_app/models/auth/otp_model.dart';
import 'package:admin_web_app/models/res/response_model.dart';
import 'package:admin_web_app/providers/common_api_provider.dart';
import 'package:admin_web_app/utils/common_componets/common_toast.dart';
import 'package:admin_web_app/utils/consts.dart';
import 'package:admin_web_app/utils/route_management/route_names.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class OTPVerificationController extends GetxController {
  TextEditingController otpController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;
  RxBool isReSentOTPBtnLoading = false.obs;

  Future<void> onNextBtnTapped() async {
    if (formKey.currentState?.validate() == true) {
      debugPrint("onNextBtnTapped----------------------->");
      isLoading.value = true;
      Map<String, dynamic> passData = {
        Consts.emailAddressKey: Consts.defaultEmail,
        Consts.otpKey: otpController.text,
      };

      dynamic data = await ApiProvider.commonProvider(
        url: URLs.adminVerifyOtpUri,
        bodyData: passData,
      );

      if (data != null) {
        ResponseModel responseModel = ResponseModel.fromJson(data);

        if (responseModel.success == true) {
          debugPrint("API Success is true");
          MyToasts.successToast(toast: responseModel.message ?? "No message");
          Get.rootDelegate.offNamed(RouteNames.kResetPasswordScreenRoute);
        } else {
          debugPrint("API Success is false: ${responseModel.message}");
          MyToasts.errorToast(toast: responseModel.message ?? "No message");
        }
      } else {
        debugPrint("Data is null");
      }

      isLoading.value = false;
    }
  }

  Future<void> onSentOTPCalled() async {
    debugPrint("onSentOTPCalled----------------------->");
    isReSentOTPBtnLoading.value = true;
    Map<String, dynamic> passData = {
      Consts.emailAddressKey: Consts.defaultEmail,
    };

    dynamic data = await ApiProvider.commonProvider(
      url: URLs.adminSendOtpUri,
      bodyData: passData,
    );

    if (data != null) {
      OtpModel otpModel = OtpModel.fromJson(data);

      if (otpModel.success == true) {
        debugPrint("API Success is true");
        MyToasts.successToast(toast: otpModel.message ?? "No message");
      } else {
        debugPrint("API Success is false: ${otpModel.message}");
        MyToasts.errorToast(toast: otpModel.message ?? "No message");
      }
    } else {
      debugPrint("Data is null");
    }
    isReSentOTPBtnLoading.value = false;
  }
}
