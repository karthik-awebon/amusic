import 'dart:async';
import 'dart:convert';

import 'package:amusic_app/api/general_api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/http_exception.dart';
import '../models/song.dart';
import '../screens/home.dart';
import '../widgets/audio_player_widget.dart';

class Auth with ChangeNotifier {
  String? _token;
  int? _userId;
  Song? _song;
  List<Song> _songsList = [];
  bool _isPushNotificationOn = false;
  List<Song> _favoriteSongsList = [];
  AudioPlayerWidget _audioPlayerWidget = AudioPlayerWidget();

  AudioPlayerWidget get audioPlayerWidget {
    return _audioPlayerWidget;
  }

  bool get isAuth {
    return token != null;
  }

  bool get isPushNotificationOn {
    return _isPushNotificationOn;
  }

  String? get token {
    if (_token != null) {
      return _token;
    }
    return null;
  }

  int? get userId {
    if (_userId != null) {
      return _userId;
    }
    return null;
  }

  Song? get song {
    if (_song != null) {
      return _song;
    }
    return null;
  }

  List<Song> get favoriteSongsList {
    return _favoriteSongsList;
  }

  List<Song> get songsList {
    return _songsList;
  }

  void setSong(Song song) {
    _song = song;
    notifyListeners();
  }

  void setSongsList(List<Song> songsList) {
    _songsList = songsList;
    notifyListeners();
  }

  void setFavoriteSongsList(List<Song> favoriteSongsList) {
    _favoriteSongsList = favoriteSongsList;
    notifyListeners();
  }

  void setIsPushNotificationOn(bool isPushNotificationOn) {
    _isPushNotificationOn = isPushNotificationOn;
    notifyListeners();
  }

  void disposeAudioPlayer() {
    _audioPlayerWidget.dispose();
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
        _userId = responseData['data']['id'];
        notifyListeners();
      } else {
        throw HttpException(responseData['message']);
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> login(
      String email, String password, bool rememberme, context) async {
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
        if (rememberme) {
          prefs.setString(
              'jhankar_token',
              json.encode({
                'user_id': responseData['data']['id'],
                'token': responseData['data']['token']
              }));
        } else {
          prefs.remove('jhankar_token');
        }
        _token = responseData['data']['token'];
        _userId = responseData['data']['id'];
        if (prefs.containsKey('jhankar_push_notification_button')) {
          _isPushNotificationOn =
              (prefs.getBool('jhankar_push_notification_button') == true)
                  ? true
                  : false;
        }
        if (prefs.containsKey('favorite_songs')) {
          _favoriteSongsList = await GeneralApi.getFavoriteSongs();
        }

        notifyListeners();
        Navigator.of(context).pushNamed(Home.routeName);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(responseData['message'])));
      }
    } catch (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.toString())));
    }
  }

  Future<void> signup(
      String email, String password, String name, context) async {
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
        this.login(email, password, true, context);
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
    _userId = userData['user_id'];
    notifyListeners();

    if (prefs.containsKey('jhankar_push_notification_button')) {
      _isPushNotificationOn =
          (prefs.getBool('jhankar_push_notification_button') == true)
              ? true
              : false;
    }
    if (prefs.containsKey('favorite_songs')) {
      _favoriteSongsList = await GeneralApi.getFavoriteSongs();
    }
   
    return true;
  }
}
