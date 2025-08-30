import 'package:go_router/go_router.dart';
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
      path: PlaceDetailsView.routeName,
      // redirect: (context, state) {
      //   return state.extra == null ? HomeView.routeName : null;
      // },
      builder: (context, state) {
        return PlaceDetailsView();
      },
    ),
  ],
);
