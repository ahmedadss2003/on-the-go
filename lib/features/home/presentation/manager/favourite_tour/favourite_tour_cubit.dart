import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:on_the_go/core/models/tour_model.dart';
import 'package:on_the_go/features/home/domain/use_cases/get_favourites_tours_usecases.dart';

part 'favourite_tour_state.dart';

class FavouriteTourCubit extends Cubit<FavouriteTourState> {
  final GetFavouritesToursUseCase getFavouritesToursUseCase;

  FavouriteTourCubit(this.getFavouritesToursUseCase)
    : super(FavouriteTourInitial());

  List<TourModel>? _favouritesToursCache;

  Future<void> getFavouriteTours() async {
    if (_favouritesToursCache != null) {
      emit(FavouriteTourSuccess(tours: _favouritesToursCache!));
      return;
    }
    emit(FavouriteTourLoading());
    try {
      final tours = await getFavouritesToursUseCase.call();
      _favouritesToursCache = tours;
      emit(FavouriteTourSuccess(tours: tours));
    } catch (e) {
      emit(FavouriteTourError(e.toString()));
    }
  }
}
