import 'package:admin_web_app/controllers/index_controller.dart';
import 'package:admin_web_app/models/product/product_detail_model.dart';
import 'package:admin_web_app/utils/assets.dart';
import 'package:admin_web_app/utils/colors.dart';
import 'package:admin_web_app/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'dart:convert';

import 'package:loading_animation_widget/loading_animation_widget.dart';

DummyProductModel dummyProductModelFromJson(String str) => DummyProductModel.fromJson(json.decode(str));

String dummyProductModelToJson(DummyProductModel data) => json.encode(data.toJson());

class DummyProductModel {
  final bool? success;
  final int? statuscode;
  final String? message;
  final Data? data;

  DummyProductModel({
    this.success,
    this.statuscode,
    this.message,
    this.data,
  });

  factory DummyProductModel.fromJson(Map<String, dynamic> json) => DummyProductModel(
        success: json["success"],
        statuscode: json["statuscode"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "statuscode": statuscode,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  final String? categoryId;
  final String? name;
  final String? subTitle;
  final String? description;
  final String? gender;
  final int? generalPrice;
  AdditionalDetails? additionalDetails = AdditionalDetails();
  DiamondDetails? diamondDetails = DiamondDetails();
  DiamondDetails? sideDiamondDetails = DiamondDetails();
  final String? shippingDetails;
  final String? returnDetails;
  final List<dynamic>? visualDetails;
  final int? averageRating;
  final bool? isDeleted;
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Data({
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
    this.returnDetails,
    this.visualDetails,
    this.averageRating,
    this.isDeleted,
    this.id,
    this.createdAt,
    this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        categoryId: json["category_id"],
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
        returnDetails: json["return_details"],
        visualDetails: json["visual_details"] == null ? [] : List<dynamic>.from(json["visual_details"]!.map((x) => x)),
        averageRating: json["average_rating"],
        isDeleted: json["is_deleted"],
        id: json["_id"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "category_id": categoryId,
        "name": name,
        "sub_title": subTitle,
        "description": description,
        "gender": gender,
        "general_price": generalPrice,
        "additional_details": additionalDetails?.toJson(),
        "diamond_details": diamondDetails?.toJson(),
        "side_diamond_details": sideDiamondDetails?.toJson(),
        "shipping_details": shippingDetails,
        "return_details": returnDetails,
        "visual_details": visualDetails == null ? [] : List<dynamic>.from(visualDetails!.map((x) => x)),
        "average_rating": averageRating,
        "is_deleted": isDeleted,
        "_id": id,
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
  final int? earringLength;
  final int? earringWidth;
  final int? pendantLength;
  final int? pendantWidth;
  final int? chainLength;
  final int? chainWidth;
  final int? braceletLength;
  final int? braceletWidth;
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

class DiamondDetails {
  final String? stoneType;
  final String? creationMethod;
  final String? shape;
  final String? color;
  final String? colorHue;
  final String? clarity;
  final String? cutGrade;
  final int? count;
  final int? carateWeight;
  final int? totalCarateWeight;
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

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    IndexController controller = Get.find<IndexController>();
    Data dummyProductModel = Data();
    AdditionalDetails additionalDetails = AdditionalDetails();
    DiamondDetails diamondDetails = DiamondDetails();
    DiamondDetails sideDiamondDetails = DiamondDetails();

    return SelectionArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: controller.onProductDetailBackBtnTapped,
                  icon: const Icon(Icons.chevron_left),
                  splashRadius: 20,
                ),
                const SizedBox(width: 10),
                Text(
                  "Product Details",
                  style: CustomTextStyle.screenHeadingStyle,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              height: .8,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Clr.greyColor,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 30),
            Obx(() {
              return (controller.productDetailModel.value != null &&
                      controller.productDetailModel.value?.data?.value != null)
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Visual Details",
                              style: CustomTextStyle.infoHeadingStyle,
                            ),
                            const SizedBox(height: 10),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      height: 70,
                                      width: 70,
                                      color: Clr.decentGreyColor,
                                    ),
                                    const SizedBox(height: 10),
                                    Container(
                                      height: 70,
                                      width: 70,
                                      color: Clr.decentGreyColor,
                                    ),
                                    const SizedBox(height: 10),
                                    Container(
                                      height: 70,
                                      width: 70,
                                      color: Clr.decentGreyColor,
                                    ),
                                    const SizedBox(height: 10),
                                    Container(
                                      height: 70,
                                      width: 70,
                                      color: Clr.decentGreyColor,
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 20),
                                Container(
                                  height: 500,
                                  width: 500,
                                  color: Clr.decentGreyColor,
                                ),
                                const SizedBox(width: 30),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Clr.whiteColor,
                                    ),
                                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Media Inner Details",
                                          style: CustomTextStyle.infoHeadingStyle,
                                        ),
                                        const SizedBox(height: 10),
                                        Center(
                                          child: Column(
                                            children: [
                                              const SizedBox(height: 10),
                                              SvgPicture.asset(LocalSVG.noDataIcon),
                                              const SizedBox(height: 10),
                                              Text(
                                                "No Media Inner Details Available.",
                                                style: CustomTextStyle.mediumGreyStyle,
                                              ),
                                              const SizedBox(height: 10),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 30),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Clr.whiteColor,
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Basic Details",
                                style: CustomTextStyle.infoHeadingStyle,
                              ),
                              const SizedBox(height: 10),
                              buildNestedRows(
                                  controller.productDetailModel.value?.data?.value?.toJson() ?? <String, dynamic>{})
                              /*Column(
                                children: controller.productDetailModel.value?.data?.value
                                        ?.toJson()
                                        .entries
                                        .map((element) {
                                      return (element.value.runtimeType == String ||
                                              element.value.runtimeType == num ||
                                              element.value.runtimeType == int ||
                                              element.value.runtimeType == bool)
                                          ? Padding(
                                              padding: const EdgeInsets.only(top: 5),
                                              child: SizedBox(
                                                width: double.infinity,
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                        flex: 3,
                                                        child: Text(
                                                            element.key
                                                                .replaceAll("_", " ")
                                                                .toString()
                                                                .trimLeft()
                                                                .capitalize
                                                                .toString(),
                                                            style: const TextStyle(color: Clr.greyColor))),
                                                    const SizedBox(width: 10),
                                                    Expanded(flex: 9, child: Text(element.value?.toString() ?? "-")),
                                                    // Expanded(flex: 3, child: Text(element.value?.runtimeType.toString() ?? "-")),
                                                  ],
                                                ),
                                              ),
                                            )
                                          : const SizedBox();
                                    }).toList() ??
                                    <Widget>[],
                              ),*/
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Clr.whiteColor,
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Additional Details",
                                style: CustomTextStyle.infoHeadingStyle,
                              ),
                              const SizedBox(height: 10),
                              Column(
                                children: controller.productDetailModel.value?.data?.value?.additionalDetails
                                        ?.toJson()
                                        .entries
                                        .map((element) {
                                      return Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                  flex: 3,
                                                  child: Text(
                                                      element.key
                                                          .replaceAll("_", " ")
                                                          .toString()
                                                          .trimLeft()
                                                          .capitalize
                                                          .toString(),
                                                      style: const TextStyle(color: Clr.greyColor))),
                                              const SizedBox(width: 10),
                                              Expanded(flex: 9, child: Text(element.value?.toString() ?? "-")),
                                            ],
                                          ),
                                        ),
                                      );
                                    }).toList() ??
                                    <Widget>[],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Clr.whiteColor,
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Diamond Details",
                                      style: CustomTextStyle.infoHeadingStyle,
                                    ),
                                    const SizedBox(height: 10),
                                    Column(
                                      children: controller.productDetailModel.value?.data?.value?.diamondDetails
                                              ?.toJson()
                                              .entries
                                              .map((element) {
                                            return Padding(
                                              padding: const EdgeInsets.only(top: 5),
                                              child: SizedBox(
                                                width: double.infinity,
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                        flex: 2,
                                                        child: Text(
                                                            element.key
                                                                .replaceAll("_", " ")
                                                                .toString()
                                                                .trimLeft()
                                                                .capitalize
                                                                .toString(),
                                                            style: const TextStyle(color: Clr.greyColor))),
                                                    const SizedBox(width: 10),
                                                    Expanded(flex: 4, child: Text(element.value?.toString() ?? "-")),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }).toList() ??
                                          <Widget>[],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 30),
                            Expanded(
                              flex: 1,
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Clr.whiteColor,
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Side Diamond Details",
                                      style: CustomTextStyle.infoHeadingStyle,
                                    ),
                                    const SizedBox(height: 10),
                                    Column(
                                      children: controller.productDetailModel.value?.data?.value?.sideDiamondDetails
                                              ?.toJson()
                                              .entries
                                              .map((element) {
                                            return Padding(
                                              padding: const EdgeInsets.only(top: 5),
                                              child: SizedBox(
                                                width: double.infinity,
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                        flex: 2,
                                                        child: Text(
                                                            element.key
                                                                .replaceAll("_", " ")
                                                                .toString()
                                                                .trimLeft()
                                                                .capitalize
                                                                .toString(),
                                                            style: const TextStyle(color: Clr.greyColor))),
                                                    const SizedBox(width: 10),
                                                    Expanded(flex: 4, child: Text(element.value?.toString() ?? "-")),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }).toList() ??
                                          <Widget>[],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                      ],
                    )
                  : Center(
                      child: LoadingAnimationWidget.fallingDot(color: Clr.whiteColor, size: 32),
                    );
            })
          ],
        ),
      ),
    );
  }

  Widget buildNestedRows(Map<String, dynamic> data) {
    return Column(
      children: data.entries.expand((element) {
        return (element.value is Map)
            ? [
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: SizedBox(
                    width: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(
                            element.key.replaceAll("_", " ").toString().trimLeft().capitalize.toString(),
                            style: const TextStyle(color: Clr.greyColor),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          flex: 9,
                          child: buildNestedRows(element.value),
                        ),
                      ],
                    ),
                  ),
                ),
              ]
            : [
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: SizedBox(
                    width: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(
                            element.key.replaceAll("_", " ").toString().trimLeft().capitalize.toString(),
                            style: const TextStyle(color: Clr.greyColor),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          flex: 9,
                          child: Text(element.value?.toString() ?? "-"),
                        ),
                      ],
                    ),
                  ),
                )
              ];
      }).toList(),
    );
  }
}
