import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomeApi {
  static String API_BASE_URL =
      "http://ec2-13-126-202-84.ap-south-1.compute.amazonaws.com/amusic/backend/web/index.php/api";

  static Future getBannerList() async {
    http.Response response = await http
        .get(Uri.parse("$API_BASE_URL/banner/list?page=1&number_per_page=10"));

    var parsed = jsonDecode(response.body);
    List banners = [];
    for (var i = 0; i < parsed['data'].length; i++) {
      banners.add(parsed['data'][i]);
    }
    return banners;
  }

  static Future getCategoryList() async {
    http.Response response = await http.get(Uri.parse(
        "$API_BASE_URL/category/list?number_per_page=10&page=1&is_video=0"));
    print("category ${response.statusCode} ${response.body}");
    return jsonDecode(response.body);
  }

  static Future getPlayListMusic() async {
    http.Response response = await http.get(Uri.parse(
        "$API_BASE_URL/playlist/list?number_per_page=10&page=1&is_new=1&is_hot=1&is_top=1"));
    print("Play List ${response.statusCode} ${response.body}");
    return jsonDecode(response.body);
  }

  static Future getListCategotyForNewSongs() async {
    http.Response response = await http.get(Uri.parse(
        "$API_BASE_URL/list-song/category?category_id=4&page=1&number_per_page=10"));
    print(
        "List Category songs for new songs ${response.statusCode} ${response.body}");
    return jsonDecode(response.body);
  }

  static Future getCategorySongs(categoryId) async {
    http.Response response = await http.get(Uri.parse(
        "$API_BASE_URL/list-song/category?category_id=$categoryId&page=1&number_per_page=10"));
    print(
        "List Category songs for new songs ${response.statusCode} ${response.body}");
    return jsonDecode(response.body);
  }

  static Future getPlaylistSongs(playlistId) async {
    http.Response response = await http.get(Uri.parse(
        "$API_BASE_URL/list-song/playlist?playlist_id=$playlistId&page=1&number_per_page=10"));
    print(
        "List Category songs for new songs ${response.statusCode} ${response.body}");
    return jsonDecode(response.body);
  }

}
