import 'package:flutter/material.dart';
import 'package:on_the_go/features/transportation/presentation/widgets/booking_upper_container_section.dart';
import 'package:on_the_go/features/transportation/presentation/widgets/transportation_grid_view.dart';
import 'package:on_the_go/features/transportation/presentation/widgets/transportation_subtittle.dart';
import 'package:on_the_go/features/transportation/presentation/widgets/trasnportation_tittle.dart';
import 'package:on_the_go/features/transportation/presentation/widgets/why_book_with_us._section.dart';

class TransporationBookingViewBody extends StatelessWidget {
  const TransporationBookingViewBody({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SingleChildScrollView(
            child: Column(
              children: [
                CustomBookingContainer(),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: constraints.maxWidth < 700 ? 20 : 60,
                  ),
                  child: Column(
                    children: [
                      TransportationTittle(),
                      SizedBox(height: 20),
                      TransportationSubTittle(),
                      SizedBox(height: 20),
                      WhyBookWithUsSection(),
                      SizedBox(height: 20),
                      TransportationGridView(width: constraints.maxWidth),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
