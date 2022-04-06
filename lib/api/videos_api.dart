import 'dart:convert';
import 'package:http/http.dart' as http;

class VideosApi {
  static String API_BASE_URL =
      "http://ec2-13-126-202-84.ap-south-1.compute.amazonaws.com/amusic/backend/web/index.php/api";

  static Future getVideosCategoryList() async {
    http.Response response = await http.get(Uri.parse(
        "$API_BASE_URL/category/list?number_per_page=10&page=1&is_video=1"));
    return jsonDecode(response.body);
  }

  static Future getCategoryVideos(categoryId) async {
    http.Response response = await http.get(Uri.parse(
        "$API_BASE_URL/video/category?category_id=$categoryId&page=1&number_per_page=10"));
    return jsonDecode(response.body);
  }

  static Future getVideos() async {
    http.Response response = await http.get(Uri.parse(
        "$API_BASE_URL/video/title-view-more?page=1&number_per_page=10&video_title_id=4"));
    return jsonDecode(response.body);
  }
}
