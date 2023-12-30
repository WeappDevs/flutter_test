// To parse this JSON data, do
//
//     final productDetailModel = productDetailModelFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';

ProductDetailModel productDetailModelFromJson(String str) => ProductDetailModel.fromJson(json.decode(str));

String productDetailModelToJson(ProductDetailModel data) => json.encode(data.toJson());

class ProductDetailModel {
  final bool? success;
  final int? statuscode;
  final String? message;
  final Rx<PData?>? data;

  ProductDetailModel({
    this.success,
    this.statuscode,
    this.message,
    this.data,
  });

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) => ProductDetailModel(
        success: json["success"],
        statuscode: json["statuscode"],
        message: json["message"],
        data: json["data"] == null ? Rx<PData?>(null) : PData.fromJson(json["data"]).obs,
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "statuscode": statuscode,
        "message": message,
        "data": data?.toJson(),
      };
}

class PData {
  final String? id;
  final CategoryId? categoryId;
  final String? name;
  final String? subTitle;
  final String? description;
  final String? gender;
  final num? generalPrice;
  final AdditionalDetails? additionalDetails;
  final DiamondDetails? diamondDetails;
  final DiamondDetails? sideDiamondDetails;
  final String? shippingDetails;
  final String? customShippingDetails;
  final String? returnDetails;
  final String? customReturnDetails;
  final List<VisualDetails>? visualDetails;
  final num? averageRating;
  final bool? isDeleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  PData({
    this.id,
    this.categoryId,
    this.name,
    this.subTitle,
    this.description,
    this.gender,
    this.generalPrice,
    this.additionalDetails,
    this.diamondDetails,
    this.sideDiamondDetails,
    this.shippingDetails,
    this.customShippingDetails,
    this.returnDetails,
    this.customReturnDetails,
    this.visualDetails,
    this.averageRating,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
  });

