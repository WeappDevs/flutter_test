// To parse this JSON data, do
//
//     final otpModel = otpModelFromJson(jsonString);

import 'dart:convert';

OtpModel otpModelFromJson(String str) => OtpModel.fromJson(json.decode(str));

String otpModelToJson(OtpModel data) => json.encode(data.toJson());

class OtpModel {
  final bool? success;
  final int? statuscode;
  final String? message;
  final int? data;

  OtpModel({
    this.success,
    this.statuscode,
    this.message,
    this.data,
  });

  factory OtpModel.fromJson(Map<String, dynamic> json) => OtpModel(
        success: json["success"],
        statuscode: json["statuscode"],
        message: json["message"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "statuscode": statuscode,
        "message": message,
        "data": data,
      };
}
