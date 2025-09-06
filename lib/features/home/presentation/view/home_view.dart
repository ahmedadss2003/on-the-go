import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_the_go/core/services/service_locator.dart';
import 'package:on_the_go/features/home/presentation/manager/tour_cubit/tour_cubit_cubit.dart';
import 'package:on_the_go/features/home/presentation/view/widgets/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  static const routeName = '/';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<TourCubitCubit>()..getBestSellerTours(),
      child: HomeViewBody(),
    );
  }
}
