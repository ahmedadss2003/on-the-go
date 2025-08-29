import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:on_the_go/features/home/presentation/view/widgets/tour_card.dart';

class MostPopularDestinationsContainer extends StatelessWidget {
  const MostPopularDestinationsContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Container(
      // width: width < 700 ? width * 0.98 : width * 0.9,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 235, 235, 235).withOpacity(0.6),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AutoSizeText(
                    "Most popular destinations For Travelers",
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1F3E66),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "These are the places our travelers simply love to visit - where will you go next?",
                    style: TextStyle(color: Color(0xFF1F3E66), fontSize: 14),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
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
                    width < 246
                        ? 0.55
                        : width < 305
                        ? 0.7
                        : width < 375
                        ? 0.9
                        : width < 650
                        ? 1.1
                        : 0.75,
              ),
              itemBuilder: (context, index) {
                // print(width);
                return const TourCard();
              },
            ),
          ],
        ),
      ),
    );
  }
}
