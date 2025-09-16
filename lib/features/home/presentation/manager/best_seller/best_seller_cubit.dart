import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:on_the_go/core/models/tour_model.dart';
import 'package:on_the_go/features/home/domain/use_cases/get_Best_seller_tours_usecase.dart';

part 'best_seller_state.dart';

class BestSellerTourCubit extends Cubit<BestSellerTourState> {
  final GetBestSellerToursUseCase getBestSellerToursUseCase;

  BestSellerTourCubit(this.getBestSellerToursUseCase)
    : super(BestSellerTourInitial());

  List<TourModel>? _bestSellerToursCache;

  Future<void> getBestSellerTours() async {
    if (_bestSellerToursCache != null) {
      emit(BestSellerTourSuccess(tours: _bestSellerToursCache!));
      return;
    }
    emit(BestSellerTourLoading());
    try {
      final tours = await getBestSellerToursUseCase.call();
      _bestSellerToursCache = tours;
      emit(BestSellerTourSuccess(tours: tours));
    } catch (e) {
      emit(BestSellerTourError(e.toString()));
    }
  }
}
