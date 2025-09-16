import 'package:go_router/go_router.dart';
import 'package:on_the_go/core/models/tour_model.dart';
import 'package:on_the_go/features/discover/presentation/views/discover_places_view.dart';
import 'package:on_the_go/features/home/presentation/view/home_view.dart';
import 'package:on_the_go/features/place_details/presentation/views/place_details_view.dart';
import 'package:on_the_go/features/place_details/presentation/views/place_details_wraper.dart';
import 'package:on_the_go/features/transportation/presentation/transporation_Booking_view.dart';

final GoRouter router = GoRouter(
  initialLocation: HomeView.routeName,
  routes: [
    GoRoute(
      path: HomeView.routeName,
      builder: (context, state) => const HomeView(),
    ),
    GoRoute(
      path: '${DiscoverPlacesView.routeName}/:governmentName',
      builder: (context, state) {
        final TourModel tourModel = state.extra as TourModel;

        final governmentName = state.pathParameters['governmentName']!;
        final type = state.uri.queryParameters['type']; // optional
        return DiscoverPlacesView(
          governmentName: governmentName,
          type: type,
          tourModel: tourModel,
        );
      },
    ),

    GoRoute(
      path: "${PlaceDetailsView.routeName}/:id",
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return PlaceDetailsWrapper(id: id);
      },
    ),
    GoRoute(
      path: TransporationBookingView.routeName,
      builder: (context, state) => const TransporationBookingView(),
    ),
  ],
);

// import 'package:go_router/go_router.dart';
// import 'package:on_the_go/core/models/tour_model.dart';
// import 'package:on_the_go/features/discover/presentation/views/discover_places_view.dart';
// import 'package:on_the_go/features/home/presentation/view/home_view.dart';
// import 'package:on_the_go/features/place_details/presentation/views/place_details_view.dart';

// final GoRouter router = GoRouter(
//   initialLocation: HomeView.routeName,
//   routes: [
//     GoRoute(
//       path: HomeView.routeName,
//       builder: (context, state) => const HomeView(),
//     ),
//     GoRoute(
//       path: DiscoverPlacesView.routeName,
//       builder: (context, state) {
//         if (state.extra == null) {
//           return const HomeView(); // 👈 redirect to home if refresh
//         }
//         final params = state.extra as Map<String, dynamic>;
//         final governmentName = params['governmentName'] as String;
//         final type = params['type'] as String?;
//         return DiscoverPlacesView(governmentName: governmentName, type: type);
//       },
//     ),
//     // GoRoute(
//     //   path: PlaceDetailsView.routeName,
//     //   builder: (context, state) {
//     //     final tourModel =
//     //         state.extra is Map<String, dynamic>
//     //             ? TourModel.fromJson(state.extra as Map<String, dynamic>)
//     //             : state.extra as TourModel;
//     //     return PlaceDetailsView(tourModel: tourModel);
//     //   },
//     // ),
//     GoRoute(
//       path: PlaceDetailsView.routeName,
//       builder: (context, state) {
//         if (state.extra == null) {
//           return const HomeView(); // 👈 redirect to home if refresh
//         }
//         final tourModel =
//             state.extra is Map<String, dynamic>
//                 ? TourModel.fromJson(state.extra as Map<String, dynamic>)
//                 : state.extra as TourModel;
//         return PlaceDetailsView(tourModel: tourModel);
//       },
//     ),
//   ],
// );
