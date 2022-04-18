class Video {
  final int id;
  final String name;
  final String image;
  final String video;
  final String description;
  final bool isFree;

  Video(
      {required this.id,
      required this.name,
      required this.image,
      required this.video,
      required this.description,
      required this.isFree});
}

class VideoPlayerScreenArguments {
  final String videoUrl;
  final String playlistId;

  VideoPlayerScreenArguments(this.videoUrl, this.playlistId);
}

class VideoPlaylistsArguments {
  final String playlistsId;
  final String name;

  VideoPlaylistsArguments(this.playlistsId, this.name);
}
