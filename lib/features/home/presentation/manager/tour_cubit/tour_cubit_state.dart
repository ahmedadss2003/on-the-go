part of 'tour_cubit_cubit.dart';

@immutable
sealed class TourCubitState {}

final class TourCubitInitial extends TourCubitState {}

final class TourCubitLoading extends TourCubitState {}

final class TourCubitSuccess extends TourCubitState {
  final List<TourModel> tours;
  TourCubitSuccess(this.tours);
}

final class TourCubitError extends TourCubitState {
  final String message;
  TourCubitError(this.message);
}
