import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'transportation_booking_state.dart';

class TransportationBookingCubit extends Cubit<BookingState> {
  final FirebaseFirestore firestore;

  TransportationBookingCubit({required this.firestore})
    : super(BookingInitial());

  Future<void> bookTransportation(Map<String, dynamic> bookingData) async {
    emit(BookingLoading());
    try {
      await firestore.collection('transportation').add(bookingData);
      emit(BookingSuccess());
    } catch (e) {
      emit(BookingFailure(message: e.toString()));
    }
  }
}
