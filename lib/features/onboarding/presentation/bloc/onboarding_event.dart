import 'package:equatable/equatable.dart';

abstract class OnboardingEvent extends Equatable {
  const OnboardingEvent();

  @override
  List<Object?> get props => [];
}

/// Fired at app startup to check if onboarding has been seen before
class CheckOnboardingStatusEvent extends OnboardingEvent {
  const CheckOnboardingStatusEvent();
}

/// Fired when the user taps "Get Started" on the onboarding screen
class OnboardingCompletedEvent extends OnboardingEvent {
  const OnboardingCompletedEvent();
}
