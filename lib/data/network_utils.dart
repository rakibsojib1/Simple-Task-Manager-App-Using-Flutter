import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/data/authUtils.dart';
import 'package:task_manager/main.dart';
import 'package:task_manager/ui/screens/login_screen.dart';

class NetworkUtils {
  //Get Request
  static Future<dynamic> getMethod(String url,
      {VoidCallback? onUnAuthorize}) async {
    try {
      final http.Response response = await http.get(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          'token': AuthUtils.token ?? ''
        },
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 401) {
        if (onUnAuthorize != null) {
          onUnAuthorize();
        } else {
          moveToLogin();
        }
      } else {
        log("Something went wrog ${response.statusCode}");
      }
    } catch (e) {
      log("Error $e");
    }
  }

//Post Request

  static Future<dynamic> postMethod(
    String url, {
    Map<String, String>? body,
    VoidCallback? onUnAuthorize,
  }) async {
    try {
      final http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          'token': AuthUtils.token ?? ''
        },
        body: jsonEncode(body),
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 401) {
        if (onUnAuthorize != null) {
          onUnAuthorize();
        } else {
          moveToLogin();
        }
      } else {
        log("Something went wrog");
      }
    } catch (e) {
      log("Error $e");
    }
  }

  static Future<bool> checkUserLoggedIn(String password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final storedPassword = prefs.getString('password');
    return password == storedPassword;
  }
}

void moveToLogin() async {
  await AuthUtils.clearData();
  Navigator.pushAndRemoveUntil(
      TaskManagerApp.globalKey.currentContext!,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (route) => false);
}
