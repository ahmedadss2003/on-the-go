part of 'get_images_cubit.dart';

@immutable
sealed class GetImagesState {}

final class GetImagesInitial extends GetImagesState {}

final class GetImagesLoading extends GetImagesState {}

final class GetImagesSuccess extends GetImagesState {
  final List<ImageModel> images;

  GetImagesSuccess(this.images);
}

final class GetImagesError extends GetImagesState {
  final String message;

  GetImagesError(this.message);
}
