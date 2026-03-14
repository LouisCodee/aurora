import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/theme.dart';
import '../../../onboarding/presentation/bloc/onboarding_bloc.dart';
import '../../../onboarding/presentation/bloc/onboarding_event.dart';
import '../../../onboarding/presentation/bloc/onboarding_state.dart';
import '../../../onboarding/presentation/pages/onboarding_page.dart';

/// Entry-point screen — checks the stored onboarding flag and routes accordingly.
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<OnboardingBloc>()
        ..add(const CheckOnboardingStatusEvent()),
      child: BlocListener<OnboardingBloc, OnboardingState>(
        listener: (context, state) {
          if (state is OnboardingCompleted) {
            // Already registered → go straight to dashboard
            Navigator.pushReplacementNamed(context, '/dashboard');
          } else if (state is OnboardingJustCompleted) {
            Navigator.pushReplacementNamed(context, '/register');
          }
        },
        child: BlocBuilder<OnboardingBloc, OnboardingState>(
          builder: (context, state) {
            if (state is OnboardingNotCompleted) {
              return const OnboardingPage();
            }
            // Show a minimal branded splash while loading
            return Scaffold(
              backgroundColor: AuroraColors.background,
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Animated logo
                    TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0.0, end: 1.0),
                      duration: const Duration(milliseconds: 1200),
                      curve: Curves.easeOutBack,
                      builder: (_, v, child) =>
                          Opacity(
                            opacity: v.clamp(0.0, 1.0), 
                            child: Transform.scale(
                              scale: 0.5 + (0.5 * v),
                              child: child,
                            ),
                          ),
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [
                              AuroraColors.accent.withValues(alpha: 0.25),
                              AuroraColors.accentGlow,
                            ],
                          ),
                          border: Border.all(
                            color: AuroraColors.accent.withValues(alpha: 0.5),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AuroraColors.accent.withValues(alpha: 0.3),
                              blurRadius: 30,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.bolt_rounded,
                          color: AuroraColors.accent,
                          size: 50,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    ShaderMask(
                      shaderCallback: (bounds) =>
                          AuroraGradients.accentButton.createShader(bounds),
                      child: const Text(
                        'AURORA',
                        style: AuroraTextStyles.displayHero,
                      ),
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: 28,
                      height: 28,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation(
                          AuroraColors.accent.withValues(alpha: 0.6),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
