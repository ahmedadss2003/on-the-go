import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'book_tour_state.dart';

class BookingCubit extends Cubit<BookingState> {
  BookingCubit() : super(BookingInitial());

  Future<void> bookTour(Map<String, dynamic> bookingData) async {
    emit(BookingLoading());
    try {
      await FirebaseFirestore.instance.collection('Booking').add(bookingData);
      emit(BookingSuccess());
    } catch (e) {
      emit(BookingFailure(e.toString()));
    }
  }
}
