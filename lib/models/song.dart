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
  final Song song;

  final List<Song> songsList;

  AudioPlayerScreenArguments(this.song, this.songsList);
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
}
