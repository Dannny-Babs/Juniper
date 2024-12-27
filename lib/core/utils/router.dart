import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:juniper/core/constants/not_found_screen.dart';
import 'package:juniper/core/utils/utils.dart';

class AppRouter {
  // Keep track of navigationKey to maintain state
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static late final GoRouter _router;
  static bool _initialized = false;

  static GoRouter createRouter(bool isOnboardingCompleted) {
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
  }
}

// Extension for type-safe route parameters
extension GoRouterStateExtensions on GoRouterState {
  Map<String, dynamic>? get params => extra as Map<String, dynamic>?;
}