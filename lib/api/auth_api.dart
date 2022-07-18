import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../functions/general_functions.dart';
import 'constants.dart';

class AuthApi {
  static Future getUserToken() async {
    final prefs = await SharedPreferences.getInstance();
    final String? token =
        json.decode(prefs.getString('jhankar_token').toString()).token;
    return token;
  }

  static Future getUserProfile(String token, int userId) async {
    getStoragePermission();
    http.Response response = await http.get(
        Uri.parse("$API_BASE_URL/user/profile?user_id=$userId&token=$token"));
    return jsonDecode(response.body)['data'];
  }

  static Future logOut(token) async {
    http.Response response =
        await http.get(Uri.parse("$API_BASE_URL/user/logout?token=$token"));
    var responseData = jsonDecode(response.body);
    //if (responseData['status'] == 'SUCCESS') {
      final prefs = await SharedPreferences.getInstance();
      prefs.remove('jhankar_token');
    // }
  }

  static Future forgetPassword(email, context) async {
    try {
      http.Response response = await http
          .get(Uri.parse("$API_BASE_URL/user/forget-password?email=$email"));
      var responseData = jsonDecode(response.body);
      if (responseData['status'] == 'SUCCESS') {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Email Sent')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Error try after sometime')));
      }
    } catch (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.toString())));
    }
  }

  static Future registerDevice(token, gcmId, type) async {
    http.Response response = await http.get(Uri.parse(
        "$API_BASE_URL/device/index?token=$token&gcm_id=$gcmId&type=$type"));
  }
}
