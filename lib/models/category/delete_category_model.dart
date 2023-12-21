// To parse this JSON data, do
//
//     final deleteCategoryModel = deleteCategoryModelFromJson(jsonString);

import 'dart:convert';

DeleteModel deleteCategoryModelFromJson(String str) => DeleteModel.fromJson(json.decode(str));

String deleteCategoryModelToJson(DeleteModel data) => json.encode(data.toJson());

class DeleteModel {
  final bool? success;
  final int? statuscode;
  final String? message;
  final List<dynamic>? data;

  DeleteModel({
    this.success,
    this.statuscode,
    this.message,
    this.data,
  });

  factory DeleteModel.fromJson(Map<String, dynamic> json) => DeleteModel(
        success: json["success"],
        statuscode: json["statuscode"],
        message: json["message"],
        data: json["data"] == null ? [] : List<dynamic>.from(json["data"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "statuscode": statuscode,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x)),
      };
}
