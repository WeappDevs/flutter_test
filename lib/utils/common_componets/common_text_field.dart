import 'package:admin_web_app/utils/custom_texts_formatters/custom_lower_case_formatter.dart';
import 'package:admin_web_app/utils/custom_texts_formatters/custom_no_leading_formatter.dart';
import 'package:admin_web_app/utils/text_field_styles.dart';
import 'package:admin_web_app/utils/validate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CommonTextField extends StatelessWidget {
  CommonTextField(
      {super.key,
      this.controller,
      this.maxLines,
      this.decoration,
      this.validateType,
      this.inputFormatters,
      this.validator,
      this.isNotEmptyValidator,
      this.hintText,
      this.isEmptyText,
      this.isObscure,
      this.onChanged});

  final TextEditingController? controller;
  final InputDecoration? decoration;
  final int? maxLines;
  final Validate? validateType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final String? hintText;
  final String? isEmptyText;
  final void Function(String)? onChanged;

  //It will set validator as not empty
  final bool? isNotEmptyValidator;

  //It will set the suffix icon of the show/hide and make the text secure
  final bool? isObscure;
  final RxBool isObscureVal = true.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      isObscureVal.value;

      return TextFormField(
        decoration: decoration ??
            CustomTextFieldStyle.normalFieldDecoration.copyWith(
              hintText: hintText,
              suffixIcon: (isObscure == true)
                  ? InkWell(
                      onTap: toggleObscureVal,
                      child: (isObscureVal.value == true)
                          ? const Icon(Icons.hide_source_rounded)
                          : const Icon(Icons.panorama_fish_eye),
                    )
                  : null,
            ),
        maxLines: maxLines ?? 1,
        controller: controller,
        inputFormatters: inputFormatters ?? inputFormattersFun(),
        validator: validator ?? validatorFun,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        textInputAction: TextInputAction.next,
        obscureText: (isObscure == true) ? isObscureVal.value : false,
        onChanged: onChanged,
      );
    });
  }

  List<TextInputFormatter> inputFormattersFun() {
    if (validateType != null) {
      if (validateType == Validate.Name || validateType == Validate.LastName) {
        return [
          LengthLimitingTextInputFormatter(35),
          NoLeadingSpaceFormatter(),
          FilteringTextInputFormatter.allow(RegExp("[a-z A-Z á-ú Á-Ú]")),
        ];
      } else if (validateType == Validate.Email) {
        return [
          NoLeadingSpaceFormatter(),
          LowerCaseTextFormatter(),
          FilteringTextInputFormatter.deny(RegExp("[ ]")),
          FilteringTextInputFormatter.deny(RegExp("\$")),
          FilteringTextInputFormatter.deny(RegExp("%")),
          FilteringTextInputFormatter.deny(RegExp("#")),
          FilteringTextInputFormatter.allow(RegExp("[a-zá-ú0-9.,-_@]")),
          LengthLimitingTextInputFormatter(50),
        ];
      } else if (validateType == Validate.Password || validateType == Validate.ConfirmPassword) {
        return [
          LengthLimitingTextInputFormatter(20),
          FilteringTextInputFormatter.deny(RegExp('[ ]')),
          FilteringTextInputFormatter.allow(RegExp("[a-zA-Zá-úÁ-Ú0-9-@\$%&#*]")),
        ];
      } else if (validateType == Validate.PhoneNumber) {
        return [
          NoLeadingSpaceFormatter(),
          LengthLimitingTextInputFormatter(10),
          FilteringTextInputFormatter.allow(RegExp("[0-9]")),
        ];
      } else if (validateType == Validate.Description) {
        return [
          NoLeadingSpaceFormatter(),
          LengthLimitingTextInputFormatter(2000),
          FilteringTextInputFormatter.allow(RegExp("[a-z A-Z á-ú Á-Ú 0-9 .,-]")),
        ];
      } else if (validateType == Validate.OTP) {
        return [
          LengthLimitingTextInputFormatter(4),
          FilteringTextInputFormatter.allow(RegExp("[0-9]")),
        ];
      }

      ///Project Validator
      else if (validateType == Validate.ProductName) {
        return [
          NoLeadingSpaceFormatter(),
          LengthLimitingTextInputFormatter(100),
        ];
      } else if (validateType == Validate.ProductSubTitle) {
        return [
          NoLeadingSpaceFormatter(),
          LengthLimitingTextInputFormatter(300),
        ];
      } else if (validateType == Validate.SKU) {
        return [
          NoLeadingSpaceFormatter(),
          LengthLimitingTextInputFormatter(20),
          FilteringTextInputFormatter.deny(RegExp(" ")),
        ];
      } else if (validateType == Validate.RoundNumeric) {
        return [
          NoLeadingSpaceFormatter(),
          LengthLimitingTextInputFormatter(10),
          FilteringTextInputFormatter.deny(RegExp(" ")),
          FilteringTextInputFormatter.allow(RegExp("[0-9]")),
        ];
      } else if (validateType == Validate.FloatNumeric) {
        return [
          NoLeadingSpaceFormatter(),
          LengthLimitingTextInputFormatter(10),
          FilteringTextInputFormatter.deny(RegExp(" ")),
          FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
          TextInputFormatter.withFunction((oldValue, newValue) {
            final text = newValue.text;
            return text.isEmpty
                ? newValue
                : double.tryParse(text) == null
                    ? oldValue
                    : newValue;
          }),
        ];
      } else if (validateType == Validate.Measurement) {
        return [
          NoLeadingSpaceFormatter(),
          LengthLimitingTextInputFormatter(40),
          FilteringTextInputFormatter.allow(RegExp("[0-9]")),
          FilteringTextInputFormatter.allow(RegExp("x")),
          FilteringTextInputFormatter.allow(RegExp(".")),
          FilteringTextInputFormatter.deny(RegExp(" ")),
        ];
      } else {
        return [
          NoLeadingSpaceFormatter(),
        ];
      }
    }
    return [];
  }

  String? validatorFun(String? value) {
    if (validateType == Validate.Name) {
      if (value!.isEmpty) {
        return isEmptyText ?? ValidateStr.nameEmptyValidator;
      } else if (value.length < 2) {
        return ValidateStr.nameLengthValidator;
      }
      return null;
    } else if (validateType == Validate.LastName) {
      if (value!.isEmpty) {
        return isEmptyText ?? ValidateStr.lastNameEmptyValidator;
      } else if (value.length < 3) {
        return ValidateStr.lastNameLengthValidator;
      }
      return null;
    } else if (validateType == Validate.Email) {
      if (value!.isEmpty) {
        return isEmptyText ?? ValidateStr.emailEmptyValidator;
      } else if (value.contains(RegexValidation.instance.kEmailValid) == false) {
        return ValidateStr.emailValidValidator;
      }
      return null;
    } else if (validateType == Validate.Password || validateType == Validate.ConfirmPassword) {
      if (value!.isEmpty) {
        return isEmptyText ?? ValidateStr.passwordEmptyValidator;
      } else if (value.length < 8) {
        return ValidateStr.passwordValidValidator;
      } else if (value.contains(RegexValidation.instance.kPassValid) == false) {
        return ValidateStr.passValidValidator;
      }
      return null;
    } else if (validateType == Validate.PhoneNumber) {
      if (value!.isEmpty) {
        return isEmptyText ?? ValidateStr.phoneEmptyValidator;
      } else if (value.length <= 6) {
        return ValidateStr.phoneValidValidator;
      }
      return null;
    } else if (validateType == Validate.Description) {
      if (value!.isEmpty) {
        return isEmptyText ?? ValidateStr.descEmptyValidator;
      }
      return null;
    } else if (validateType == Validate.Default || isNotEmptyValidator == true) {
      if (value!.isNotEmpty) {
        return null;
      }
      return isEmptyText ?? ValidateStr.presetValidValidator;
    } else if (validateType == Validate.ProductName) {
      if (value!.isEmpty) {
        return isEmptyText ?? ValidateStr.productNameEmptyValidator;
      } else if (value.length < 5) {
        return ValidateStr.productNameLengthValidator;
      }
      return null;
    } else if (validateType == Validate.ProductSubTitle) {
      if (value!.isEmpty) {
        return isEmptyText ?? ValidateStr.productSubtitleEmptyValidator;
      } else if (value.length < 15) {
        return ValidateStr.productSubtitleLengthValidator;
      }
      return null;
    } else if (validateType == Validate.SKU) {
      if (value!.isEmpty) {
        return isEmptyText ?? ValidateStr.skuEmptyValidator;
      } else if (value.length < 20) {
        return ValidateStr.skuLengthValidator;
      }
      return null;
    } else if (validateType == Validate.OTP) {
      if (value!.isEmpty) {
        return isEmptyText ?? ValidateStr.otpEmptyValidator;
      } else if (value.length < 4) {
        return ValidateStr.otpLengthValidator;
      }
      return null;
    }
    return null;
  }

  void toggleObscureVal() {
    isObscureVal.value = !isObscureVal.value;
  }
}
