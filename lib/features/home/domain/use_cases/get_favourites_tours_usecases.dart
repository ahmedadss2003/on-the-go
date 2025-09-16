import 'package:on_the_go/core/models/tour_model.dart';
import 'package:on_the_go/features/home/domain/repos/tour_repo.dart';

class GetFavouritesToursUseCase {
  final TourRepo tourRepository;
  GetFavouritesToursUseCase(this.tourRepository);

  Future<List<TourModel>> call() async {
    return await tourRepository.getFavouriteTours();
  }
}
