import 'package:flutter/material.dart';
import 'core/utils/utils.dart';
import 'features/onboarding/bloc/onboarding_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final isOnboardingCompleted = prefs.getBool('onboarding_complete') ?? false;
  
  final router = AppRouter.createRouter(isOnboardingCompleted);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => OnboardingBloc(prefs: prefs)..add(OnboardingStarted()),
        ),
      ],
      child: MainApp(router: router),
    ),
  );
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