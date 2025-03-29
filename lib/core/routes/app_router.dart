import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/chat/presentation/pages/chat_room_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/chat/:userId',
      builder: (context, state) {
        final userId = state.pathParameters['userId'] ?? '';
        final userName = state.uri.queryParameters['userName'] ?? '';
        final userAvatar = state.uri.queryParameters['userAvatar'];

        return ChatRoomScreen(
          userId: userId,
          userName: userName,
          userAvatar: userAvatar,
        );
      },
    ),
    // Add other routes here
  ],
);
