part of 'navigation_bloc.dart';

class NavigationState extends Equatable {
  final bool isAuthenticated;
  final bool isProfileSetupComplete;
  final int currentIndex;
  final List<String> navigationHistory;
  final bool isOnboardingCompleted;
  final bool hasSkippedProfileSetup;
  final bool isTabLoading;
  final String? error; // New error field

  const NavigationState({
    this.isAuthenticated = false,
    this.isProfileSetupComplete = false,
    this.currentIndex = 0,
    this.navigationHistory = const [],
    this.isOnboardingCompleted = false,
    this.hasSkippedProfileSetup = false,
    this.isTabLoading = false,
    this.error,
  });

  // Factory constructor to create initial state from SharedPreferences
  factory NavigationState.initial(SharedPreferences prefs) {
    return NavigationState(
      isAuthenticated: prefs.getBool('isAuthenticated') ?? false,
      isProfileSetupComplete: prefs.getBool('isProfileSetupComplete') ?? false,
      currentIndex: prefs.getInt('currentTabIndex') ?? 0,
      isOnboardingCompleted: prefs.getBool('isOnboardingCompleted') ?? false,
      hasSkippedProfileSetup: prefs.getBool('hasSkippedProfileSetup') ?? false,
      navigationHistory: prefs.getStringList('navigation_history') ?? [],
    );
  }

  NavigationState copyWith({
    bool? isAuthenticated,
    bool? isProfileSetupComplete,
    int? currentIndex,
    List<String>? navigationHistory,
    bool? isOnboardingCompleted,
    bool? hasSkippedProfileSetup,
    bool? isTabLoading,
    String? error,
  }) {
    return NavigationState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isProfileSetupComplete:
          isProfileSetupComplete ?? this.isProfileSetupComplete,
      currentIndex: currentIndex ?? this.currentIndex,
      navigationHistory: navigationHistory ?? this.navigationHistory,
      isOnboardingCompleted:
          isOnboardingCompleted ?? this.isOnboardingCompleted,
      hasSkippedProfileSetup:
          hasSkippedProfileSetup ?? this.hasSkippedProfileSetup,
      isTabLoading: isTabLoading ?? this.isTabLoading,
      error: error, // Note: Passing null here will clear the error
    );
  }

  @override
  List<Object?> get props => [
        isAuthenticated,
        isProfileSetupComplete,
        currentIndex,
        navigationHistory,
        isOnboardingCompleted,
        hasSkippedProfileSetup,
        isTabLoading,
        error,
      ];
}
