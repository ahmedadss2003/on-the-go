import 'package:on_the_go/core/models/tour_model.dart';
import 'package:on_the_go/core/services/firestore_services.dart';
import 'package:on_the_go/features/home/domain/repos/tour_repo.dart';

class TourRepoImpl implements TourRepo {
  final FirestoreServices firestoreServices;

  TourRepoImpl(this.firestoreServices);
  @override
  Future<List<TourModel>> getAllTours() {
    return firestoreServices.getAllTours();
  }

  @override
  Future<List<TourModel>> getBestSellerTours() {
    return firestoreServices.getBestSellerTours();
  }

  @override
  Future<List<TourModel>> getToursByCategory(String categoryName) {
    return firestoreServices.getToursByCategory(categoryName);
  }

  @override
  Future<List<TourModel>> getToursByCategoryAndGovernorate(
    String categoryName,
    String governorateName,
  ) {
    return firestoreServices.getToursByCategoryAndGovernorate(
      categoryName,
      governorateName,
    );
  }
}
