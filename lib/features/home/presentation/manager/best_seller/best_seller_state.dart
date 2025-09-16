part of 'best_seller_cubit.dart';

class BestSellerTourState {}

class BestSellerTourInitial extends BestSellerTourState {}

class BestSellerTourLoading extends BestSellerTourState {}

class BestSellerTourSuccess extends BestSellerTourState {
  final List<TourModel> tours;
  BestSellerTourSuccess({required this.tours});
}

class BestSellerTourError extends BestSellerTourState {
  final String message;
  BestSellerTourError(this.message);
}
