class VideoCategory {
  final int id;
  final String name;
  final String imgThumb;
  final String imgBanner;

  VideoCategory(
      {required this.id,
      required this.name,
      required this.imgThumb,
      required this.imgBanner});
}

class VideoCategoryArguments {
  final String categoryId;
  final String categoryName;

  VideoCategoryArguments(this.categoryId, this.categoryName);
}
