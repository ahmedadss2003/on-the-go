import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:on_the_go/features/home/data/models/government_model.dart';
import 'package:on_the_go/features/home/presentation/view/widgets/government_tour_card.dart';

class MostPopularDestinationsContainer extends StatelessWidget {
  const MostPopularDestinationsContainer({super.key});
  @override
  Widget build(BuildContext context) {
    List<GovernmentModel> governmentList = [
      GovernmentModel(
        name: "Sharm El Sheikh Tours",
        description:
            "Cairo offers a wide range of tours catering to diverse interests, from iconic historical sites to unique cultural experiences. Popular day trips include visits to the Pyramids of Giza and the Great Sphinx, with options for private tours, camel rides, and even sunrise or sunset excursions , let's discover",
        image:
            "https://media.istockphoto.com/id/2209133341/photo/tropical-coral-reef-and-sea-turtle-beach-with-palms-and-sun-umbrelas-on-the-background-red.webp?a=1&b=1&s=612x612&w=0&k=20&c=zFRjekZwqkhJbAkyuHWLnNkKV3gzBZ3bWzfrbR6rfLw=",
      ),
      GovernmentModel(
        name: "Luxor Tours",
        description:
            "Luxor offers an extraordinary journey into ancient Egypt’s heart, home to magnificent temples and royal tombs. Visitors can explore the Valley of the Kings, Karnak Temple, and Luxor Temple , let's discover.",
        image:
            "https://plus.unsplash.com/premium_photo-1661963306092-3db257ff7c8b?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8THV4b3J8ZW58MHx8MHx8fDA%3D",
      ),
      GovernmentModel(
        name: "Cairo Tours",
        description:
            "Sharm El Sheikh is a world-renowned resort town on the Red Sea, famous for its crystal-clear waters, vibrant coral reefs, and exciting water sports. Visitors can enjoy snorkeling, scuba diving, desert safaris, or simply relax on beautiful beaches. , let's discover",
        image:
            "https://media.istockphoto.com/id/2140634074/photo/beautiful-view-of-cairo-downtown-and-the-nile-from-above-egypt.webp?a=1&b=1&s=612x612&w=0&k=20&c=E1fCBYOzUPUl9fXcW-Bjrlia7pztXaFvIFMXtDsl1xM=",
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final crossAxisCount = _getCrossAxisCount(constraints.maxWidth);
        final shouldCenter =
            governmentList.length < crossAxisCount &&
            governmentList.length <= 4;
        return Container(
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
                      const Text(
                        "These are the places our travelers simply love to visit - where will you go next?",
                        style: TextStyle(
                          color: Color(0xFF1F3E66),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                shouldCenter
                    ? Center(
                      child: Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        alignment: WrapAlignment.center,
                        children:
                            governmentList.map((gov) {
                              return SizedBox(
                                width: _getItemWidth(
                                  constraints.maxWidth,
                                  crossAxisCount,
                                ),
                                child: AspectRatio(
                                  aspectRatio: _getChildAspectRatio(
                                    constraints.maxWidth,
                                  ),
                                  child: GovernmentFilterTourCard(
                                    governmentModel: gov,
                                  ),
                                ),
                              );
                            }).toList(),
                      ),
                    )
                    : GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: governmentList.length,
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: _getChildAspectRatio(
                          constraints.maxWidth,
                        ),
                      ),
                      itemBuilder: (context, index) {
                        print(width);
                        return GovernmentFilterTourCard(
                          governmentModel: governmentList[index],
                        );
                      },
                    ),
              ],
            ),
          ),
        );
      },
    );
  }

  int _getCrossAxisCount(double width) {
    if (width > 1322) return 5;
    if (width > 994) return 4;
    if (width > 750) return 3;
    if (width > 550) return 2;
    return 1;
  }

  double _getChildAspectRatio(double width) {
    if (width > 1322) return 0.7;
    if (width > 450 && width < 550) return 1;
    if (width > 340 && width < 450) return 1;
    if (width > 994) return 0.62;
    if (width < 870) return 0.67;
    if (width <= 290) return 0.56;

    if (width < 490) return 0.9;
    if (width > 750) return 0.8;
    if (width < 750) return 0.6;
    if (width > 650) return 1.1;
    return 0.8;
  }

  double _getItemWidth(double screenWidth, int crossAxisCount) {
    final spacing = 10.0 * (crossAxisCount - 1);
    final availableWidth = screenWidth - spacing;
    return availableWidth / crossAxisCount;
  }
}
