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
}
