import 'dart:convert';

import 'package:amusic_app/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/http_exception.dart';

class Auth with ChangeNotifier {
  String? _token;
  String? _userId;

  bool get isAuth {
    return token != null;
  }

  String? get token {
    if (_token != null) {
      return _token;
    }
    return null;
  }

  String? get userId {
    if (_userId != null) {
      return _userId;
    }
    return null;
  }

  Future<void> socialLogin(String email, String name) async {
    var endpointUrl =
        'http://ec2-13-126-202-84.ap-south-1.compute.amazonaws.com/amusic/backend/web/index.php/api/user/login';

    try {
      Map<String, String> queryParams = {
        'username': email,
        'login_type': 's',
        'name': name
      };
      String queryString = Uri(queryParameters: queryParams).query;

      var requestUrl = endpointUrl + '?' + queryString;
      var response = await http.get(Uri.parse(requestUrl));
      var responseData = json.decode(response.body.toString());

      if (responseData['status'] == "SUCCESS") {
        final prefs = await SharedPreferences.getInstance();
        prefs.setString(
            'jhankar_token',
            json.encode({
              'user_id': responseData['data']['id'],
              'token': responseData['data']['token']
            }));
        _token = responseData['data']['token'];
        notifyListeners();
      } else {
        throw HttpException(responseData['message']);
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> login(String email, String password) async {
    var endpointUrl =
        'http://ec2-13-126-202-84.ap-south-1.compute.amazonaws.com/amusic/backend/web/index.php/api/user/login';

    try {
      Map<String, String> queryParams = {
        'username': email,
        'login_type': 'n',
        'password': password
      };
      String queryString = Uri(queryParameters: queryParams).query;

      var requestUrl = endpointUrl + '?' + queryString;
      var response = await http.get(Uri.parse(requestUrl));
      var responseData = json.decode(response.body.toString());

      if (responseData['status'] == "SUCCESS") {
        final prefs = await SharedPreferences.getInstance();
        prefs.setString(
            'jhankar_token',
            json.encode({
              'user_id': responseData['data']['id'],
              'token': responseData['data']['token']
            }));
        _token = responseData['data']['token'];
        notifyListeners();
      } else {
        throw HttpException(responseData['message']);
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> signup(String email, String password, String name) async {
    var endpointUrl =
        'http://ec2-13-126-202-84.ap-south-1.compute.amazonaws.com/amusic/backend/web/index.php/api/user/register';

    try {
      Map<String, String> queryParams = {
        'username': email,
        'password': password,
        'name': name,
      };
      String queryString = Uri(queryParameters: queryParams).query;

      var requestUrl = endpointUrl + '?' + queryString;
      var response = await http.get(Uri.parse(requestUrl));
      var responseData = json.decode(response.body.toString());

      if (responseData['status'] == "SUCCESS") {
        this.login(email, password);
      } else {
        throw HttpException(responseData['message']);
      }
    } catch (error) {
      throw error;
    }
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('jhankar_token')) {
      return false;
    }

    final userData = json.decode(prefs.getString('jhankar_token').toString());
    _token = userData['token'];
    notifyListeners();
    return true;
  }
}
