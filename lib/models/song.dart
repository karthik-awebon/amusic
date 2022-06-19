import 'package:flutter/widgets.dart';

class Song {
  final int id;
  final String name;
  final String imgThumb;
  final String songFile;
  final String releaseDate;
  final List<MusicArtist> musicArtists;

  Song(
      {required this.id,
      required this.name,
      required this.imgThumb,
      required this.songFile,
      required this.releaseDate,
      required this.musicArtists});

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "name": this.name,
      "imgThumb": this.imgThumb,
      "songFile": this.songFile,
      "musicArtists": this.musicArtists
    };
  }
}

class MusicArtist {
  final int id;
  final String name;
  final String imgBanner;
  int noOfSongs;

  MusicArtist(
      {required this.id,
      required this.name,
      required this.imgBanner,
      this.noOfSongs = 0});

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "name": this.name,
      "imgBanner": this.imgBanner,
      "noOfSongs": this.noOfSongs,
    };
  }
}

class SongInfoArguments {
  final Song song;

  SongInfoArguments(this.song);
}

enum SongOptions {
  Favorites,
  AddToQueue,
  Downloads,
  Share,
  ClearAll,
  UnFavorite,
  Volume,
  Delete,
}
