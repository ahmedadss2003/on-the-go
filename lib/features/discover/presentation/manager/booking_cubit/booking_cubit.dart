import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:on_the_go/core/services/firestore_services.dart';

part 'booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  final FirestoreServices apiService;
  BookingCubit(this.apiService) : super(BookingInitial());

  Future<void> bookTour(Map<String, dynamic> bookingData) async {
    emit(BookingLoading());
    try {
      await apiService.bookTour(bookingData);
      emit(BookingSuccess());
    } catch (e) {
      emit(BookingFailure(e.toString()));
    }
  }
}
