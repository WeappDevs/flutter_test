import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:admin_web_app/providers/internet_provider.dart';
import 'package:admin_web_app/utils/consts.dart';
import 'package:admin_web_app/utils/route_management/route_names.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiProvider {
  static Future<dynamic> commonProvider({
    required String url,
    Object? bodyData,
    Map<String, String>? header,
    bool? isPrintResponse = true,
  }) async {
    // final hasInternet = await checkInternet();
    if (true == true) {
      try {
        final response = await http.post(Uri.parse(url), body: bodyData, headers: header);

        if (response.statusCode == 200) {
          if (isPrintResponse == true) {
            debugPrint("StatusCode: ${response.statusCode.toString()}");
            debugPrint("Body: ${response.body.toString()}");
          }

          dynamic data = json.decode(response.body);

          if (false /*data[Consts.statuscodeKey] == 0 && data[Consts.successKey] == false*/) {
            onTokenNotFound();
            return null;
          } else {
            return data;
          }
        } else if (response.statusCode == 101 || response.statusCode == 102) {
          return null;
        } else if (response.statusCode == 401) {
          // Block by the admin(Authentication failed).
          return null;
        } else if (response.statusCode == 404) {
          //for if there is no data found or something went wrong
          debugPrint("Body: ${response.body}");
          return null;
        } else {
          return json.decode(response.body);
        }
      } on SocketException catch (e) {
        debugPrint("Socket Exception: $e");
        return null;
      } on FormatException catch (e) {
        debugPrint("Format Exception: $e");
        throw Exception("Format Exception: $e");
      } catch (exception) {
        debugPrint("Exception: $exception");
        return null;
      }
    } else {
      //Something went wrong
      return null;
    }
  }

  static Future<dynamic> commonMultipartProvider({
    required String url,
    Map<String, String>? header,
    required Map<String, dynamic> body,
    required List<Uint8List> files,
    required String fieldName,
    bool? isPrintResponse = true,
  }) async {
    // final hasInternet = await checkInternet();

    if (true == true) {
      var request = http.MultipartRequest('POST', Uri.parse(url));

      if (header != null) {
        request.headers.addAll(header);
      }

      for (var file in files) {
        // var stream = http.ByteStream(file.openRead());
        // var length = await file.length();
        var multipartFile = http.MultipartFile.fromBytes(fieldName, file, filename: fieldName);
        request.files.add(multipartFile);
      }

      for (var key in body.keys) {
        if (body[key] != null) {
          request.fields[key] = body[key].toString();
        }
      }

      try {
        var response = await request.send();
        var responseData = await response.stream.transform(utf8.decoder).join();
        var respond = http.Response(responseData, response.statusCode);

        if (respond.statusCode == 200) {
          if (isPrintResponse == true) {
            debugPrint("StatusCode: ${respond.statusCode.toString()}");
            debugPrint("Body: ${respond.body.toString()}");
          }
          dynamic data = json.decode(respond.body);

          if (false /*data[Consts.statuscodeKey] == 0 && data[Consts.successKey] == false*/) {
            onTokenNotFound();
            return null;
          } else {
            return data;
          }
        } else if (respond.statusCode == 401) {
          // Block by the admin(Authentication failed).
          return null;
        } else if (respond.statusCode == 101 || respond.statusCode == 102) {
          return null;
        } else if (respond.statusCode == 404) {
          //for if there is no data found or something went wrong
          return null;
        } else {
          return json.decode(respond.body);
        }
      } catch (e) {
        if (e is SocketException) {
          debugPrint("Socket Exception: $e");
          throw Exception("Socket Exception: $e");
        } else if (e is http.ClientException) {
          throw Exception("Client Exception: $e");
        } else {
          throw Exception('Unknown error occurred: $e');
        }
      }
    } else {
      return null;
    }
  }

  static void onTokenNotFound() {
    debugPrint("onTokenNotFound -------------------->");
    Get.rootDelegate.offAndToNamed(RouteNames.kSignInScreenRoute);
  }
}
