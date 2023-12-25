import 'package:admin_web_app/controllers/reset_password_controller.dart';
import 'package:admin_web_app/utils/colors.dart';
import 'package:admin_web_app/utils/common_componets/common_text_field.dart';
import 'package:admin_web_app/utils/common_componets/hover_button.dart';
import 'package:admin_web_app/utils/strings.dart';
import 'package:admin_web_app/utils/text_styles.dart';
import 'package:admin_web_app/utils/validate.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  ResetPasswordController controller = Get.put(ResetPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        toolbarHeight: 100,
        backgroundColor: Clr.lightGreyColor,
        elevation: 0,
        title: const Padding(
          padding: EdgeInsets.only(left: 30),
          child: Text(
            Str.appName,
            style: TextStyle(
              color: Clr.primaryColor,
              fontSize: 28,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
        child: Form(
          key: controller.formKey,
          child: Container(
            width: 450,
            margin: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              color: Clr.whiteColor,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                const Center(
                  child: Text(
                    Str.changePassTitleText,
                    style: TextStyle(
                      color: Clr.primaryColor,
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Center(
                  child: Text(
                    Str.changePassSubtitleText,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Clr.greyColor,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Text(
                  "New Password",
                  style: CustomTextStyle.fieldTitleStyle,
                ),
                const SizedBox(height: 5),
                CommonTextField(
                  controller: controller.newPassController,
                  validateType: Validate.Password,
                  isObscure: true,
                ),
                const SizedBox(height: 15),
                Text(
                  "Confirm Password",
                  style: CustomTextStyle.fieldTitleStyle,
                ),
                const SizedBox(height: 5),
                CommonTextField(
                  controller: controller.conPassController,
                  validateType: Validate.Password,
                  isObscure: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return ValidateStr.passwordEmptyValidator;
                    } else if (value != controller.newPassController.text) {
                      return ValidateStr.confirmPasswordValidValidator;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: HoverButton(
                    width: double.infinity,
                    btnText: Str.continueBtnText,
                    callback: controller.onContinueBtnTapped,
                    isLoading: controller.isLoading,
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
