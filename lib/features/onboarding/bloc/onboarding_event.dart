part of 'onboarding_bloc.dart';

abstract class OnboardingEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class OnboardingStarted extends OnboardingEvent {}
class OnboardingPageChanged extends OnboardingEvent {
  final int pageIndex;
  OnboardingPageChanged(this.pageIndex);

  @override
  List<Object?> get props => [pageIndex];
}
class OnboardingCompleted extends OnboardingEvent {}
class OnboardingSkipped extends OnboardingEvent {}