part of 'navigation_bloc.dart';

class NavigationState extends Equatable {
  final bool isAuthenticated;
  final bool isProfileSetupComplete; // Add this
  final int currentIndex;
  final List<String> navigationHistory;
  final bool isOnboardingCompleted;
  final bool hasSkippedProfileSetup;

  const NavigationState({
    this.isAuthenticated = false,
    this.isProfileSetupComplete = false, // Add this
    this.currentIndex = 0,
    this.navigationHistory = const [],
    this.isOnboardingCompleted = false,
    this.hasSkippedProfileSetup = false,
  });

  NavigationState copyWith({
    bool? isAuthenticated,
    bool? isProfileSetupComplete, // Add this
    int? currentIndex,
    List<String>? navigationHistory,
    bool? isOnboardingCompleted,
    bool? hasSkippedProfileSetup,
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
      ];
}
