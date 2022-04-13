import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/song.dart';

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

  static Future<List<Song>> getListCategotyForNewSongs() async {
    http.Response response = await http.get(Uri.parse(
        "$API_BASE_URL/list-song/category?category_id=4&page=1&number_per_page=10"));

    return constructSongsList(jsonDecode(response.body)['data']);
  }

  static Future getCategorySongs(categoryId) async {
    http.Response response = await http.get(Uri.parse(
        "$API_BASE_URL/list-song/category?category_id=$categoryId&page=1&number_per_page=10"));
    print(
        "List Category songs for new songs ${response.statusCode} ${response.body}");
    return constructSongsList(jsonDecode(response.body)['data']);
  }

  static Future getPlaylistSongs(playlistId) async {
    http.Response response = await http.get(Uri.parse(
        "$API_BASE_URL/list-song/playlist?playlist_id=$playlistId&page=1&number_per_page=10"));

    return constructSongsList(jsonDecode(response.body)['data']);
  }

  static Future<List<Song>> searchSongsByKeyword(String keyword) async {
    http.Response response = await http.get(Uri.parse(
        "$API_BASE_URL/list/song?page=1&number_per_page=10&keyword=$keyword"));

    return constructSongsList(jsonDecode(response.body)['data']);
  }

  static Future<List<Song>> searchAll(String keyword) async {
    http.Response response =
        await http.get(Uri.parse("$API_BASE_URL/search/index?query=$keyword"));

    return constructSongsList(jsonDecode(response.body)['data']['songs']);
  }

  static List<Song> constructSongsList(responseData) {
    List<Song> songsList = [];
    for (var i = 0; i < responseData.length; i++) {
      List<MusicArtist> musicArtistList = [];
      if (responseData[i]['musicArtists'].length > 0) {
        MusicArtist musicArtist = MusicArtist(
            id: responseData[i]['musicArtists'][0]['id'],
            name: responseData[i]['musicArtists'][0]['name'],
            imgBanner: responseData[i]['musicArtists'][0]
                ['img_banner']);

        musicArtistList.add(musicArtist);
      }

      Song song = Song(
          id: responseData[i]['id'],
          name: responseData[i]['name'],
          imgBanner: responseData[i]['img_banner'],
          songFile: responseData[i]['song_file'],
          musicArtists: musicArtistList);
      songsList.add(song);
    }
    return songsList;
  }
}
