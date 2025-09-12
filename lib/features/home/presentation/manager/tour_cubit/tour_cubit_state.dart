part of 'tour_cubit_cubit.dart';

@immutable
sealed class TourCubitState {}

final class TourCubitInitial extends TourCubitState {}

final class TourCubitLoading extends TourCubitState {}

class TourCubitSuccess extends TourCubitState {
  final List<TourModel> tours;

  TourCubitSuccess({required this.tours}); // Named parameter

  @override
  List<Object> get props => [tours];
}

final class TourCubitError extends TourCubitState {
  final String message;
  TourCubitError(this.message);
}
