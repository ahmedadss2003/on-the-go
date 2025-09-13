import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:on_the_go/core/models/tour_model.dart';
import 'package:on_the_go/features/place_details/presentation/views/place_details_view.dart';

class PlaceDetailsWrapper extends StatelessWidget {
  final String id;
  const PlaceDetailsWrapper({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance.collection('tours').doc(id).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const Scaffold(body: Center(child: Text("Tour not found")));
        }

        final data = snapshot.data!.data() as Map<String, dynamic>;
        final tourModel = TourModel.fromJson(data);

        return PlaceDetailsView(tourModel: tourModel);
      },
    );
  }
}
