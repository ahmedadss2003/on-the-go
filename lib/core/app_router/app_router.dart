import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:on_the_go/features/about_us/presentation/pages/about_us_view.dart';
import 'package:on_the_go/features/contact_us/presentation/pages/contact_us.dart';
import 'package:on_the_go/features/discover/presentation/views/discover_places_view.dart';
import 'package:on_the_go/features/home/presentation/view/home_view.dart';
import 'package:on_the_go/features/place_details/presentation/views/place_details_view.dart';
import 'package:on_the_go/features/place_details/presentation/views/place_details_wraper.dart';
import 'package:on_the_go/features/transportation/presentation/transporation_Booking_view.dart';
import 'package:on_the_go/features/why_choose_us/presentation/why_choose_us.dart';

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
        final governmentName = state.pathParameters['governmentName']!;
        final type = state.uri.queryParameters['type']; // optional
        return DiscoverPlacesView(governmentName: governmentName, type: type);
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
      path: AboutUsView.routeName,
      pageBuilder:
          (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: const AboutUsView(),
            transitionsBuilder: (
              context,
              animation,
              secondaryAnimation,
              child,
            ) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
    ),
    GoRoute(
      path: WhyChooseUsView.routeName,
      pageBuilder:
          (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: const WhyChooseUsView(),
            transitionsBuilder: (
              context,
              animation,
              secondaryAnimation,
              child,
            ) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
    ),
    GoRoute(
      path: ContactUsView.routeName,
      pageBuilder:
          (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: const ContactUsView(),
            transitionsBuilder: (
              context,
              animation,
              secondaryAnimation,
              child,
            ) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
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
