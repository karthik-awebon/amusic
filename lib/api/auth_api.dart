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

  static Future getUserProfile() async {
    final userToken = AuthApi.getUserToken();
    http.Response response = await http.get(Uri.parse(
        "$API_BASE_URL/video/title-view-more?page=1&number_per_page=10&video_title_id=4"));
    return jsonDecode(response.body);
  }

  static Future LogOut() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = json.decode(prefs.getString('jhankar_token').toString());

    http.Response response = await http
        .get(Uri.parse("$API_BASE_URL/user/logout?token=${userData['token']}"));
    prefs.clear();
    return response.statusCode;
  }
}
