import 'package:go_router/go_router.dart';
import 'package:on_the_go/features/home/presentation/view/home_view.dart';

final GoRouter router = GoRouter(
  initialLocation: HomeView.routeName,
  routes: [
    GoRoute(
      path: HomeView.routeName,
      builder: (context, state) => const HomeView(),
    ),
  ],
);
