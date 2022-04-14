class Video {
  final int id;
  final String name;
  final String image;
  final String video;

  Video(
      {required this.id,
      required this.name,
      required this.image,
      required this.video});
}

class VideoPlayerScreenArguments {
  final String videoUrl;
  final String playlistId;

  VideoPlayerScreenArguments(this.videoUrl, this.playlistId);
}

class VideoCategoryArguments {
  final String categoryId;
  final String categoryName;

  VideoCategoryArguments(this.categoryId, this.categoryName);
}
