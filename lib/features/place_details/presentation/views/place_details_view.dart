import 'package:flutter/material.dart';
import 'package:on_the_go/core/models/tour_model.dart';
import 'package:on_the_go/features/place_details/presentation/views/widgets/place_details_view_body.dart';

class PlaceDetailsView extends StatelessWidget {
  const PlaceDetailsView({super.key, required this.tourModel});
  static const String routeName = '/place_details';
  final TourModel tourModel;
  @override
  Widget build(BuildContext context) {
    return PlaceDetailsViewBody(tourModel: tourModel);
  }
}
