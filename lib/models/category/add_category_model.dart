// To parse this JSON data, do
//
//     final addCategoryModel = addCategoryModelFromJson(jsonString);

import 'dart:convert';

import 'package:admin_web_app/models/add_product/category_list_model.dart';

AddCategoryModel addCategoryModelFromJson(String str) => AddCategoryModel.fromJson(json.decode(str));

String addCategoryModelToJson(AddCategoryModel data) => json.encode(data.toJson());

class AddCategoryModel {
  final bool? success;
  final int? statuscode;
  final String? message;
  final CtDatum? data;

  AddCategoryModel({
    this.success,
    this.statuscode,
    this.message,
    this.data,
  });

  factory AddCategoryModel.fromJson(Map<String, dynamic> json) => AddCategoryModel(
        success: json["success"],
        statuscode: json["statuscode"],
        message: json["message"],
        data: json["data"] == null ? null : CtDatum.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "statuscode": statuscode,
        "message": message,
        "data": data?.toJson(),
      };
}
