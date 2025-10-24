import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:on_the_go/features/home/data/models/government_model.dart';
import 'package:on_the_go/features/home/presentation/view/widgets/government_tour_card.dart';
import 'package:url_launcher/url_launcher.dart';

class MostPopularDestinationsContainer extends StatelessWidget {
  const MostPopularDestinationsContainer({super.key});

  @override
  Widget build(BuildContext context) {
    List<GovernmentModel> governmentList = [
      GovernmentModel(
        name: "Cairo Tours",
        description:
            "Discover the vibrant city of Cairo with On The Go Excursions! Enjoy tours to the Pyramids of Giza, Sphinx, Egyptian Museum, and Khan El Khalili Bazaar. Experience Egypt’s rich culture and history with ease, thanks to airport transfers and city transportation. Perfect for UK and European tourists looking for a comprehensive cultural and historical experience in Egypt’s capital.!",
        image:
            "https://media.istockphoto.com/id/2209133341/photo/tropical-coral-reef-and-sea-turtle-beach-with-palms-and-sun-umbrelas-on-the-background-red.webp?a=1&b=1&s=612x612&w=0&k=20&c=zFRjekZwqkhJbAkyuHWLnNkKV3gzBZ3bWzfrbR6rfLw=",
      ),
      GovernmentModel(
        name: "Luxor Tours",
        description:
            "Experience the ancient wonders of Luxor with On The Go Excursions! Explore Valley of the Kings, Karnak Temple, Luxor Temple, and enjoy a relaxing Nile cruise. Our tours include airport transfers and city transportation, guided by professional locals providing detailed cultural insights. Ideal for UK and European travelers seeking a historical and cultural journey in Egypt.!",
        image:
            "https://plus.unsplash.com/premium_photo-1661963306092-3db257ff7c8b?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8THV4b3J8ZW58MHx8MHx8fDA%3D",
      ),
      GovernmentModel(
        name: "Sharm El Sheikh Tours",
        description:
            "Discover the stunning beauty of Sharm El Sheikh with On The Go Excursions! Enjoy unforgettable tours including desert safaris, snorkeling, diving trips, and cultural excursions. Our professional local guides ensure an exceptional experience, with airport transfers and city transportation for your convenience. Perfect for UK and European travelers seeking adventure, relaxation, and luxury in Egyptian Red Sea destinations!",
        image:
            "https://media.istockphoto.com/id/2140634074/photo/beautiful-view-of-cairo-downtown-and-the-nile-from-above-egypt.webp?a=1&b=1&s=612x612&w=0&k=20&c=E1fCBYOzUPUl9fXcW-Bjrlia7pztXaFvIFMXtDsl1xM=",
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final crossAxisCount = _getCrossAxisCount(width);
        final shouldCenter =
            governmentList.length < crossAxisCount &&
            governmentList.length <= 4;

        // ✅ Responsive font sizes
        double titleFontSize;
        double subtitleFontSize;
        if (width < 400) {
          titleFontSize = 20;
          subtitleFontSize = 12;
        } else if (width < 740) {
          titleFontSize = 26;
          subtitleFontSize = 13;
        } else {
          titleFontSize = 36;
          subtitleFontSize = 14;
        }

        return Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 235, 235, 235).withOpacity(0.6),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                // 🌍 Header section
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(30),
                  child: LayoutBuilder(
                    builder: (context, innerConstraints) {
                      final innerWidth = innerConstraints.maxWidth;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText(
                            "Most popular destinations For Travelers",
                            maxLines: 2,
                            minFontSize: 18,
                            style: TextStyle(
                              fontSize: titleFontSize,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF1F3E66),
                            ),
                          ),
                          const SizedBox(height: 10),
                          AutoSizeText(
                            "These are the places our travelers simply love to visit - where will you go next?",
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            minFontSize: 10,
                            style: TextStyle(
                              color: const Color(0xFF1F3E66),
                              fontSize: subtitleFontSize,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Align(
                            alignment:
                                innerWidth < 740
                                    ? Alignment.center
                                    : Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () {
                                _launchtripadvisor();
                              },
                              child: Image.asset(
                                "assets/images/tripadivsorlogo.jpg",
                                width: innerWidth < 400 ? 100 : 150,
                                height: innerWidth < 400 ? 100 : 150,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
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
                                width: _getItemWidth(width, crossAxisCount),
                                child: AspectRatio(
                                  aspectRatio: _getChildAspectRatio(width),
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
                      shrinkWrap: true,
                      itemCount: governmentList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: _getChildAspectRatio(width),
                      ),
                      itemBuilder: (context, index) {
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
    if (width > 994) return 0.62;
    if (width > 750) return 0.8;
    if (width > 550) return 0.9;
    return 0.7;
  }

  double _getItemWidth(double screenWidth, int crossAxisCount) {
    final spacing = 10.0 * (crossAxisCount - 1);
    final availableWidth = screenWidth - spacing;
    return availableWidth / crossAxisCount;
  }

  void _launchtripadvisor() async {
    final Uri tripadvisor = Uri.parse(
      "https://www.tripadvisor.com/UserReviewEdit-g297555-d33953139-On_The_Go_Excursions-Sharm_El_Sheikh_South_Sinai_Red_Sea_and_Sinai.html",
    );
    if (await canLaunchUrl(tripadvisor)) {
      await launchUrl(tripadvisor);
    } else {
      debugPrint("Could not launch WhatsApp");
    }
  }
}
