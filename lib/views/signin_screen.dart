import 'package:admin_web_app/controllers/signin_controller.dart';
import 'package:admin_web_app/utils/colors.dart';
import 'package:admin_web_app/utils/common_componets/common_text_field.dart';
import 'package:admin_web_app/utils/common_componets/hover_button.dart';
import 'package:admin_web_app/utils/common_componets/hover_underline_button.dart';
import 'package:admin_web_app/utils/strings.dart';
import 'package:admin_web_app/utils/validate.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  SignInController controller = Get.put(SignInController());

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
        child: Container(
          width: 450,
          margin: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            color: Clr.whiteColor,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(20),
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 40),
                const Text(
                  Str.signInText,
                  style: TextStyle(
                    color: Clr.primaryColor,
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  Str.signInSubTitleText,
                  style: TextStyle(
                    color: Clr.greyColor,
                  ),
                ),
                const SizedBox(height: 40),
                CommonTextField(
                  maxLines: 1,
                  hintText: Str.emailHintText,
                  controller: controller.emailController,
                  validateType: Validate.Email,
                ),
                const SizedBox(height: 30),
                CommonTextField(
                  maxLines: 1,
                  hintText: Str.passHintText,
                  controller: controller.passController,
                  validateType: Validate.Password,
                  isObscure: true,
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Obx(() {
                      return Checkbox(
                        value: controller.isRememberMe.value,
                        side: const BorderSide(width: .5),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
                        onChanged: (value) {
                          controller.onRememberMeChanged(newValue: value);
                        },
                      );
                    }),
                    const SizedBox(width: 5),
                    const Text("Remember Me"),
                    const Spacer(),
                    HoverTextUnderlineButton(
                      btnText: Str.forgotPassBtnText,
                      callBack: controller.onForgotPassBtnTapped,
                      isLoading: controller.isForgotBtnLoading,
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: HoverButton(
                    width: double.infinity,
                    btnText: Str.loginBtnText,
                    isLoading: controller.isLoginBtnLoading,
                    callback: controller.onSignInBtnTapped,
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
