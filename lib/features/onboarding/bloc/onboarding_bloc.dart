import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/utils/utils.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

// BLoC
class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final SharedPreferences prefs;
  // ignore: constant_identifier_names
  static const String ONBOARDING_COMPLETE_KEY = 'onboarding_complete';

  OnboardingBloc({required this.prefs}) : super(const OnboardingState()) {
    on<OnboardingStarted>(_onStarted);
    on<OnboardingPageChanged>(_onPageChanged);
    on<OnboardingCompleted>(_onCompleted);
    on<OnboardingSkipped>(_onSkipped);
  }

  Future<void> _onStarted(
    OnboardingStarted event,
    Emitter<OnboardingState> emit,
  ) async {
    try {
      final hasCompleted = prefs.getBool(ONBOARDING_COMPLETE_KEY) ?? false;
      emit(state.copyWith(isCompleted: hasCompleted));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  Future<void> _onPageChanged(
    OnboardingPageChanged event,
    Emitter<OnboardingState> emit,
  ) async {
    emit(state.copyWith(currentPage: event.pageIndex));
  }

  Future<void> _onCompleted(
    OnboardingCompleted event,
    Emitter<OnboardingState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));
      await prefs.setBool(ONBOARDING_COMPLETE_KEY, true);
      emit(state.copyWith(isCompleted: true, isLoading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }

  Future<void> _onSkipped(
    OnboardingSkipped event,
    Emitter<OnboardingState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));
      await prefs.setBool(ONBOARDING_COMPLETE_KEY, true);
      emit(state.copyWith(isCompleted: true, isLoading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }
}
