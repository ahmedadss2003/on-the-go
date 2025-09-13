import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_the_go/core/models/tour_model.dart';
import 'package:on_the_go/core/services/firestore_services.dart';
import 'package:on_the_go/features/discover/presentation/manager/booking_cubit/booking_cubit.dart';
import 'package:on_the_go/features/place_details/presentation/views/widgets/place_details_view_body.dart';

class PlaceDetailsView extends StatelessWidget {
  const PlaceDetailsView({super.key, required this.tourModel});
  static const String routeName = '/place_details';
  final TourModel tourModel;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => BookingCubit(
            FirestoreServices(firestore: FirebaseFirestore.instance),
          ),
      child: SelectableRegion(
        focusNode: FocusNode(),
        selectionControls: MaterialTextSelectionControls(),
        child: PlaceDetailsViewBody(tourModel: tourModel),
      ),
    );
  }
}
