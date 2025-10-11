import 'package:on_the_go/core/models/tour_model.dart';
import 'package:on_the_go/features/home/data/models/image_model.dart';

abstract class TourRepo {
  Future<List<TourModel>> getAllTours();
  Future<List<TourModel>> getToursByCategory(String categoryName);
  Future<List<TourModel>> getToursByCategoryAndGovernorate(
    String categoryName,
    String governorateName,
  );
  Future<List<TourModel>> getBestSellerTours();
  Future<List<TourModel>> getFavouriteTours();
  Future<List<ImageModel>> getAllImages();
}
