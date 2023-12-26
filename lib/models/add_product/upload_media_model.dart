// To parse this JSON data, do
//
//     final uploadMediaModel = uploadMediaModelFromJson(jsonString);

import 'dart:convert';

UploadMediaModel uploadMediaModelFromJson(String str) => UploadMediaModel.fromJson(json.decode(str));

String uploadMediaModelToJson(UploadMediaModel data) => json.encode(data.toJson());

class UploadMediaModel {
  final bool? success;
  final int? statuscode;
  final String? message;
  final UMData? data;

  UploadMediaModel({
    this.success,
    this.statuscode,
    this.message,
    this.data,
  });

  factory UploadMediaModel.fromJson(Map<String, dynamic> json) => UploadMediaModel(
        success: json["success"],
        statuscode: json["statuscode"],
        message: json["message"],
        data: json["data"] == null ? null : UMData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "statuscode": statuscode,
        "message": message,
        "data": data?.toJson(),
      };
}

class UMData {
  final List<String>? productImages;
  final String? productVideo;

  UMData({
    this.productImages,
    this.productVideo,
  });

  factory UMData.fromJson(Map<String, dynamic> json) => UMData(
        productImages: json["product_images"] == null ? [] : List<String>.from(json["product_images"]!.map((x) => x)),
        productVideo: json["product_video"],
      );

  Map<String, dynamic> toJson() => {
        "product_images": productImages == null ? [] : List<dynamic>.from(productImages!.map((x) => x)),
        "product_video": productVideo,
      };
}
