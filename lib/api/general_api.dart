import 'dart:collection';
import 'dart:convert';

import 'package:amusic_app/models/package.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/song.dart';
import 'constants.dart';
import 'home_api.dart';

class GeneralApi {
  static Future getPackagesList() async {
    http.Response response =
        await http.get(Uri.parse("$API_BASE_URL/subscribe/list-package"));
    return constructPackageList(jsonDecode(response.body)['data']);
  }

  static List<Package> constructPackageList(responseData) {
    List<Package> packagesList = [];
    for (var i = 0; i < responseData.length; i++) {
      Package package = Package(
          id: responseData[i]['id'],
          name: responseData[i]['name'],
          description: responseData[i]['description'],
          price: responseData[i]['price']);
      packagesList.add(package);
    }
    return packagesList;
  }

  static Future<List<Song>> getFavoriteSongs() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('favorite_songs')) {
      final favoriteSongsList =
          json.decode(prefs.getString('favorite_songs').toString());
      return constructSongsList(favoriteSongsList);
    }
    return [];
  }

  static List<Song> constructSongsList(responseData) {
    List<Song> songsList = [];
    for (var i = 0; i < responseData.length; i++) {
      List<MusicArtist> musicArtistList = [];
      if (responseData[i]['musicArtists'].length > 0) {
        MusicArtist musicArtist = MusicArtist(
            id: responseData[i]['musicArtists'][0]['id'],
            name: responseData[i]['musicArtists'][0]['name'],
            imgBanner: responseData[i]['musicArtists'][0]['imgBanner']);

        musicArtistList.add(musicArtist);
      }

      Song song = Song(
          id: responseData[i]['id'],
          name: responseData[i]['name'],
          imgThumb: responseData[i]['imgThumb'],
          songFile: responseData[i]['songFile'],
          releaseDate: responseData[i]['releaseDate'],
          musicArtists: musicArtistList);
      songsList.add(song);
    }
    return songsList;
  }

  static Future<LinkedHashMap<String, dynamic>> getSettingsPageUrl() async {
    http.Response response =
        await http.get(Uri.parse("$API_BASE_URL/utility/setting"));
    return jsonDecode(response.body)['data'];
  }
}
