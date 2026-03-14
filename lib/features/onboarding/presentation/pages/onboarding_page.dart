import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme.dart';
import '../../../../widgets/shared_widgets.dart';
import '../bloc/onboarding_bloc.dart';
import '../bloc/onboarding_event.dart';
import '../bloc/onboarding_state.dart';

/// The splash/welcome screen shown only the very first time the app is opened.
class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _fadeController;
  late Animation<double> _pulse;
  late Animation<double> _fade;
  late Animation<Offset> _slideUp;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..forward();

    _pulse = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
    _fade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOut),
    );
    _slideUp = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  void _onGetStarted(BuildContext context) {
    context.read<OnboardingBloc>().add(const OnboardingCompletedEvent());
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocListener<OnboardingBloc, OnboardingState>(
      listener: (ctx, state) {
        if (state is OnboardingJustCompleted) {
          Navigator.pushReplacementNamed(ctx, '/register');
        }
      },
      child: Scaffold(
        backgroundColor: AuroraColors.background,
        body: Stack(
          children: [
            // ── Background glow orbs ──────────────────────────────────
            Positioned(
              top: -80,
              right: -80,
              child: AnimatedBuilder(
                animation: _pulse,
                builder: (_, child) =>
                    Transform.scale(scale: _pulse.value, child: child),
                child: Container(
                  width: 350,
                  height: 350,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        AuroraColors.accent.withValues(alpha: 0.15),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: size.height * 0.25,
              left: -60,
              child: AnimatedBuilder(
                animation: _pulse,
                builder: (_, child) => Transform.scale(
                    scale: 2.0 - _pulse.value, child: child),
                child: Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        AuroraColors.purple.withValues(alpha: 0.12),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // ── Main content ─────────────────────────────────────────
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Column(
                  children: [
                    // Top badge row
                    FadeTransition(
                      opacity: _fade,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 6),
                              decoration: BoxDecoration(
                                color: AuroraColors.accentGlow,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color:
                                      AuroraColors.accent.withValues(alpha: 0.3),
                                ),
                              ),
                              child: const Text(
                                'VERSION 2.0',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: AuroraColors.accent,
                                  letterSpacing: 1.5,
                                ),
                              ),
                            ),
                            const Text(
                              'PRO EVOLUTION',
                              style: TextStyle(
                                fontSize: 10,
                                color: AuroraColors.textDim,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const Spacer(flex: 2),

                    // Logo + text
                    SlideTransition(
                      position: _slideUp,
                      child: FadeTransition(
                        opacity: _fade,
                        child: Column(
                          children: [
                            // Pulsing logo
                            AnimatedBuilder(
                              animation: _pulse,
                              builder: (context, child) => Stack(
                                children: [
                                  Container(
                                    width: 200 * _pulse.value,
                                    height: 200 * _pulse.value,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: AuroraColors.accent
                                            .withValues(alpha: 0.1),
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 150,
                                    height: 150,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: AuroraColors.accent
                                            .withValues(alpha: 0.2),
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 110,
                                    height: 110,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: RadialGradient(colors: [
                                        AuroraColors.accent
                                            .withValues(alpha: 0.25),
                                        AuroraColors.accentGlow,
                                      ]),
                                      border: Border.all(
                                        color: AuroraColors.accent
                                            .withValues(alpha: 0.5),
                                        width: 1.5,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AuroraColors.accent
                                              .withValues(alpha: 0.3),
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
                                ],
                              ),
                            ),

                            const SizedBox(height: 48),

                            ShaderMask(
                              shaderCallback: (bounds) =>
                                  AuroraGradients.accentButton
                                      .createShader(bounds),
                              child: const Text(
                                'AURORA',
                                style: AuroraTextStyles.displayHero,
                              ),
                            ),

                            const SizedBox(height: 16),

                            const Text(
                              'Master Your Time',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: 0.5,
                              ),
                            ),

                            const SizedBox(height: 16),

                            const Text(
                              'The future of productivity is here.\nExperience seamless task management.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                color: AuroraColors.textSecondary,
                                height: 1.6,
                              ),
                            ),

                            const SizedBox(height: 32),

                            // Stats row
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _buildStatChip('10K+', 'Tasks Done'),
                                const SizedBox(width: 24),
                                Container(
                                    width: 1,
                                    height: 30,
                                    color: AuroraColors.divider),
                                const SizedBox(width: 24),
                                _buildStatChip('99%', 'Uptime'),
                                const SizedBox(width: 24),
                                Container(
                                    width: 1,
                                    height: 30,
                                    color: AuroraColors.divider),
                                const SizedBox(width: 24),
                                _buildStatChip('4.9★', 'Rating'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    const Spacer(flex: 3),

                    // CTA buttons
                    SlideTransition(
                      position: _slideUp,
                      child: FadeTransition(
                        opacity: _fade,
                        child: Column(
                          children: [
                            AuroraButton(
                              text: 'Get Started',
                              onPressed: () => _onGetStarted(context),
                              icon: Icons.arrow_forward_rounded,
                            ),
                            const SizedBox(height: 30),
                            const Text(
                              'By continuing, you agree to our Terms of Service',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                color: AuroraColors.textDim,
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatChip(String value, String label) {
    return Column(
      children: [
        ShaderMask(
          shaderCallback: (bounds) =>
              AuroraGradients.accentButton.createShader(bounds),
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: AuroraColors.textDim),
        ),
      ],
    );
  }
}
