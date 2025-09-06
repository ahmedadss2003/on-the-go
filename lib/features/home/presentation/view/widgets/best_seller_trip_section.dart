import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_the_go/features/home/presentation/manager/tour_cubit/tour_cubit_cubit.dart';
import 'package:on_the_go/features/home/presentation/view/widgets/best_seller_card.dart';

class BestSellerTripsSection extends StatelessWidget {
  const BestSellerTripsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return BlocBuilder<TourCubitCubit, TourCubitState>(
      builder: (context, state) {
        if (state is TourCubitLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is TourCubitSuccess) {
          final tours = state.tours;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AutoSizeText(
                "The best of the best: our most popular trips",
                maxLines: 1,
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1F3E66),
                ),
              ),
              const SizedBox(height: 30),
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: tours.length,
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
                  return BestSellerTourCard(tour: tours[index]);
                },
              ),
            ],
          );
        } else if (state is TourCubitError) {
          return Center(child: Text("Error: ${state.message}"));
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
