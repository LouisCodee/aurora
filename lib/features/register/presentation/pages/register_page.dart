import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/theme.dart';
import '../../../../widgets/shared_widgets.dart';
import '../bloc/register_bloc.dart';
import '../bloc/register_event.dart';
import '../bloc/register_state.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<RegisterBloc>(),
      child: const _RegisterView(),
    );
  }
}

class _RegisterView extends StatefulWidget {
  const _RegisterView();

  @override
  State<_RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<_RegisterView>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();

  late AnimationController _animController;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    )..forward();
    _fade = CurvedAnimation(parent: _animController, curve: Curves.easeOut);
  }

  @override
  void dispose() {
    _animController.dispose();
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    super.dispose();
  }

  void _submit(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<RegisterBloc>().add(
            SubmitRegistrationEvent(
              name: _nameCtrl.text,
              email: _emailCtrl.text,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (ctx, state) {
        if (state is RegisterSuccess) {
          Navigator.pushReplacementNamed(ctx, '/dashboard');
        } else if (state is RegisterError) {
          ScaffoldMessenger.of(ctx).showSnackBar(
            SnackBar(
              backgroundColor: AuroraColors.purple.withValues(alpha: 0.9),
              content: Text(state.message),
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: AuroraColors.background,
        body: Stack(
          children: [
            // ── Background glows ────────────────────────────────────
            Positioned(
              top: -60,
              right: -60,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(colors: [
                    AuroraColors.accent.withValues(alpha: 0.1),
                    Colors.transparent,
                  ]),
                ),
              ),
            ),
            Positioned(
              bottom: 80,
              left: -80,
              child: Container(
                width: 260,
                height: 260,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(colors: [
                    AuroraColors.purple.withValues(alpha: 0.1),
                    Colors.transparent,
                  ]),
                ),
              ),
            ),

            // ── Form ────────────────────────────────────────────────
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: FadeTransition(
                  opacity: _fade,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 32),

                        // ── Header ──────────────────────────────────
                        Center(
                          child: Column(
                            children: [
                              // Logo
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: RadialGradient(colors: [
                                    AuroraColors.accent.withValues(alpha: 0.25),
                                    AuroraColors.accentGlow,
                                  ]),
                                  border: Border.all(
                                    color:
                                        AuroraColors.accent.withValues(alpha: 0.5),
                                    width: 1.5,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AuroraColors.accent
                                          .withValues(alpha: 0.25),
                                      blurRadius: 28,
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.bolt_rounded,
                                  color: AuroraColors.accent,
                                  size: 38,
                                ),
                              ),

                              const SizedBox(height: 20),

                              ShaderMask(
                                shaderCallback: (bounds) =>
                                    AuroraGradients.accentButton
                                        .createShader(bounds),
                                child: const Text(
                                  'Create Your Account',
                                  style: TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),

                              const SizedBox(height: 8),

                              const Text(
                                'Your data stays on this device —\nno server, no tracking.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AuroraColors.textSecondary,
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 44),

                        // ── Fields ───────────────────────────────────
                        _FormLabel(text: 'FULL NAME'),
                        const SizedBox(height: 8),
                        _AuroraFormField(
                          controller: _nameCtrl,
                          hint: 'Enter your full name',
                          prefixIcon: Icons.person_outline_rounded,
                          validator: (v) {
                            if (v == null || v.trim().isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 20),

                        _FormLabel(text: 'EMAIL ADDRESS'),
                        const SizedBox(height: 8),
                        _AuroraFormField(
                          controller: _emailCtrl,
                          hint: 'Enter your email',
                          prefixIcon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                          validator: (v) {
                            if (v == null || v.trim().isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 40),

                        // ── Submit ───────────────────────────────────
                        BlocBuilder<RegisterBloc, RegisterState>(
                          builder: (ctx, state) {
                            if (state is RegisterLoading) {
                              return Center(
                                child: SizedBox(
                                  width: 28,
                                  height: 28,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation(
                                      AuroraColors.accent,
                                    ),
                                  ),
                                ),
                              );
                            }
                            return AuroraButton(
                              text: 'Continue to Aurora',
                              onPressed: () => _submit(ctx),
                              icon: Icons.arrow_forward_rounded,
                            );
                          },
                        ),

                        const SizedBox(height: 24),

                        // ── Privacy note ─────────────────────────────
                        Center(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                              color: AuroraColors.accentGlow,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: AuroraColors.accent.withValues(alpha: 0.2),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(
                                  Icons.lock_outline_rounded,
                                  color: AuroraColors.accent,
                                  size: 16,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Stored locally · Never shared',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AuroraColors.textSecondary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Helper widgets ───────────────────────────────────────────────────────────

class _FormLabel extends StatelessWidget {
  final String text;
  const _FormLabel({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        color: AuroraColors.accent,
        letterSpacing: 1.5,
      ),
    );
  }
}

class _AuroraFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData prefixIcon;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  const _AuroraFormField({
    required this.controller,
    required this.hint,
    required this.prefixIcon,
    this.keyboardType,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      style: const TextStyle(color: Colors.white, fontSize: 15),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: AuroraColors.textDim, fontSize: 15),
        prefixIcon: Icon(prefixIcon, color: AuroraColors.textDim, size: 20),
        filled: true,
        fillColor: AuroraColors.surfaceLight,
        errorStyle: const TextStyle(color: Color(0xFFFF6B8A)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: AuroraColors.divider,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: AuroraColors.accent.withValues(alpha: 0.6),
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: Color(0xFFFF6B8A),
            width: 1,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: Color(0xFFFF6B8A),
            width: 1.5,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
      ),
    );
  }
}
