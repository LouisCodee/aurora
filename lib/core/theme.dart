import 'package:flutter/material.dart';

class AuroraColors {
  static const Color background = Color(0xFF050A18);
  static const Color surface = Color(0xFF0D1B2A);
  static const Color surfaceLight = Color(0xFF132236);
  static const Color cardDark = Color(0xFF0A1628);
  static const Color accent = Color(0xFF00F2FF);
  static const Color accentDim = Color(0x4400F2FF);
  static const Color accentGlow = Color(0x2200F2FF);
  static const Color purple = Color(0xFF8B5CF6);
  static const Color pink = Color(0xFFEC4899);
  static const Color green = Color(0xFF10B981);
  static const Color orange = Color(0xFFF59E0B);
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xFF8BA3BF);
  static const Color textDim = Color(0xFF4A6080);
  static const Color divider = Color(0xFF1A2D45);
  static const Color navBar = Color(0xFF0A1628);
}

class AuroraGradients {
  static const LinearGradient background = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF050A18), Color(0xFF0A1525), Color(0xFF060D1C)],
  );

  static const LinearGradient accentButton = LinearGradient(
    colors: [Color(0xFF00F2FF), Color(0xFF009EFF)],
  );

  static const LinearGradient card = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF0F2035), Color(0xFF091525)],
  );

  static const LinearGradient purpleCard = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1E0A3C), Color(0xFF0D1225)],
  );
}

class AuroraTextStyles {
  static const TextStyle displayHero = TextStyle(
    fontSize: 48,
    fontWeight: FontWeight.w900,
    color: Colors.white,
    letterSpacing: 4,
    height: 1.1,
  );

  static const TextStyle heading1 = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    letterSpacing: 0.5,
  );

  static const TextStyle heading2 = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  static const TextStyle heading3 = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static const TextStyle body = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: Color(0xFF8BA3BF),
    height: 1.5,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 13,
    color: Color(0xFF8BA3BF),
  );

  static const TextStyle accent = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Color(0xFF00F2FF),
    letterSpacing: 1,
  );

  static const TextStyle label = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: Color(0xFF8BA3BF),
    letterSpacing: 0.5,
  );
}

class AuroraDecorations {
  static BoxDecoration glowCard({double radius = 20}) => BoxDecoration(
        gradient: AuroraGradients.card,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(
          color: AuroraColors.accent.withOpacity(0.15),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AuroraColors.accent.withOpacity(0.05),
            blurRadius: 20,
            spreadRadius: 0,
          ),
        ],
      );

  static BoxDecoration accentCard({double radius = 20}) => BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF003D45), Color(0xFF001A20)],
        ),
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(
          color: AuroraColors.accent.withOpacity(0.3),
          width: 1,
        ),
      );

  static BoxDecoration navBarDecoration = BoxDecoration(
    color: AuroraColors.navBar,
    borderRadius: BorderRadius.circular(30),
    border: Border.all(
      color: AuroraColors.accent.withOpacity(0.2),
      width: 1,
    ),
    boxShadow: [
      BoxShadow(
        color: AuroraColors.accent.withOpacity(0.08),
        blurRadius: 30,
        spreadRadius: 0,
        offset: const Offset(0, -5),
      ),
    ],
  );
}
