import 'package:flutter/material.dart';
import 'package:on_the_go/core/models/tour_model.dart';
import 'package:on_the_go/features/discover/presentation/views/widgets/discover_places_view_body.dart';

class DiscoverPlacesView extends StatelessWidget {
  const DiscoverPlacesView({
    super.key,
    required this.categoryName,
    // required this.tourModel,
  });
  static const routeName = "/discover_places";
  final String categoryName;
  // final TourModel tourModel;
  @override
  Widget build(BuildContext context) {
    return DiscoverPlacesViewBody(categoryName: categoryName);
  }
}
