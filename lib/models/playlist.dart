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

  PlaylistArguments(this.playlistId, this.imageUrl);
}
