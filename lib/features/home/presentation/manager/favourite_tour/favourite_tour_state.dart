part of 'favourite_tour_cubit.dart';

@immutable
class FavouriteTourState {}

class FavouriteTourInitial extends FavouriteTourState {}

class FavouriteTourLoading extends FavouriteTourState {}

class FavouriteTourSuccess extends FavouriteTourState {
  final List<TourModel> tours;
  FavouriteTourSuccess({required this.tours});
}

class FavouriteTourError extends FavouriteTourState {
  final String message;
  FavouriteTourError(this.message);
}
