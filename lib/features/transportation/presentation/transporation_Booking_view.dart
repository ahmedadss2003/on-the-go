import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_the_go/features/transportation/presentation/manager/transportation_booking_cubit/transportation_booking_cubit.dart';
import 'package:on_the_go/features/transportation/presentation/widgets/transporation_booking_view_body.dart';

class TransporationBookingView extends StatelessWidget {
  const TransporationBookingView({super.key});
  static const routeName = '/transportation-booking-view';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              TransportationBookingCubit(firestore: FirebaseFirestore.instance),
      child: const TransporationBookingViewBody(),
    );
  }
}
