import 'dart:convert';
import 'package:amusic_app/models/video.dart';
import 'package:http/http.dart' as http;

import '../models/video_category.dart';
import 'constants.dart';

class VideosApi {
  static Future getVideosCategoryList() async {
    http.Response response = await http.get(Uri.parse(
        "$API_BASE_URL/category/list?number_per_page=10&page=1&is_video=1"));
    return jsonDecode(response.body);
  }

  static Future getCategoryVideos(categoryId) async {
    http.Response response = await http.get(Uri.parse(
        "$API_BASE_URL/video/category?category_id=$categoryId&page=1&number_per_page=10"));
    var decodedData = jsonDecode(response.body);
    return constructVideosList(jsonDecode(response.body)['data']);
  }

  static Future getVideos() async {
    http.Response response = await http.get(Uri.parse(
        "$API_BASE_URL/video/title-view-more?page=1&number_per_page=10&video_title_id=4"));
    return jsonDecode(response.body);
  }

  static Future videosHomeData() async {
    http.Response response =
        await http.get(Uri.parse("$API_BASE_URL/home/video-statistics"));
    var decodedData = jsonDecode(response.body);
    var videosHomeData = {
      "video_categories": constructVideoCatgoriesList(
         decodedData['data']['video_categories']),
      "darshan_videos": {
        "id": decodedData['data']['video_playlist_title'][0]['id'],
        "title": decodedData['data']['video_playlist_title'][0]['title'],
        "list": constructVideosList(
            decodedData['data']['video_playlist_title'][0]['list_videos'])
      },
      "dance_videos": {
        "id": decodedData['data']['video_playlist_title'][1]['id'],
        "title": decodedData['data']['video_playlist_title'][1]['title'],
        "list": constructVideosList(
            decodedData['data']['video_playlist_title'][1]['list_videos'])
      },
      "videos": constructVideosList(decodedData['data']['videos'])
    };

    return videosHomeData;
  }

  static Future getVideoPlaylist(playlistId) async {
    http.Response response = await http.get(Uri.parse(
        "$API_BASE_URL/video/title-view-more?video_title_id=$playlistId&page=1&number_per_page=10"));

    return constructVideosList(jsonDecode(response.body)['data']);
  }

  static List<Video> constructVideosList(responseData) {
    List<Video> videosList = [];
    for (var i = 0; i < responseData.length; i++) {
      Video video = Video(
          id: responseData[i]['id'],
          name: responseData[i]['name'],
          image: responseData[i]['image'],
          video: responseData[i]['video'],
          description: responseData[i]['description'],
          isFree: responseData[i]['is_free'] == 0 ? false : true);
      videosList.add(video);
    }
    return videosList;
  }

  static List<VideoCategory> constructVideoCatgoriesList(responseData) {
    List<VideoCategory> videosCategoryList = [];
    for (var i = 0; i < responseData.length; i++) {
      VideoCategory videoCategory = VideoCategory(
          id: responseData[i]['id'],
          name: responseData[i]['name'],
          imgThumb: responseData[i]['img_thumb'],
          imgBanner: responseData[i]['img_banner']);
      videosCategoryList.add(videoCategory);
    }
    return videosCategoryList;
  }
}
