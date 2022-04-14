import 'dart:convert';

import 'package:amusic_app/models/playlist.dart';
import 'package:http/http.dart' as http;

import '../models/banner.dart';
import '../models/category.dart';
import '../models/song.dart';
import '../models/video.dart';

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

  static Future homeData() async {
    http.Response response =
        await http.get(Uri.parse("$API_BASE_URL/home/statistics"));
    var homeData = {
      "banners":
          constructBannersList(jsonDecode(response.body)['data']['banner']),
      "categories": constructCatgoriesList(
          jsonDecode(response.body)['data']['categories']),
      "new_albums": constructPlaylistsList(jsonDecode(response.body)['data']
          ['playlist_title'][0]['list_playlist']),
      "hot_albums": constructPlaylistsList(jsonDecode(response.body)['data']
          ['playlist_title'][1]['list_playlist']),
      "top_albums": constructPlaylistsList(jsonDecode(response.body)['data']
          ['playlist_title'][2]['list_playlist']),
      "bindashi_albums": constructPlaylistsList(
          jsonDecode(response.body)['data']['playlist_title'][3]
              ['list_playlist']),
      "new_songs":
          constructSongsList(jsonDecode(response.body)['data']['songs'])
    };

    return homeData;
  }

  static Future searchAll(String keyword) async {
    http.Response response =
        await http.get(Uri.parse("$API_BASE_URL/search/index?query=$keyword"));
    var searchResult = {
      "songs": constructSongsList(jsonDecode(response.body)['data']['songs']),
      "playlists": constructPlaylistsList(
          jsonDecode(response.body)['data']['playlists']),
      "videos": constructVideosList(jsonDecode(response.body)['data']['videos'])
    };

    return searchResult;
  }

  static List<Song> constructSongsList(responseData) {
    List<Song> songsList = [];
    for (var i = 0; i < responseData.length; i++) {
      List<MusicArtist> musicArtistList = [];
      if (responseData[i]['musicArtists'].length > 0) {
        MusicArtist musicArtist = MusicArtist(
            id: responseData[i]['musicArtists'][0]['id'],
            name: responseData[i]['musicArtists'][0]['name'],
            imgBanner: responseData[i]['musicArtists'][0]['img_banner']);

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

  static List<Playlist> constructPlaylistsList(responseData) {
    List<Playlist> playlistsList = [];
    for (var i = 0; i < responseData.length; i++) {
      Playlist playlist = Playlist(
          id: responseData[i]['id'],
          name: responseData[i]['name'],
          imgThumb: responseData[i]['img_thumb'],
          songsCount: responseData[i]['songs_count']);
      playlistsList.add(playlist);
    }
    return playlistsList;
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

  static List<Category> constructCatgoriesList(responseData) {
    List<Category> categoriesList = [];
    for (var i = 0; i < responseData.length; i++) {
      Category category = Category(
          id: responseData[i]['id'],
          name: responseData[i]['name'],
          imgThumb: responseData[i]['img_thumb'],
          imgBanner: responseData[i]['img_banner']);
      categoriesList.add(category);
    }
    return categoriesList;
  }

  static List<Banner> constructBannersList(responseData) {
    List<Banner> bannersList = [];
    for (var i = 0; i < responseData.length; i++) {
      Banner banner = Banner(
          id: responseData[i]['id'],
          image: responseData[i]['image'],
          playlistId: responseData[i]['playlist_id']);
      bannersList.add(banner);
    }
    return bannersList;
  }
}