  factory PData.fromJson(Map<String, dynamic> json) => PData(
        id: json["_id"],
        categoryId: json["category_id"] == null ? null : CategoryId.fromJson(json["category_id"]),
        name: json["name"],
        subTitle: json["sub_title"],
        description: json["description"],
        gender: json["gender"],
        generalPrice: json["general_price"],
        additionalDetails:
            json["additional_details"] == null ? null : AdditionalDetails.fromJson(json["additional_details"]),
        diamondDetails: json["diamond_details"] == null ? null : DiamondDetails.fromJson(json["diamond_details"]),
        sideDiamondDetails:
            json["side_diamond_details"] == null ? null : DiamondDetails.fromJson(json["side_diamond_details"]),
        shippingDetails: json["shipping_details"],
        customShippingDetails: json["custom_shipping_details"],
        returnDetails: json["return_details"],
        customReturnDetails: json["custom_return_details"],
        visualDetails: json["visual_details"] == null
            ? []
            : List<VisualDetails>.from(json["visual_details"]!.map((x) => VisualDetails.fromJson(x))),
        averageRating: json["average_rating"],
        isDeleted: json["is_deleted"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "category_id": categoryId?.toJson(),
        "name": name,
        "sub_title": subTitle,
        "description": description,
        "gender": gender,
        "general_price": generalPrice,
        "additional_details": additionalDetails?.toJson(),
        "diamond_details": diamondDetails?.toJson(),
        "side_diamond_details": sideDiamondDetails?.toJson(),
        "shipping_details": shippingDetails,
        "custom_shipping_details": customShippingDetails,
        "return_details": returnDetails,
        "custom_return_details": customReturnDetails,
        "visual_details":
            visualDetails == null ? [] : List<Map<String, dynamic>>.from(visualDetails!.map((x) => x.toJson())),
        "average_rating": averageRating,
        "is_deleted": isDeleted,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}

class AdditionalDetails {
  final String? productSku;
  final String? style;
  final String? generalRhodiumPlated;
  final String? averageWidth;
  final String? caratTotalWeight;
  final String? backType;
  final num? earringLength;
  final num? earringWidth;
  final num? pendantLength;
  final num? pendantWidth;
  final num? chainLength;
  final num? chainWidth;
  final num? braceletLength;
  final num? braceletWidth;
  final String? chainType;
  final String? claspType;
  final String? id;

  AdditionalDetails({
    this.productSku,
    this.style,
    this.generalRhodiumPlated,
    this.averageWidth,
    this.caratTotalWeight,
    this.backType,
    this.earringLength,
    this.earringWidth,
    this.pendantLength,
    this.pendantWidth,
    this.chainLength,
    this.chainWidth,
    this.braceletLength,
    this.braceletWidth,
    this.chainType,
    this.claspType,
    this.id,
  });

  factory AdditionalDetails.fromJson(Map<String, dynamic> json) => AdditionalDetails(
        productSku: json["product_sku"],
        style: json["style"],
        generalRhodiumPlated: json["general_rhodium_plated"],
        averageWidth: json["average_width"],
        caratTotalWeight: json["carat_total_weight"],
        backType: json["back_type"],
        earringLength: json["earring_length"],
        earringWidth: json["earring_width"],
        pendantLength: json["pendant_length"],
        pendantWidth: json["pendant_width"],
        chainLength: json["chain_length"],
        chainWidth: json["chain_width"],
        braceletLength: json["bracelet_length"],
        braceletWidth: json["bracelet_width"],
        chainType: json["chain_type"],
        claspType: json["clasp_type"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "product_sku": productSku,
        "style": style,
        "general_rhodium_plated": generalRhodiumPlated,
        "average_width": averageWidth,
        "carat_total_weight": caratTotalWeight,
        "back_type": backType,
        "earring_length": earringLength,
        "earring_width": earringWidth,
        "pendant_length": pendantLength,
        "pendant_width": pendantWidth,
        "chain_length": chainLength,
        "chain_width": chainWidth,
        "bracelet_length": braceletLength,
        "bracelet_width": braceletWidth,
        "chain_type": chainType,
        "clasp_type": claspType,
        "_id": id,
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

class DiamondDetails {
  final String? stoneType;
  final String? creationMethod;
  final String? shape;
  final String? color;
  final String? colorHue;
  final String? clarity;
  final String? cutGrade;
  final num? count;
  final num? carateWeight;
  final num? totalCarateWeight;
  final String? setting;
  final String? polish;
  final String? symmetry;
  final String? depth;
  final String? table;
  final String? measurements;
  final String? id;

  DiamondDetails({
    this.stoneType,
    this.creationMethod,
    this.shape,
    this.color,
    this.colorHue,
    this.clarity,
    this.cutGrade,
    this.count,
    this.carateWeight,
    this.totalCarateWeight,
    this.setting,
    this.polish,
    this.symmetry,
    this.depth,
    this.table,
    this.measurements,
    this.id,
  });

  factory DiamondDetails.fromJson(Map<String, dynamic> json) => DiamondDetails(
        stoneType: json["stone_type"],
        creationMethod: json["creation_method"],
        shape: json["shape"],
        color: json["color"],
        colorHue: json["color_hue"],
        clarity: json["clarity"],
        cutGrade: json["cut_grade"],
        count: json["count"],
        carateWeight: json["carate_weight"],
        totalCarateWeight: json["total_carate_weight"],
        setting: json["setting"],
        polish: json["polish"],
        symmetry: json["symmetry"],
        depth: json["depth"],
        table: json["table"],
        measurements: json["measurements"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "stone_type": stoneType,
        "creation_method": creationMethod,
        "shape": shape,
        "color": color,
        "color_hue": colorHue,
        "clarity": clarity,
        "cut_grade": cutGrade,
        "count": count,
        "carate_weight": carateWeight,
        "total_carate_weight": totalCarateWeight,
        "setting": setting,
        "polish": polish,
        "symmetry": symmetry,
        "depth": depth,
        "table": table,
        "measurements": measurements,
        "_id": id,
      };
}

class VisualDetails {
  final String? metalTypeColor;
  final String? rhodiumPlated;
  final num? metalVisePrice;
  final List<String>? productImages;
  final String? productVideo;
  final String? id;

  VisualDetails({
    this.metalTypeColor,
    this.rhodiumPlated,
    this.metalVisePrice,
    this.productImages,
    this.productVideo,
    this.id,
  });

  factory VisualDetails.fromJson(Map<String, dynamic> json) => VisualDetails(
        metalTypeColor: json["metal_type_color"],
        rhodiumPlated: json["rhodium_plated"],
        metalVisePrice: json["metal_vise_price"],
        productImages: json["product_images"] == null ? [] : List<String>.from(json["product_images"]!.map((x) => x)),
        productVideo: json["product_video"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "metal_type_color": metalTypeColor,
        "rhodium_plated": rhodiumPlated,
        "metal_vise_price": metalVisePrice,
        "product_images": productImages == null ? [] : List<String>.from(productImages!.map((x) => x)),
        "product_video": productVideo,
        "_id": id,
      };
}
