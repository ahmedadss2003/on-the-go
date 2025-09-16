import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:on_the_go/core/services/firestore_services.dart';
import 'package:on_the_go/features/home/data/repos/tour_repo_impl.dart';
import 'package:on_the_go/features/home/domain/repos/tour_repo.dart';
import 'package:on_the_go/features/home/domain/use_cases/get_Best_seller_tours_usecase.dart';
import 'package:on_the_go/features/home/domain/use_cases/get_all_tours_usecase.dart';
import 'package:on_the_go/features/home/domain/use_cases/get_favourites_tours_usecases.dart';
import 'package:on_the_go/features/home/domain/use_cases/get_tours_by_category_usecase.dart';
import 'package:on_the_go/features/home/domain/use_cases/get_tours_by_category_and_governorate_usecase.dart';
import 'package:on_the_go/features/home/presentation/manager/tour_cubit/tour_cubit_cubit.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  // Core
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => FirestoreServices(firestore: sl()));

  // Repo
  sl.registerLazySingleton<TourRepo>(() => TourRepoImpl(sl()));

  // UseCases
  sl.registerLazySingleton(() => GetAllToursUseCase(sl()));
  sl.registerLazySingleton(() => GetBestSellerToursUseCase(sl()));
  sl.registerLazySingleton(() => GetToursByCategoryUseCase(sl()));
  sl.registerLazySingleton(() => GetFavouritesToursUseCase(sl()));
  sl.registerLazySingleton(() => GetToursByCategoryAndGovernorateUseCase(sl()));

  // Cubit
  sl.registerLazySingleton(
    () => TourCubitCubit(
      sl<GetAllToursUseCase>(),
      sl<GetBestSellerToursUseCase>(),
      sl<GetToursByCategoryUseCase>(),
      sl<GetToursByCategoryAndGovernorateUseCase>(),
      sl<GetFavouritesToursUseCase>(),
    ),
  );
}
