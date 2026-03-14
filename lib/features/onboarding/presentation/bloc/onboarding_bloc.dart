import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/check_onboarding_status.dart';
import '../../domain/usecases/complete_onboarding.dart';
import 'onboarding_event.dart';
import 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final CheckOnboardingStatus checkOnboardingStatus;
  final CompleteOnboarding completeOnboarding;

  OnboardingBloc({
    required this.checkOnboardingStatus,
    required this.completeOnboarding,
  }) : super(const OnboardingInitial()) {
    on<CheckOnboardingStatusEvent>(_onCheckStatus);
    on<OnboardingCompletedEvent>(_onComplete);
  }

  Future<void> _onCheckStatus(
    CheckOnboardingStatusEvent event,
    Emitter<OnboardingState> emit,
  ) async {
    emit(const OnboardingLoading());
    // Give time to show the animated splash screen
    await Future.delayed(const Duration(milliseconds: 2200));
    final completed = await checkOnboardingStatus(NoParams());
    if (completed) {
      emit(const OnboardingCompleted());
    } else {
      emit(const OnboardingNotCompleted());
    }
  }

  Future<void> _onComplete(
    OnboardingCompletedEvent event,
    Emitter<OnboardingState> emit,
  ) async {
    await completeOnboarding(NoParams());
    emit(const OnboardingJustCompleted());
  }
}
