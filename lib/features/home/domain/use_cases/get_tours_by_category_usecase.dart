import 'package:on_the_go/core/models/tour_model.dart';
import 'package:on_the_go/features/home/domain/repos/tour_repo.dart';

class GetToursByCategoryUseCase {
  final TourRepo tourRepo;

  GetToursByCategoryUseCase(this.tourRepo);

  Future<List<TourModel>> call(String categoryName) async {
    return await tourRepo.getToursByCategory(categoryName);
  }
}
