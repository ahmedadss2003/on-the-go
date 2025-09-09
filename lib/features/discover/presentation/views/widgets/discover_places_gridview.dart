import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_the_go/core/widgets/tour_card.dart';
import 'package:on_the_go/features/home/presentation/manager/tour_cubit/tour_cubit_cubit.dart';

class CustomDiscoverPlacesByCategoryGridView extends StatefulWidget {
  const CustomDiscoverPlacesByCategoryGridView({
    super.key,
    required this.governMentName,
    this.type,
  });
  final String governMentName;
  final String? type;

  @override
  State<CustomDiscoverPlacesByCategoryGridView> createState() =>
      _CustomDiscoverPlacesByCategoryGridViewState();
}

class _CustomDiscoverPlacesByCategoryGridViewState
    extends State<CustomDiscoverPlacesByCategoryGridView> {
  @override
  void initState() {
    super.initState();
    final cubit = context.read<TourCubitCubit>();
    if (widget.type != null) {
      cubit.getToursByCategoryAndGovernorate(
        widget.type!,
        widget.governMentName,
      );
    } else {
      cubit.getToursByGovernMent(widget.governMentName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return BlocBuilder<TourCubitCubit, TourCubitState>(
          builder: (context, state) {
            if (state is TourCubitLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TourCubitSuccess) {
              final tours = state.tours;
              return LayoutBuilder(
                builder: (context, constraints) {
                  final crossAxisCount = _getCrossAxisCount(
                    constraints.maxWidth,
                  );
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      childAspectRatio: _getChildAspectRatio(
                        constraints.maxWidth,
                      ),
                    ),
                    itemCount: tours.length,
                    itemBuilder: (context, index) {
                      return TourCard(
                        width: constraints.maxWidth,
                        tourModel: tours[index],
                      );
                    },
                  );
                },
              );
            } else if (state is TourCubitError) {
              return Center(child: Text("Error: ${state.message}"));
            }
            return const SizedBox.shrink();
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
}
