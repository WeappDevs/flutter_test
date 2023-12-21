import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

//for the api internet checking
Future<bool?> checkInternet() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      debugPrint('connected');
      return true;
    } else {
      debugPrint('else of connected');
    }
  } on SocketException catch (e) {
    debugPrint('not connected: $e');
    return false;
  }
  return null;
}
