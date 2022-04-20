class Playlist {
  final int id;
  final String name;
  final String imgThumb;
  final int songsCount;

  Playlist(
      {required this.id,
      required this.name,
      required this.imgThumb,
      required this.songsCount});
}

class PlaylistArguments {
  final String playlistId;
  final String imageUrl;
  final String title;
  final int songsCount;

  PlaylistArguments(
      this.playlistId, this.imageUrl, this.title, this.songsCount);
}

class PlaylistsArguments {
  final String playlistsId;
  final String name;

  PlaylistsArguments(this.playlistsId, this.name);
}
