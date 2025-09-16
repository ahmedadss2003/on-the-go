import 'package:flutter/material.dart';
import 'package:on_the_go/features/transportation/data/models/transportation_model.dart';
import 'package:on_the_go/features/transportation/presentation/widgets/book_transport_card.dart';

class TransportationGridView extends StatelessWidget {
  const TransportationGridView({super.key, required this.width});
  final double width;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: transportationModels.length, // Use static list
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount:
            width < 740
                ? 1
                : width < 1112
                ? 2
                : 3,
        childAspectRatio:
            width < 400
                ? 0.9
                : width < 740
                ? 1.1
                : width < 1112
                ? 0.95
                : 0.85,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        return TransportationBookingCard(
          width: width,
          transportationModel: transportationModels[index],
        );
      },
    );
  }
}
