// To parse this JSON data, do
//
//     final rememberMeModel = rememberMeModelFromJson(jsonString);

import 'dart:convert';

RememberMeModel rememberMeModelFromJson(String str) => RememberMeModel.fromJson(json.decode(str));

String rememberMeModelToJson(RememberMeModel data) => json.encode(data.toJson());

class RememberMeModel {
  final String? email;
  final String? pass;

  RememberMeModel({
    this.email,
    this.pass,
  });

  factory RememberMeModel.fromJson(Map<String, dynamic> json) => RememberMeModel(
        email: json["email"],
        pass: json["pass"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "pass": pass,
      };
}
