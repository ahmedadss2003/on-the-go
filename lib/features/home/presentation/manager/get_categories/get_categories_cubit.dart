import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:on_the_go/core/models/category_model.dart';
import 'package:on_the_go/core/services/firestore_services.dart';

part 'get_categories_state.dart';

class GetCategoryCubit extends Cubit<GetCategoryState> {
  GetCategoryCubit() : super(GetCategoryInitial());

  Future<void> getCategories() async {
    emit(GetCategoryLoading());
    try {
      // Create an instance of FirestoreServices with FirebaseFirestore.instance
      final firestoreServices = FirestoreServices(
        firestore: FirebaseFirestore.instance,
      );
      final categories = await firestoreServices.getAllCategories();
      emit(GetCategorySuccess(categories));
    } catch (e) {
      emit(GetCategoryError('Failed to load categories: $e'));
    }
  }
}
