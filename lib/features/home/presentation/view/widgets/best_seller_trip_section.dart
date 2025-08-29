import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/widgets.dart';
import 'package:on_the_go/features/home/presentation/view/widgets/best_seller_card.dart';

class BestSellerTripsSection extends StatelessWidget {
  const BestSellerTripsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeText(
          maxLines: 1,
          "The best of the best: our most popular trips",
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1F3E66),
          ),
        ),
        SizedBox(height: 30),
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 5,
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount:
                width < 650
                    ? 1
                    : width < 750
                    ? 2
                    : width < 994
                    ? 3
                    : width < 1322
                    ? 4
                    : 5,
            crossAxisSpacing: 5,
            mainAxisSpacing: 10,
            childAspectRatio:
                width < 216
                    ? 0.3
                    : width < 256
                    ? 0.4
                    : width < 285
                    ? 0.5
                    : width < 367
                    ? 0.56
                    : width < 460
                    ? 0.62
                    : width < 650
                    ? 0.9
                    : 0.47,
          ),
          itemBuilder: (context, index) {
            print(width);
            return const BestSellerTourCard();
          },
        ),
      ],
    );
  }
}
