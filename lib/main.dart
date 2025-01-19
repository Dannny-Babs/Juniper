import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'core/utils/utils.dart';
import 'features/navigation/presentation/bloc/navigation_bloc.dart';
import 'features/onboarding/bloc/onboarding_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  final isOnboardingCompleted = prefs.getBool('onboarding_complete') ?? false;

  final router = AppRouter.createRouter(isOnboardingCompleted);
  await initializeDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              OnboardingBloc(prefs: prefs)..add(OnboardingStarted()),
        ),
        BlocProvider(
          create: (context) => NavigationBloc(prefs),
        ),
      ],
      child: MainApp(router: router),
    ),
  );
}

Future<void> initializeDependencies() async {
  // Initialize paths
  final appDocDir = await getApplicationDocumentsDirectory();
  await Directory(appDocDir.path).create(recursive: true);

  // Initialize database
 // Sqflite.setDebugModeOn(kDebugMode);

  // Initialize cache
  await CacheManager.initialize();
}

class CacheManager {
  static Future<void> initialize() async {
    final cacheDir = await getTemporaryDirectory();
    await cacheDir.create(recursive: true);
  }
}

class MainApp extends StatelessWidget {
  final GoRouter router;

  const MainApp({
    super.key,
    required this.router,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      useInheritedMediaQuery: true,
      builder: (context, child) => MaterialApp.router(
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
      ),
    );
  }
}
