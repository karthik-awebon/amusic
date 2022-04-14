class Video {
  final int id;
  final String name;
  final String image;
  final String video;
  final String description;

  Video(
      {required this.id,
      required this.name,
      required this.image,
      required this.video,
      required this.description});
}

class VideoPlayerScreenArguments {
  final String videoUrl;
  final String playlistId;

  VideoPlayerScreenArguments(this.videoUrl, this.playlistId);
}
