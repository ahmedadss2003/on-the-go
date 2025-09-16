import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_the_go/core/widgets/tour_card.dart';
import 'package:on_the_go/features/home/presentation/manager/favourite_tour/favourite_tour_cubit.dart';
import 'package:on_the_go/features/home/presentation/manager/tour_cubit/tour_cubit_cubit.dart';

class FavouriteTripsSection extends StatelessWidget {
  const FavouriteTripsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    context.read<FavouriteTourCubit>().getFavouriteTours();

    return BlocBuilder<FavouriteTourCubit, FavouriteTourState>(
      builder: (context, state) {
        if (state is FavouriteTourLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is FavouriteTourSuccess) {
          final tours = state.tours;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AutoSizeText(
                "The Favourites and Fam Tours",
                maxLines: 1,
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w700,
                  color: Color.fromARGB(255, 3, 39, 87),
                ),
              ),
              const SizedBox(height: 30),
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: tours.length,
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: _getCrossAxisCount(width),
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 10,
                  childAspectRatio: _getChildAspectRatio(width),
                ),
                itemBuilder: (context, index) {
                  return TourCard(tourModel: tours[index], width: width);
                },
              ),
            ],
          );
        } else if (state is FavouriteTourError) {
          return Center(child: Text("Error: ${state.message}"));
        } else {
          return const SizedBox();
        }
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
    if (width > 1322) return 0.7;
    if (width <= 290) return 0.56;

    if (width < 490) return 0.9;
    if (width > 994) return 0.62;
    if (width < 870) return 0.7;
    if (width > 750) return 0.9;
    if (width < 750) return 0.6;
    if (width > 650) return 1.1;
    return 0.9;
  }
}
