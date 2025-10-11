import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:on_the_go/core/models/tour_model.dart';
import 'package:on_the_go/features/home/domain/use_cases/get_Best_seller_tours_usecase.dart';
import 'package:on_the_go/features/home/domain/use_cases/get_all_tours_usecase.dart';
import 'package:on_the_go/features/home/domain/use_cases/get_favourites_tours_usecases.dart';
import 'package:on_the_go/features/home/domain/use_cases/get_tours_by_category_and_governorate_usecase.dart';
import 'package:on_the_go/features/home/domain/use_cases/get_tours_by_category_usecase.dart';

part 'tour_cubit_state.dart';

class TourCubitCubit extends Cubit<TourCubitState> {
  TourCubitCubit(
    this.getAllToursUseCase,
    this.getBestSellerToursUseCase,
    this.getToursByCategoryUseCase,
    this.getToursByCategoryAndGovernorateUseCase,
    this.getFavouritesToursUseCase,
  ) : super(TourCubitInitial());

  final GetAllToursUseCase getAllToursUseCase;
  final GetBestSellerToursUseCase getBestSellerToursUseCase;
  final GetToursByCategoryUseCase getToursByCategoryUseCase;
  final GetFavouritesToursUseCase getFavouritesToursUseCase;
  final GetToursByCategoryAndGovernorateUseCase
  getToursByCategoryAndGovernorateUseCase;

  // Cache variables
  List<TourModel>? _allToursCache;
  List<TourModel>? _bestSellerToursCache;
  final Map<String, List<TourModel>> _categoryCache = {};
  final Map<String, List<TourModel>> _categoryGovernorateCache = {};

  @override
  Future<void> close() {
    return super.close();
  }

  Future<void> getAllTours() async {
    if (_allToursCache != null) {
      emit(TourCubitSuccess(tours: _allToursCache!));
      return;
    }
    emit(TourCubitLoading());
    try {
      final tours = await getAllToursUseCase.call();
      _allToursCache = tours;
      emit(TourCubitSuccess(tours: tours));
    } catch (e) {
      emit(TourCubitError(e.toString()));
    }
  }

  Future<void> getBestSellerTours() async {
    if (_bestSellerToursCache != null) {
      emit(TourCubitSuccess(tours: _bestSellerToursCache!));
      return;
    }
    emit(TourCubitLoading());
    try {
      final tours = await getBestSellerToursUseCase.call();
      _bestSellerToursCache = tours;
      emit(TourCubitSuccess(tours: tours));
    } catch (e) {
      emit(TourCubitError(e.toString()));
    }
  }

  Future<void> getToursByGovernMent(String governMentName) async {
    if (_categoryCache.containsKey(governMentName)) {
      emit(TourCubitSuccess(tours: _categoryCache[governMentName]!));
      return;
    }
    emit(TourCubitLoading());
    try {
      final tours = await getToursByCategoryUseCase.call(governMentName);
      _categoryCache[governMentName] = tours;
      emit(TourCubitSuccess(tours: tours));
    } catch (e) {
      emit(TourCubitError(e.toString()));
    }
  }

  Future<void> getToursByCategory(String category) async {
    if (_categoryCache.containsKey(category)) {
      emit(TourCubitSuccess(tours: _categoryCache[category]!));
      return;
    }
    emit(TourCubitLoading());
    try {
      final tours = await getToursByCategoryUseCase.call(category);
      _categoryCache[category] = tours;
      emit(TourCubitSuccess(tours: tours));
    } catch (e) {
      emit(TourCubitError(e.toString()));
    }
  }

  Future<void> getToursByCategoryAndGovernorate(
    String category,
    String governorate,
  ) async {
    final key = '$category-$governorate';
    if (_categoryGovernorateCache.containsKey(key)) {
      emit(TourCubitSuccess(tours: _categoryGovernorateCache[key]!));
      return;
    }

    emit(TourCubitLoading());
    try {
      final tours = await getToursByCategoryAndGovernorateUseCase.call(
        category,
        governorate,
      );
      _categoryGovernorateCache[key] = tours;
      emit(TourCubitSuccess(tours: tours));
    } catch (e) {
      emit(TourCubitError(e.toString()));
    }
  }

  // Method to clear cache if needed
  void clearCache() {
    _allToursCache = null;
    _bestSellerToursCache = null;
    _categoryCache.clear();
    _categoryGovernorateCache.clear();
  }

  // Method to clear specific cache
  void clearCategoryCache(String category) {
    _categoryCache.remove(category);
  }

  void clearGovernorateCache(String category, String governorate) {
    final key = '$category-$governorate';
    _categoryGovernorateCache.remove(key);
  }
}
