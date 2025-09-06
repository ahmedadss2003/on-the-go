import 'package:on_the_go/core/models/tour_model.dart';
import 'package:on_the_go/features/home/domain/repos/tour_repo.dart';

class GetAllToursUseCase {
  final TourRepo tourRepo;
  GetAllToursUseCase(this.tourRepo);
  Future<List<TourModel>> call() async => await tourRepo.getAllTours();
}
