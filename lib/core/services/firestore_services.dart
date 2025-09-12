import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:on_the_go/core/models/tour_model.dart';

class FirestoreServices {
  final FirebaseFirestore firestore;

  FirestoreServices({required this.firestore});
  Future<List<TourModel>> getAllTours() async {
    final snapshot = await firestore.collection('tours').get();
    return snapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return TourModel.fromJson(data);
    }).toList();
  }

  Future<List<TourModel>> getToursByGovernMent(String governmentName) async {
    try {
      final snapshot =
          await firestore
              .collection('tours')
              .where('governorate', isEqualTo: governmentName)
              .get();

      return snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id; // نضيف id من Firestore
        return TourModel.fromJson(data);
      }).toList();
    } catch (e) {
      throw Exception("Failed to fetch tours by category: $e");
    }
  }

  Future<List<TourModel>> getToursByCategoryAndGovernorate(
    String categoryName,
    String governorateName,
  ) async {
    try {
      final snapshot =
          await firestore
              .collection('tours')
              .where('category', isEqualTo: categoryName)
              .where('governorate', isEqualTo: governorateName)
              .get();

      return snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return TourModel.fromJson(data);
      }).toList();
    } catch (e) {
      throw Exception("Failed to fetch tours by category and governorate: $e");
    }
  }

  Future<List<TourModel>> getBestSellerTours() async {
    try {
      final snapshot =
          await firestore
              .collection('tours')
              .where('isBestSeller', isEqualTo: true)
              .get();

      return snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return TourModel.fromJson(data);
      }).toList();
    } catch (e) {
      throw Exception("Failed to fetch best seller tours: $e");
    }
  }

  Future<void> bookTour(Map<String, dynamic> bookingData) async {
    try {
      await firestore.collection('Booking').add(bookingData);
    } catch (e) {
      throw Exception("Failed to book tour: $e");
    }
  }
}
