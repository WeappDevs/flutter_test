// To parse this JSON data, do
//
//     final categoryListModel = categoryListModelFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';

CategoryListModel categoryListModelFromJson(String str) => CategoryListModel.fromJson(json.decode(str));

String categoryListModelToJson(CategoryListModel data) => json.encode(data.toJson());

class CategoryListModel {
  final bool? success;
  final int? statuscode;
  final String? message;
  final RxList<CtDatum>? data;

  CategoryListModel({
    this.success,
    this.statuscode,
    this.message,
    this.data,
  });

  factory CategoryListModel.fromJson(Map<String, dynamic> json) => CategoryListModel(
        success: json["success"],
        statuscode: json["statuscode"],
        message: json["message"],
        data: json["data"] == null
            ? <CtDatum>[].obs
            : List<CtDatum>.from(json["data"]!.map((x) => CtDatum.fromJson(x))).obs,
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "statuscode": statuscode,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class CtDatum {
  final String? id;
  final String? categoryName;
  final String? categoryImage;
  final bool? isDeleted;
  final bool? isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  CtDatum({
    this.id,
    this.categoryName,
    this.categoryImage,
    this.isDeleted,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory CtDatum.fromJson(Map<String, dynamic> json) => CtDatum(
        id: json["_id"],
        categoryName: json["category_name"],
        categoryImage: json["category_image"],
        isDeleted: json["is_deleted"],
        isActive: json["is_active"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "category_name": categoryName,
        "category_image": categoryImage,
        "is_deleted": isDeleted,
        "is_active": isActive,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
