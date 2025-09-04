import 'package:flutter/material.dart';
import 'package:on_the_go/core/widgets/trip_card.dart';

class CustomDiscoverPlacesGridView extends StatelessWidget {
  const CustomDiscoverPlacesGridView({super.key, required this.categoryName});
  final String categoryName;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = _getCrossAxisCount(constraints.maxWidth);

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            childAspectRatio: _getChildAspectRatio(constraints.maxWidth),
          ),
          itemCount: 5,
          itemBuilder: (context, index) {
            return TripCard(width: constraints.maxWidth);
          },
        );
      },
    );
  }

  int _getCrossAxisCount(double width) {
    if (width > 1200) return 4;
    if (width > 900) return 3;
    if (width > 600) return 2;
    return 1;
  }

  double _getChildAspectRatio(double width) {
    if (width > 1200) return 0.75;
    if (width > 900) return 0.8;
    if (width > 600) return 0.75;
    return 1.4;
  }

  double _getItemWidth(double screenWidth, int crossAxisCount) {
    final spacing = 15.0 * (crossAxisCount - 1);
    final availableWidth = screenWidth - spacing;
    return availableWidth / crossAxisCount;
  }
}
