import 'package:equatable/equatable.dart';

abstract class OnboardingState extends Equatable {
  const OnboardingState();

  @override
  List<Object?> get props => [];
}

/// Initial — deciding what to show
class OnboardingInitial extends OnboardingState {
  const OnboardingInitial();
}

/// Loading while reading SharedPreferences
class OnboardingLoading extends OnboardingState {
  const OnboardingLoading();
}

/// User has never opened the app → show splash/onboarding
class OnboardingNotCompleted extends OnboardingState {
  const OnboardingNotCompleted();
}

/// User has already seen onboarding → route to register/home
class OnboardingCompleted extends OnboardingState {
  const OnboardingCompleted();
}

/// Onboarding just finished (user tapped "Get Started") → navigate to register
class OnboardingJustCompleted extends OnboardingState {
  const OnboardingJustCompleted();
}
