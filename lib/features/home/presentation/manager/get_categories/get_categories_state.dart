part of 'get_categories_cubit.dart';

abstract class GetCategoryState {}

class GetCategoryInitial extends GetCategoryState {}

class GetCategoryLoading extends GetCategoryState {}

class GetCategorySuccess extends GetCategoryState {
  final List<CategoryModel> categories;
  GetCategorySuccess(this.categories);
}

class GetCategoryError extends GetCategoryState {
  final String message;
  GetCategoryError(this.message);
}
