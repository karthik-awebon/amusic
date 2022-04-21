import 'package:flutter/widgets.dart';

class Song {
  final int id;
  final String name;
  final String imgBanner;
  final String songFile;
  final List<MusicArtist> musicArtists;

  Song(
      {required this.id,
      required this.name,
      required this.imgBanner,
      required this.songFile,
      required this.musicArtists});


  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "name": this.name,
      "imgBanner": this.imgBanner,
      "songFile": this.songFile,
      "musicArtists": this.musicArtists
    };
  }
}


class MusicArtist {
  final int id;
  final String name;
  final String imgBanner;

  MusicArtist({
    required this.id,
    required this.name,
    required this.imgBanner,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "name": this.name,
      "imgBanner": this.imgBanner,
    };
  }
}

class AudioPlayerScreenArguments {
  final String audioUrl;
  final String audioName;

  AudioPlayerScreenArguments(this.audioUrl, this.audioName);
}
enum SongOptions {
  Favorites,
  AddToQueue,
  Downloads,
  Share,
  ClearAll,
}
