import 'package:on_the_go/core/models/tour_model.dart';
import 'package:on_the_go/features/home/domain/repos/tour_repo.dart';

class GetToursByCategoryAndGovernorateUseCase {
  final TourRepo repository;
  GetToursByCategoryAndGovernorateUseCase(this.repository);

  Future<List<TourModel>> call(String category, String governorate) async {
    return await repository.getToursByCategoryAndGovernorate(
      category,
      governorate,
    );
  }
}
