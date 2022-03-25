import 'dart:convert';

import 'package:http/http.dart' as http;

class HomeApi {
  String API_BASE_URL =
      "http://ec2-13-126-202-84.ap-south-1.compute.amazonaws.com/amusic/backend/web/index.php/api";

  Future getBannerList() async {
    http.Response response = await http.get(Uri.parse(
        "$API_BASE_URL/banner/list?page=1&number_per_page=10"));

    print("${response.statusCode} ${response.body}");
    var parsed = jsonDecode(response.body);
    List<String> banner = [];
    for (var i = 0; i < parsed['data'].length; i++) {
      banner.add(parsed['data'][i]['image']);
    }
    print("${banner}");
    return banner;
  }

  Future getCategoryList() async {
    http.Response response = await http.get(Uri.parse(
        "$API_BASE_URL/category/list?number_per_page=10&page=1&is_video=0"));
    print("category ${response.statusCode} ${response.body}");
    return jsonDecode(response.body);
  }

  Future getPlayListMusic() async {
    http.Response response = await http.get(Uri.parse(
        "$API_BASE_URL/playlist/list?number_per_page=10&page=1&is_new=1&is_hot=1&is_top=1"));
    print("Play List ${response.statusCode} ${response.body}");
    return jsonDecode(response.body);
  }

  Future getListCategotyForNewSongs() async {
    http.Response response = await http.get(Uri.parse(
        "$API_BASE_URL/list-song/category?category_id=4&page=1&number_per_page=10"));
    print(
        "List Category songs for new songs ${response.statusCode} ${response.body}");
    return jsonDecode(response.body);
  }

  Future LogOut(token) async {
    http.Response response = await http.get(Uri.parse(
        "$API_BASE_URL/user/logout?token=$token"));
    print("Logout ${response.statusCode} ${response.body}");
    return response.statusCode;
  }
}
