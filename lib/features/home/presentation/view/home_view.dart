import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_the_go/core/services/firestore_services.dart';
import 'package:on_the_go/features/home/data/repos/tour_repo_impl.dart';
import 'package:on_the_go/features/home/domain/use_cases/get_favourites_tours_usecases.dart';
import 'package:on_the_go/features/home/presentation/manager/favourite_tour/favourite_tour_cubit.dart';
import 'package:on_the_go/features/home/presentation/manager/get_categories/get_categories_cubit.dart';
import 'package:on_the_go/features/home/presentation/view/widgets/home_view_body.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  static const routeName = '/';
  static late ScrollController globalScrollController;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    HomeView.globalScrollController = _scrollController;
    _scrollController.addListener(_handleScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_handleScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _handleScroll() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {}
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetCategoryCubit(),
      child: BlocProvider(
        create:
            (context) => FavouriteTourCubit(
              GetFavouritesToursUseCase(
                TourRepoImpl(
                  FirestoreServices(firestore: FirebaseFirestore.instance),
                ),
              ),
            ),
        child: HomeViewBody(),
      ),
    );
  }
}
