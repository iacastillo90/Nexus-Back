import 'package:flutter/material.dart';

/// Nexus Cyberpunk Color Palette
/// All colors are optimized for OLED displays and dark mode
class AppColors {
  AppColors._(); // Private constructor

  // ========== BASE COLORS (Backgrounds) ==========
  static const voidBlack = Color(0xFF000000); // OLED Black
  static const deepSpace = Color(0xFF0A0A0F); // Surface 1
  static const darkMatter = Color(0xFF141419); // Surface 2
  static const shadowGrey = Color(0xFF1E1E24); // Surface 3
  static const carbonFiber = Color(0xFF2A2A30); // Surface 4

  // ========== NEON ACCENTS (Primary Actions) ==========
  static const nexusBlue = Color(0xFF00D9FF); // Cyan eléctrico
  static const cyberPurple = Color(0xFF9D4EDD); // Púrpura neón
  static const plasmaGreen = Color(0xFF39FF14); // Verde radioactivo
  static const holoRose = Color(0xFFFF006E); // Rosa holográfico
  static const neonPink = holoRose; // Alias for backward compatibility
  static const electricYellow = Color(0xFFFFFF00); // Amarillo eléctrico

  // ========== KARMA TIER COLORS ==========
  static const karmaVerified = Color(0xFF00FF85); // Verde neón
  static const karmaEstablished = Color(0xFFFFB800); // Oro
  static const karmaNewcomer = Color(0xFFFF6B35); // Naranja
  static const karmaSuspicious = Color(0xFFFF0040); // Rojo crítico

  // Gradiente para Diamond Tier
  static const karmaDiamondGradient = LinearGradient(
    colors: [nexusBlue, cyberPurple, holoRose, nexusBlue],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // ========== SEMANTIC COLORS ==========
  static const successGlow = plasmaGreen;
  static const warningPulse = Color(0xFFFFB800);
  static const errorFlare = Color(0xFFFF0040);
  static const infoBeam = nexusBlue;

  // ========== TEXT COLORS ==========
  static const textPrimary = Color(0xFFFFFFFF); // Pure white
  static const textSecondary = Color(0xFFB0B0B8); // Light grey
  static const textTertiary = Color(0xFF6B6B73); // Medium grey
  static const textDisabled = Color(0xFF404047); // Dark grey
  static const textLink = nexusBlue;

  // ========== GLASS EFFECTS (Frosted glass) ==========
  static const glassLight = Color(0x1AFFFFFF); // 10% white
  static const glassMedium = Color(0x33FFFFFF); // 20% white
  static const glassDark = Color(0x0DFFFFFF); // 5% white

  // ========== OVERLAYS ==========
  static const scrimLight = Color(0x40000000); // 25% black
  static const scrimMedium = Color(0x80000000); // 50% black
  static const scrimDark = Color(0xCC000000); // 80% black

  // ========== SENTIMENT COLORS (Emociones) ==========
  static const sentimentJoy = Color(0xFFFFD700); // Dorado
  static const sentimentSadness = Color(0xFF4A90E2); // Azul triste
  static const sentimentAnger = Color(0xFFFF4444); // Rojo
  static const sentimentFear = Color(0xFF9B59B6); // Púrpura oscuro
  static const sentimentSurprise = Color(0xFFFF9500); // Naranja brillante

  // ========== SHADOWS & GLOWS ==========
  static final neonGlow = [
    BoxShadow(
      color: nexusBlue.withValues(alpha: 0.5),
      blurRadius: 20,
      spreadRadius: 2,
    ),
  ];

  static final purpleGlow = [
    BoxShadow(
      color: cyberPurple.withValues(alpha: 0.4),
      blurRadius: 16,
      spreadRadius: 1,
    ),
  ];

  static final cardShadow = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.3),
      blurRadius: 10,
      offset: const Offset(0, 4),
    ),
  ];

  static final floatingActionShadow = [
    BoxShadow(
      color: nexusBlue.withValues(alpha: 0.6),
      blurRadius: 24,
      spreadRadius: 4,
    ),
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.2),
      blurRadius: 8,
      offset: const Offset(0, 4),
    ),
  ];
}
