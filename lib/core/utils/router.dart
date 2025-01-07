import 'package:go_router/go_router.dart';
import 'package:juniper/core/utils/utils.dart';

class AppRouter {
  static GoRouter createRouter(bool isOnboardingCompleted) {
<<<<<<< Updated upstream
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
=======
    if (!_initialized) {
      _router = GoRouter(
        navigatorKey: _rootNavigatorKey,
        initialLocation: isOnboardingCompleted ? '/login' : '/onboarding',
        
        // Redirect logic that only applies on first launch
        redirect: (context, state) {
          if (!_initialized) {
            _initialized = true;
            return isOnboardingCompleted ? '/login' : '/onboarding';
          }
          return null; // Return null to prevent redirects after initialization
        },

        routes: [
          GoRoute(
            path: '/onboarding',
            name: 'onboarding',
            builder: (context, state) => const OnboardingPage(),
          ),
          GoRoute(
            path: '/login',
            name: 'login',
            builder: (context, state) => const LoginPage(),
          ),
          GoRoute(
            path: '/register',
            name: 'register',
            builder: (context, state) => const RegisterPage(),
          ),
          GoRoute(
            path: '/forgot-password',
            name: 'forgot-password',
            builder: (context, state) => const ForgotPasswordPage(),
          ),
          GoRoute(
            path: '/otp',
            name: 'otp',
            builder: (context, state) {
              // Get email from state.extra or params
              final email = (state.extra as Map<String, dynamic>?)?['email'] as String? ?? 
                          'user@example.com';
              return EmailVerificationPage(email: email);
            },
          ),
          GoRoute(
            path: '/profile-setup',
            name: 'profile-setup',
            builder: (context, state) =>  ProfileSetupPage(),
          ),
          GoRoute(
            path: '/home',
            name: 'home',
            builder: (context, state) => const HomePage(),
          ),



        ],
        
        // Optional: Error handling for unknown routes
        errorBuilder: (context, state) => const NotFoundPage(),
      );
    }
    return _router;
  }

  // Helper method to navigate with parameters
  static void navigateToOtp(BuildContext context, String email) {
    context.pushNamed('otp', extra: {'email': email});
>>>>>>> Stashed changes
  }
}
