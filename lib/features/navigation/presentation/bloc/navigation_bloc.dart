import 'package:flutter/foundation.dart';

import '../../../../core/utils/utils.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  final SharedPreferences prefs;

  NavigationBloc(this.prefs)
      : super(NavigationState(
          isAuthenticated: prefs.getBool('isAuthenticated') ?? false,
          isProfileSetupComplete:
              prefs.getBool('isProfileSetupComplete') ?? false,
          currentIndex: prefs.getInt('currentTabIndex') ?? 0,
          isOnboardingCompleted:
              prefs.getBool('isOnboardingCompleted') ?? false,
          hasSkippedProfileSetup: prefs.getBool('hasSkippedProfileSetup') ?? false,
        )) {
    on<TabChanged>(_onTabChanged);
    on<AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    on<ProfileSetupCompleted>(_onProfileSetupCompleted);
    on<LocationChanged>(_onLocationChanged);
    on<ProfileSetupSkipped>(_onProfileSetupSkipped);
  }

  void _onTabChanged(TabChanged event, Emitter<NavigationState> emit) {
    prefs.setInt('currentTabIndex', event.index);
    emit(state.copyWith(currentIndex: event.index));
  }

  void _onAuthenticationStatusChanged(
      AuthenticationStatusChanged event, Emitter<NavigationState> emit) {
    prefs.setBool('isAuthenticated', event.isAuthenticated);
    if (kDebugMode) {
      print('isAuthenticated: ${event.isAuthenticated}');
    }
    emit(state.copyWith(isAuthenticated: event.isAuthenticated));
  }

  void _onLocationChanged(
      LocationChanged event, Emitter<NavigationState> emit) {
    final newHistory = List<String>.from(state.navigationHistory)
      ..add(event.location);
    if (newHistory.length > 10) newHistory.removeAt(0);
    emit(state.copyWith(navigationHistory: newHistory));
  }

  void _onProfileSetupCompleted(
      ProfileSetupCompleted event, Emitter<NavigationState> emit) {
    prefs.setBool('isProfileSetupComplete', true);
    emit(state.copyWith(isProfileSetupComplete: true));
  }

  void _onProfileSetupSkipped(ProfileSetupSkipped event, Emitter<NavigationState> emit) {
    prefs.setBool('hasSkippedProfileSetup', true);
    emit(state.copyWith(hasSkippedProfileSetup: true));
  }
}
