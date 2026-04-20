import 'package:flutter/material.dart';

/// Nexus Typography System
/// Using Rajdhani for headers and Inter for body text
class AppTypography {
  AppTypography._();

  // Font families (will be configured in pubspec.yaml)
  static const String _rajdhani = 'Rajdhani';
  static const String _inter = 'Inter';

  // ========== DISPLAY STYLES (Large Headers) ==========
  static const displayLarge = TextStyle(
    fontFamily: _rajdhani,
    fontSize: 57,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.25,
    height: 1.12,
  );

  static const displayMedium = TextStyle(
    fontFamily: _rajdhani,
    fontSize: 45,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
    height: 1.16,
  );

  static const displaySmall = TextStyle(
    fontFamily: _rajdhani,
    fontSize: 36,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.22,
  );

  // ========== HEADLINE STYLES ==========
  static const headlineLarge = TextStyle(
    fontFamily: _rajdhani,
    fontSize: 32,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.25,
  );

  static const headlineMedium = TextStyle(
    fontFamily: _rajdhani,
    fontSize: 28,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.29,
  );

  static const headlineSmall = TextStyle(
    fontFamily: _rajdhani,
    fontSize: 24,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.33,
  );

  // ========== TITLE STYLES ==========
  static const titleLarge = TextStyle(
    fontFamily: _inter,
    fontSize: 22,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.27,
  );

  static const titleMedium = TextStyle(
    fontFamily: _inter,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.15,
    height: 1.50,
  );

  static const titleSmall = TextStyle(
    fontFamily: _inter,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
    height: 1.43,
  );

  // ========== BODY STYLES ==========
  static const bodyLarge = TextStyle(
    fontFamily: _inter,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
    height: 1.50,
  );

  static const bodyMedium = TextStyle(
    fontFamily: _inter,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    height: 1.43,
  );

  static const bodySmall = TextStyle(
    fontFamily: _inter,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
    height: 1.33,
  );

  // ========== LABEL STYLES (Buttons, Chips) ==========
  static const labelLarge = TextStyle(
    fontFamily: _inter,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
    height: 1.43,
  );

  static const labelMedium = TextStyle(
    fontFamily: _inter,
    fontSize: 12,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
    height: 1.33,
  );

  static const labelSmall = TextStyle(
    fontFamily: _inter,
    fontSize: 11,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
    height: 1.45,
  );
}
