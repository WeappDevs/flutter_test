import 'package:admin_web_app/controllers/otp_verification_controller.dart';
import 'package:admin_web_app/utils/colors.dart';
import 'package:admin_web_app/utils/common_componets/common_text_field.dart';
import 'package:admin_web_app/utils/common_componets/hover_button.dart';
import 'package:admin_web_app/utils/common_componets/hover_underline_button.dart';
import 'package:admin_web_app/utils/consts.dart';
import 'package:admin_web_app/utils/string_extention.dart';
import 'package:admin_web_app/utils/strings.dart';
import 'package:admin_web_app/utils/validate.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin_web_app/views/widgets/s_txt.dart';

class OTPVerificationScreen extends StatefulWidget {
  const OTPVerificationScreen({Key? key}) : super(key: key);

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  OTPVerificationController controller = Get.put(OTPVerificationController());

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
          child: STxt(
            txt: Str.appName,
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
              children: [
                const SizedBox(height: 40),
                const STxt(
                  txt: Str.verificationText,
                  style: TextStyle(
                    color: Clr.primaryColor,
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                STxt(
                  txt: "${Str.verificationSubTitleText} ${Consts.defaultEmail.maskedEmail}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Clr.greyColor,
                  ),
                ),
                const SizedBox(height: 40),
                CommonTextField(
                  hintText: Str.verificationHintText,
                  maxLines: 1,
                  validateType: Validate.OTP,
                  controller: controller.otpController,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    HoverTextUnderlineButton(
                      btnText: Str.resendOTPBtnText,
                      callBack: controller.onSentOTPCalled,
                      isLoading: controller.isReSentOTPBtnLoading,
                    )
                  ],
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: HoverButton(
                    width: double.infinity,
                    btnText: Str.nextBtnText,
                    callback: controller.onNextBtnTapped,
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
