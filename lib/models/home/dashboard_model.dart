// To parse this JSON data, do
//
//     final dashboardModel = dashboardModelFromJson(jsonString);

import 'dart:convert';

DashboardModel dashboardModelFromJson(String str) => DashboardModel.fromJson(json.decode(str));

String dashboardModelToJson(DashboardModel data) => json.encode(data.toJson());

class DashboardModel {
  final bool? success;
  final int? statuscode;
  final String? message;
  final DData? data;

  DashboardModel({
    this.success,
    this.statuscode,
    this.message,
    this.data,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) => DashboardModel(
        success: json["success"],
        statuscode: json["statuscode"],
        message: json["message"],
        data: json["data"] == null ? null : DData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "statuscode": statuscode,
        "message": message,
        "data": data?.toJson(),
      };
}

class DData {
  final num? totalProducts;
  final num? totalSells;
  final num? totalReturns;
  final num? totalPayment;

  DData({
    this.totalProducts,
    this.totalSells,
    this.totalReturns,
    this.totalPayment,
  });

  factory DData.fromJson(Map<String, dynamic> json) => DData(
        totalProducts: json["total_products"],
        totalSells: json["total_sells"],
        totalReturns: json["total_returns"],
        totalPayment: json["total_payment"],
      );

  Map<String, dynamic> toJson() => {
        "total_products": totalProducts,
        "total_sells": totalSells,
        "total_returns": totalReturns,
        "total_payment": totalPayment,
      };
}
