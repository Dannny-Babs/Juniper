import 'package:go_router/go_router.dart';
import 'package:juniper/core/utils/utils.dart';

class AppRouter {
  static GoRouter createRouter(bool isOnboardingCompleted) {
    return GoRouter(
      initialLocation: isOnboardingCompleted ? '/login' : '/onboarding',
      routes: [
        GoRoute(
          path: '/onboarding',
          builder: (context, state) => const OnboardingPage(),
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginPage(),
        ),
      ],
    );
  }
}
