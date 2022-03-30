import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthApi {
  String API_BASE_URL =
      "http://ec2-13-126-202-84.ap-south-1.compute.amazonaws.com/amusic/backend/web/index.php/api";

  static Future getUserToken() async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('jhankar_token');
    return token;
  }
}
