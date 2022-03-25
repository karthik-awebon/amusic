import 'dart:convert';

import 'package:http/http.dart' as http;

class AudioPlayerApi {
  Future getBannerList() async {
    http.Response response = await http.get(Uri.parse(
        "http://ec2-13-126-202-84.ap-south-1.compute.amazonaws.com/amusic/backend/web/index.php/api/banner/list?page=1&number_per_page=10"));

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
        "http://ec2-13-126-202-84.ap-south-1.compute.amazonaws.com/amusic/backend/web/index.php/api/category/list?number_per_page=10&page=1&is_video=0"));
    print("category ${response.statusCode} ${response.body}");
    return jsonDecode(response.body);
  }

  Future getPlayListMusic() async {
    http.Response response = await http.get(Uri.parse(
        "http://ec2-13-126-202-84.ap-south-1.compute.amazonaws.com/amusic/backend/web/index.php/api/playlist/list?number_per_page=10&page=1&is_new=1&is_hot=1&is_top=1"));
    print("Play List ${response.statusCode} ${response.body}");
    return jsonDecode(response.body);
  }

  Future getListCategotyForNewSongs() async {
    http.Response response = await http.get(Uri.parse(
        "http://ec2-13-126-202-84.ap-south-1.compute.amazonaws.com/amusic/backend/web/index.php/api/list-song/category?category_id=4&page=1&number_per_page=10"));
    print(
        "List Category songs for new songs ${response.statusCode} ${response.body}");
    return jsonDecode(response.body);
  }

  Future LogOut(token) async {
    

    http.Response response = await http.get(Uri.parse(
        "http://ec2-13-126-202-84.ap-south-1.compute.amazonaws.com/amusic/backend/web/index.php/api/user/logout?token=$token"));
    print("Logout ${response.statusCode} ${response.body}");
    return response.statusCode;
  }
}
