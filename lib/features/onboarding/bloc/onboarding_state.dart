part of 'onboarding_bloc.dart';

class OnboardingState extends Equatable {
  final int currentPage;
  final bool isCompleted;
  final bool isLoading;
  final String? error;

  const OnboardingState({
    this.currentPage = 0,
    this.isCompleted = false,
    this.isLoading = false,
    this.error,
  });

  OnboardingState copyWith({
    int? currentPage,
    bool? isCompleted,
    bool? isLoading,
    String? error,
  }) {
    return OnboardingState(
      currentPage: currentPage ?? this.currentPage,
      isCompleted: isCompleted ?? this.isCompleted,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [currentPage, isCompleted, isLoading, error];
}
