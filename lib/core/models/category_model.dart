import 'package:on_the_go/core/models/category_pivot.dart';

class CategoryModel {
  final int id;
  final String categoryName;
  final String createdAt;
  final String updatedAt;
  final CategoryPivot pivot;

  CategoryModel({
    required this.id,
    required this.categoryName,
    required this.createdAt,
    required this.updatedAt,
    required this.pivot,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      categoryName: json['category_name'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      pivot: CategoryPivot.fromJson(json['pivot']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'category_name': categoryName,
    'created_at': createdAt,
    'updated_at': updatedAt,
    'pivot': pivot.toJson(),
  };
}
