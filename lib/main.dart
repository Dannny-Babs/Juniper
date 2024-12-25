import 'package:flutter/material.dart';
import 'core/utils/router.dart';
import 'core/utils/utils.dart';
import 'features/onboarding/bloc/onboarding_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => OnboardingBloc(prefs: prefs)..add(OnboardingStarted()),
        ),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      useInheritedMediaQuery: true,
      child: BlocBuilder<OnboardingBloc, OnboardingState>(
        builder: (context, state) {
          final router = AppRouter.createRouter(state.isCompleted);

          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: ThemeMode.system,
            routerConfig: router,
          );
        },
      ),
    );
  }
}
