import 'package:admin_web_app/models/res/response_model.dart';
import 'package:admin_web_app/providers/common_api_provider.dart';
import 'package:admin_web_app/providers/storage_provider.dart';
import 'package:admin_web_app/utils/common_componets/common_toast.dart';
import 'package:admin_web_app/utils/consts.dart';
import 'package:admin_web_app/utils/route_management/route_names.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;
  TextEditingController newPassController = TextEditingController();
  TextEditingController conPassController = TextEditingController();

  Future<void> onContinueBtnTapped() async {
    debugPrint("onContinueBtnTapped------------------->");
    if (formKey.currentState?.validate() == true) {
      Map<String, dynamic> bodyData = {
        Consts.emailAddressKey: Consts.defaultEmail,
        Consts.passwordKey: newPassController.text,
      };

      dynamic data = await ApiProvider.commonProvider(
        url: URLs.adminResetPasswordUri,
        bodyData: bodyData,
      );

      if (data != null) {
        ResponseModel rModel = ResponseModel.fromJson(data);

        if (rModel.success == true) {
          await StorageProvider.instance.removeStorage(key: Consts.userDataKey);

          isLoading.value = false;
          MyToasts.successToast(toast: rModel.message ?? "No Message");
          Get.rootDelegate.toNamed(RouteNames.kSignInScreenRoute);
        } else {
          MyToasts.errorToast(toast: rModel.message ?? "No Message");
        }
      } else {
        debugPrint("Data is null");
      }
    }
  }
}
