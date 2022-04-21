import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

class AuthApi {
  
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
      prefs.remove('jhankar_token');
    }
  }
}
