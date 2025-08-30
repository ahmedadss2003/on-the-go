class CategoryPivot {
  final int tourId;
  final int categoryId;

  CategoryPivot({
    required this.tourId,
    required this.categoryId,
  });

  factory CategoryPivot.fromJson(Map<String, dynamic> json) {
    return CategoryPivot(
      tourId: json['tour_id'],
      categoryId: json['category_id'],
    );
  }

  Map<String, dynamic> toJson() => {
    'tour_id': tourId,
    'category_id': categoryId,
  };
}
