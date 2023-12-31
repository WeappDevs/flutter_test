// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  final bool? success;
  final int? statuscode;
  final String? message;
  final UData? data;

  UserModel({
    this.success,
    this.statuscode,
    this.message,
    this.data,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        success: json["success"],
        statuscode: json["statuscode"],
        message: json["message"],
        data: json["data"] == null ? null : UData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "statuscode": statuscode,
        "message": message,
        "data": data?.toJson(),
      };
}

class UData {
  final String? id;
  final String? firstName;
  final String? emailAddress;
  final dynamic otp;
  final bool? isSocialLogin;
  final int? notiBadge;
  final String? userType;
  final bool? isDeleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? token;

  UData({
    this.id,
    this.firstName,
    this.emailAddress,
    this.otp,
    this.isSocialLogin,
    this.notiBadge,
    this.userType,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.token,
  });

  factory UData.fromJson(Map<String, dynamic> json) => UData(
        id: json["_id"],
        firstName: json["first_name"],
        emailAddress: json["email_address"],
        otp: json["otp"],
        isSocialLogin: json["is_social_login"],
        notiBadge: json["noti_badge"],
        userType: json["user_type"],
        isDeleted: json["is_deleted"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "first_name": firstName,
        "email_address": emailAddress,
        "otp": otp,
        "is_social_login": isSocialLogin,
        "noti_badge": notiBadge,
        "user_type": userType,
        "is_deleted": isDeleted,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "token": token,
      };
}
