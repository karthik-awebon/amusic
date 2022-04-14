class Category {
  final int id;
  final String name;
  final String imgThumb;
  final String imgBanner;

  Category(
      {required this.id,
      required this.name,
      required this.imgThumb,
      required this.imgBanner});
}

class CategoryArguments {
  final String categoryId;
  final String categoryName;

  CategoryArguments(this.categoryId, this.categoryName);
}
