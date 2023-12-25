enum Validate {
  Name,
  Email,
  PhoneNumber,
  LastName,
  Password,
  ConfirmPassword,
  Description,
  Default,
  OTP,

  ///Project Validator
  ProductName,
  ProductSubTitle,
  SKU,
  RoundNumeric,
  FloatNumeric,
  Measurement,
}

enum Loader { Show, Hide }

class RegexValidation {
  RegexValidation._();

  static final RegexValidation instance = RegexValidation._();

  final RegExp kEmailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  final RegExp kPassValid = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{7,}$');
  final RegExp kPhoneValid = RegExp(r"([0-9]{8,12}$)");
}

class ValidateStr {
  ///validation text
  static String nameEmptyValidator = "Please enter your name";
  static String skuEmptyValidator = "Please enter sku";
  static String otpEmptyValidator = "Please enter otp";
  static String productNameEmptyValidator = "Please enter product name";
  static String productSubtitleEmptyValidator = "Please enter product subtitle";
  static String nameLengthValidator = "Name must be 2 character long";
  static String skuLengthValidator = "Please enter the complete 20 character sku";
  static String otpLengthValidator = "Please enter the complete 4 digit otp";
  static String productNameLengthValidator = "Product name must be more than 5 character long";
  static String productSubtitleLengthValidator = "Product name must be more than 15 character long";
  static String lastNameEmptyValidator = "Please enter your last name";
  static String lastNameLengthValidator = "Name must be 3 character long";
  static String emailEmptyValidator = "Please enter your email";
  static String emailValidValidator = "Please enter valid email";
  static String passwordEmptyValidator = "Please enter your password";
  static String passwordValidValidator = "Entered password should be minimum 8 character long";
  static String passValidValidator =
      "password must have at least one lowercase, uppercase, digit, and special characters (!\$@%#) and at least 8 characters";

  static String confirmPasswordValidValidator = "confirm password is not same as the new password";
  static String phoneEmptyValidator = "Please enter phone number";
  static String phoneValidValidator = "Please enter valid phone number.";
  static String descEmptyValidator = "Please enter description.";
  static String presetValidValidator = "Please enter value.";
  static String presetDropDownValidValidator = "Please select the one option";
}
