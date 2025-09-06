import 'package:on_the_go/core/models/tour_model.dart';
import 'package:on_the_go/features/home/domain/repos/tour_repo.dart';

class GetBestSellerToursUseCase {
  final TourRepo tourRepository;
  GetBestSellerToursUseCase(this.tourRepository);

  Future<List<TourModel>> call() async {
    return await tourRepository.getBestSellerTours();
  }
}
