import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_the_go/core/const/app_colors.dart' as AppColors;
import 'package:on_the_go/core/services/firestore_services.dart';
import 'package:on_the_go/features/home/data/repos/tour_repo_impl.dart';
import 'package:on_the_go/features/home/domain/use_cases/get_images_usecase.dart';
import 'package:on_the_go/features/home/presentation/manager/get_images_cubit/get_images_cubit.dart';
import 'package:on_the_go/features/home/presentation/view/home_view.dart';
import 'package:on_the_go/features/home/presentation/view/widgets/How_Book_with_us.dart';
import 'package:on_the_go/features/home/presentation/view/widgets/best_seller_trip_section.dart';
import 'package:on_the_go/features/home/presentation/view/widgets/bg_container.dart';
import 'package:on_the_go/features/home/presentation/view/widgets/footer_section.dart';
import 'package:on_the_go/features/home/presentation/view/widgets/get_fav_trip_section.dart';
import 'package:on_the_go/features/home/presentation/view/widgets/how_pay_section.dart';
import 'package:on_the_go/features/home/presentation/view/widgets/most_popular_destination.dart';
import 'package:on_the_go/features/home/presentation/view/widgets/photos_setion.dart';
import 'package:on_the_go/features/home/presentation/view/widgets/review_section.dart';
import 'package:on_the_go/features/home/presentation/view/widgets/slide_fade_animation.dart';
import 'package:on_the_go/features/home/presentation/view/widgets/time_descover_widget.dart';
import 'package:on_the_go/features/home/presentation/view/widgets/tour_filter.dart';
import 'offer_container_section.dart';

class HomeContent extends StatelessWidget {
  final GlobalKey howBookKey;
  final GlobalKey offersKey;
  final GlobalKey favKey;

  const HomeContent({
    super.key,
    required this.howBookKey,
    required this.offersKey,
    required this.favKey,
  });

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return BlocProvider(
      create:
          (context) => GetImagesCubit(
            GetImagesUsecase(
              tourRepo: TourRepoImpl(
                FirestoreServices(firestore: FirebaseFirestore.instance),
              ),
            ),
          )..getImages(),
      child: SingleChildScrollView(
        controller: HomeView.globalScrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
                    child: const SlideFadeIn(
                      child: AutoSizeText(
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
                  const SlideFadeIn(child: FilterSection()),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.4),
                ],
              ),
            ),
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
                children: [
                  TimeToDiscoverContainer(),
                  const SizedBox(height: 20),
                  const MostPopularDestinationsContainer(),
                  const SizedBox(height: 20),
                  Container(
                    key: offersKey,
                    child: const BestSellerTripsSection(),
                  ),
                  const SizedBox(height: 50),
                  Container(key: favKey, child: const FavouriteTripsSection()),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            HowPaySection(width: width),
            const SizedBox(height: 20),
            ReviewsSection(width: width),
            const SizedBox(height: 20),
            Container(key: howBookKey, child: HowBookSection(width: width)),
            BlocBuilder<GetImagesCubit, GetImagesState>(
              builder: (context, state) {
                if (state is GetImagesSuccess) {
                  return PhotoDisplaySection(imageUrls: state.images);
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
            const SizedBox(height: 50),
            FooterSection(),
          ],
        ),
      ),
    );
  }
}
