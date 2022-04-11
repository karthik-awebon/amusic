import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthApi {
  static String API_BASE_URL =
      "http://ec2-13-126-202-84.ap-south-1.compute.amazonaws.com/amusic/backend/web/index.php/api";

  static Future getUserToken() async {
    final prefs = await SharedPreferences.getInstance();
    final String? token =
        json.decode(prefs.getString('jhankar_token').toString()).token;
    return token;
  }

  static Future getUserProfile(String token, int userId) async {
    http.Response response = await http.get(Uri.parse(
        "$API_BASE_URL/user/profile?user_id=$userId&token=$token"));
    return jsonDecode(response.body)['data'];
  }

  static Future LogOut(token) async {
    http.Response response =
        await http.get(Uri.parse("$API_BASE_URL/user/logout?token=$token"));
    var responseData = jsonDecode(response.body);
    if (responseData['status'] == 'SUCCESS') {
      final prefs = await SharedPreferences.getInstance();
      prefs.clear();
    }
  }
}
