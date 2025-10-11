import 'package:on_the_go/features/home/data/models/image_model.dart';
import 'package:on_the_go/features/home/domain/repos/tour_repo.dart';

class GetImagesUsecase {
  final TourRepo tourRepo;

  GetImagesUsecase({required this.tourRepo});
  Future<List<ImageModel>> call() async {
    return tourRepo.getAllImages();
  }
}
