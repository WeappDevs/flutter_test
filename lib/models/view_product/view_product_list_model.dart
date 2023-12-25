// To parse this JSON data, do
//
//     final viewProductListModel = viewProductListModelFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';

ViewProductListModel viewProductListModelFromJson(String str) => ViewProductListModel.fromJson(json.decode(str));

String viewProductListModelToJson(ViewProductListModel data) => json.encode(data.toJson());

class ViewProductListModel {
  final bool? success;
  final int? statuscode;
  final String? message;
  final int? totalNumberOfData;
  final String? currentPage;
  final RxList<VDatum>? data;

  ViewProductListModel({
    this.success,
    this.statuscode,
    this.message,
    this.totalNumberOfData,
    this.currentPage,
    this.data,
  });

  factory ViewProductListModel.fromJson(Map<String, dynamic> json) => ViewProductListModel(
        success: json["success"],
        statuscode: json["statuscode"],
        message: json["message"],
        totalNumberOfData: json["total_number_of_data"],
        currentPage: json["current_page"],
        data:
            json["data"] == null ? <VDatum>[].obs : List<VDatum>.from(json["data"]!.map((x) => VDatum.fromJson(x))).obs,
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "statuscode": statuscode,
        "message": message,
        "total_number_of_data": totalNumberOfData,
        "current_page": currentPage,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class VDatum {
  final String? id;
  final CategoryId? categoryId;
  final String? name;
  final num? generalPrice;
  final AdditionalDetails? additionalDetails;
  final RxBool? inWaiting;

  VDatum({
    this.id,
    this.categoryId,
    this.name,
    this.generalPrice,
    this.additionalDetails,
    this.inWaiting,
  });

  factory VDatum.fromJson(Map<String, dynamic> json) => VDatum(
        id: json["_id"],
        categoryId: json["category_id"] == null ? null : CategoryId.fromJson(json["category_id"]),
        name: json["name"],
        generalPrice: json["general_price"],
        inWaiting: json["in_waiting"] == null
            ? false.obs
            : (json["in_waiting"].toString() == "true")
                ? true.obs
                : false.obs,
        additionalDetails:
            json["additional_details"] == null ? null : AdditionalDetails.fromJson(json["additional_details"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "category_id": categoryId?.toJson(),
        "name": name,
        "general_price": generalPrice,
        "additional_details": additionalDetails?.toJson(),
        "in_waiting": inWaiting?.value,
      };
}

class AdditionalDetails {
  final String? productSku;
  final String? style;

  AdditionalDetails({
    this.productSku,
    this.style,
  });

  factory AdditionalDetails.fromJson(Map<String, dynamic> json) => AdditionalDetails(
        productSku: json["product_sku"],
        style: json["style"],
      );

  Map<String, dynamic> toJson() => {
        "product_sku": productSku,
        "style": style,
      };
}

class CategoryId {
  final String? id;
  final String? categoryName;
  final String? categoryImage;

  CategoryId({
    this.id,
    this.categoryName,
    this.categoryImage,
  });

  factory CategoryId.fromJson(Map<String, dynamic> json) => CategoryId(
        id: json["_id"],
        categoryName: json["category_name"],
        categoryImage: json["category_image"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "category_name": categoryName,
        "category_image": categoryImage,
      };
}
