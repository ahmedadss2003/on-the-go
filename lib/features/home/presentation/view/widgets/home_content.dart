import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:on_the_go/core/const/app_colors.dart' as AppColors;
import 'package:on_the_go/features/home/presentation/view/home_view.dart';
import 'package:on_the_go/features/home/presentation/view/widgets/How_Book_with_us.dart';
import 'package:on_the_go/features/home/presentation/view/widgets/best_seller_trip_section.dart';
import 'package:on_the_go/features/home/presentation/view/widgets/bg_container.dart';
import 'package:on_the_go/features/home/presentation/view/widgets/footer_section.dart';
import 'package:on_the_go/features/home/presentation/view/widgets/how_pay_section.dart';
import 'package:on_the_go/features/home/presentation/view/widgets/most_popular_destination.dart';
import 'package:on_the_go/features/home/presentation/view/widgets/review_section.dart';
import 'package:on_the_go/features/home/presentation/view/widgets/slide_fade_animation.dart';
import 'package:on_the_go/features/home/presentation/view/widgets/time_descover_widget.dart';
import 'package:on_the_go/features/home/presentation/view/widgets/tour_filter.dart';
import 'offer_container_section.dart';

class HomeContent extends StatelessWidget {
  final GlobalKey footerKey;
  const HomeContent({super.key, required this.footerKey});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return LayoutBuilder(
      builder: (context, constraints) {
        final height = constraints.maxHeight;
        return SingleChildScrollView(
          controller: HomeView.globalScrollController,
          child: Column(
            children: [
              BackgroundContainer(
                child: Column(
                  children: [
                    const OfferContainerSection(),
                    const SizedBox(height: 100),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(
                          255,
                          249,
                          249,
                          247,
                        ).withOpacity(0.6),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: SlideFadeIn(
                        child: const AutoSizeText(
                          "Escorted group tours & private trips",
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 46,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    SlideFadeIn(child: const FilterSection()),
                    SizedBox(height: height * 0.4),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal:
                      width < 700
                          ? 8
                          : width < 1140
                          ? 20
                          : 50,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TimeToDiscoverContainer(),
                    const SizedBox(height: 20),
                    MostPopularDestinationsContainer(),
                    const SizedBox(height: 20),
                    BestSellerTripsSection(),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              HowPaySection(width: width),

              const SizedBox(height: 20),
              ReviewsSection(width: width),
              const SizedBox(height: 20),
              HowBookSection(width: width),
              const SizedBox(height: 50),
              FooterSection(key: footerKey),
            ],
          ),
        );
      },
    );
  }
}
