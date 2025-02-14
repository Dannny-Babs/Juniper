import 'package:flutter/material.dart';
import 'package:juniper/core/utils/utils.dart';
import 'package:juniper/features/chat/presentation/pages/chat_list_screen.dart';
import 'package:juniper/features/portfolio/presentation/pages/portfolio_screen.dart';
import 'package:juniper/features/profile/presentation/pages/profile_screen.dart';
import '../../features/navigation/presentation/bloc/navigation_bloc.dart';
import '../../features/navigation/presentation/widgets/bottom_bar.dart';
import '../constants/not_found_screen.dart';
import '../../features/chat/presentation/pages/chat_room_screen.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();
  static late final GoRouter _router;
  static bool _initialized = false;

  static GoRouter createRouter(bool isOnboardingCompleted) {
    if (!_initialized) {
      _router = GoRouter(
        navigatorKey: _rootNavigatorKey,
        initialLocation: isOnboardingCompleted ? '/home' : '/onboarding',
        redirect: (context, state) {
          final navigationBloc = context.read<NavigationBloc>();
          final navState = navigationBloc.state;

          final isAuthenticated = navState.isAuthenticated;
          final isProfileSetupComplete = navState.isProfileSetupComplete;

          final isAuthRoute = [
            '/login',
            '/register',
            '/forgot-password',
            '/otp'
          ].contains(state.matchedLocation);
          final isOnboardingRoute = state.matchedLocation == '/onboarding';
          final isProfileSetupRoute = state.matchedLocation == '/profile-setup';

          // Store current location for navigation history
          if (!isAuthRoute && !isOnboardingRoute) {
            navigationBloc.add(LocationChanged(state.matchedLocation));
          }

          // Handle authentication redirects
          if (!isAuthenticated && !isAuthRoute && !isOnboardingRoute) {
            return '/login';
          }

          if (isAuthenticated &&
              !isProfileSetupComplete &&
              !isProfileSetupRoute &&
              !isAuthRoute) {
            return '/profile-setup';
          }

          if (isAuthenticated && isAuthRoute) {
            return isProfileSetupComplete ? '/home' : '/profile-setup';
          }

          return null;
        },
        routes: [
          // Auth routes (outside shell)
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
              final email =
                  (state.extra as Map<String, dynamic>?)?['email'] as String? ??
                      'user@example.com';
              return EmailVerificationPage(email: email);
            },
          ),
          GoRoute(
            path: '/profile-setup',
            name: 'profile-setup',
            builder: (context, state) => const ProfileSetupPage(),
          ),
          // Chat room route (outside shell)
          GoRoute(
            path: '/chat/room/:userId',
            name: 'chatRoom',
            parentNavigatorKey: _rootNavigatorKey,
            builder: (context, state) => ChatRoomScreen(
              userId: state.pathParameters['userId'] ?? '',
              userName: state.extra as String? ?? 'User',
              userAvatar: null,
            ),
          ),
          // Shell route for bottom navigation
          ShellRoute(
            navigatorKey: _shellNavigatorKey,
            builder: (context, state, child) {
              // Only show bottom nav if authenticated
              return BlocBuilder<NavigationBloc, NavigationState>(
                builder: (context, navState) {
                  if (!navState.isAuthenticated) {
                    return child;
                  }
                  return ScaffoldWithBottomNavBar(child: child);
                },
              );
            },
            routes: [
              GoRoute(
                path: '/home',
                name: 'home',
                builder: (context, state) => const HomePage(),
              ),
              GoRoute(
                path: '/portfolio',
                name: 'portfolio',
                builder: (context, state) =>
                    const PortfolioScreen(), //PortfolioPage(),
              ),
              GoRoute(
                path: '/chat',
                name: 'chat',
                builder: (context, state) =>
                    const ChatListScreen(), //ChatPage(),
               
              ),
              GoRoute(
                path: '/profile',
                name: 'profile',
                builder: (context, state) =>
                    const ProfileScreen(), //ProfilePage(),
              ),
            ],
          ),
        ],
        errorBuilder: (context, state) => const NotFoundPage(),
      );
      _initialized = true;
    }
    return _router;
  }

  // Helper methods
  static void navigateToOtp(BuildContext context, String email) {
    context.pushNamed('otp', extra: {'email': email});
  }

  static void navigateAfterAuth(BuildContext context, bool isProfileComplete) {
    if (!isProfileComplete) {
      context.go('/profile-setup');
    } else {
      context.go('/home');
    }
  }

  static void skipProfileSetup(BuildContext context) {
    context.read<NavigationBloc>().add(ProfileSetupSkipped());
    context.go('/home');
  }
}
