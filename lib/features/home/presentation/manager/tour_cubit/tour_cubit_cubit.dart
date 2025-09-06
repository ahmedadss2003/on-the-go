import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:on_the_go/core/models/tour_model.dart';
import 'package:on_the_go/features/home/domain/use_cases/get_Best_seller_tours_usecase.dart';
import 'package:on_the_go/features/home/domain/use_cases/get_all_tours_usecase.dart';
import 'package:on_the_go/features/home/domain/use_cases/get_tours_by_category_and_governorate_usecase.dart';
import 'package:on_the_go/features/home/domain/use_cases/get_tours_by_category_usecase.dart';

part 'tour_cubit_state.dart';

class TourCubitCubit extends Cubit<TourCubitState> {
  TourCubitCubit(
    this.getAllToursUseCase,
    this.getBestSellerToursUseCase,
    this.getToursByCategoryUseCase,
    this.getToursByCategoryAndGovernorateUseCase,
  ) : super(TourCubitInitial());
  final GetAllToursUseCase getAllToursUseCase;
  final GetBestSellerToursUseCase getBestSellerToursUseCase;
  final GetToursByCategoryUseCase getToursByCategoryUseCase;
  final GetToursByCategoryAndGovernorateUseCase
  getToursByCategoryAndGovernorateUseCase;

  Future<void> getAllTours() async {
    emit(TourCubitLoading());
    try {
      final tours = await getAllToursUseCase.call();
      emit(TourCubitSuccess(tours));
    } catch (e) {
      emit(TourCubitError(e.toString()));
    }
  }

  Future<void> getBestSellerTours() async {
    emit(TourCubitLoading());
    try {
      final tours = await getBestSellerToursUseCase.call();
      emit(TourCubitSuccess(tours));
    } catch (e) {
      emit(TourCubitError(e.toString()));
    }
  }

  Future<void> getToursByCategory(String category) async {
    emit(TourCubitLoading());
    try {
      final tours = await getToursByCategoryUseCase.call(category);
      emit(TourCubitSuccess(tours));
    } catch (e) {
      emit(TourCubitError(e.toString()));
    }
  }

  Future<void> getToursByCategoryAndGovernorate(
    String category,
    String governorate,
  ) async {
    emit(TourCubitLoading());
    try {
      final tours = await getToursByCategoryAndGovernorateUseCase.call(
        category,
        governorate,
      );
      emit(TourCubitSuccess(tours));
    } catch (e) {
      emit(TourCubitError(e.toString()));
    }
  }
}
