import 'package:go_router/go_router.dart';
import 'package:on_the_go/core/models/tour_model.dart';
import 'package:on_the_go/features/discover/presentation/views/discover_places_view.dart';
import 'package:on_the_go/features/home/presentation/view/home_view.dart';
import 'package:on_the_go/features/place_details/presentation/views/place_details_view.dart';

final GoRouter router = GoRouter(
  initialLocation: HomeView.routeName,
  routes: [
    GoRoute(
      path: HomeView.routeName,
      builder: (context, state) => const HomeView(),
    ),
    GoRoute(
      path: DiscoverPlacesView.routeName,
      builder: (context, state) {
        // final tourModel = state.extra as TourModel;

        return DiscoverPlacesView(categoryName: "Cairo");
      },
    ),
    GoRoute(
      path: PlaceDetailsView.routeName,
      builder: (context, state) {
        final tourModel = state.extra as TourModel;
        return PlaceDetailsView(tourModel: tourModel);
      },
    ),
  ],
);
