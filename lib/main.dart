import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_the_go/core/app_router/app_router.dart';
import 'package:on_the_go/core/services/service_locator.dart';
import 'package:on_the_go/core/utils/dummy_utils.dart';
import 'package:on_the_go/core/widgets/up_arrow.dart';
import 'package:on_the_go/core/widgets/whatsApp_floating_button%20.dart';
import 'package:on_the_go/features/home/presentation/manager/tour_cubit/tour_cubit_cubit.dart';

// استيراد مشروط
import 'core/utils/web_utils.dart'
    if (dart.library.io) 'core/utils/dummy_utils.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupServiceLocator();

  // هنا هتشتغل بس لو Web
  if (kIsWeb) {
    setupWebStuff();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<TourCubitCubit>(),
      child: MaterialApp.router(
        routerConfig: router,
        title: "On The Go",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 247, 247, 247),
          primaryColor: Colors.white,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        builder: (context, child) {
          return Scaffold(
            body: Stack(
              children: [
                child ?? const SizedBox.shrink(),
                const WhatsAppFloatingButton(),
                UpArrow(),
              ],
            ),
          );
        },
      ),
    );
  }
}
