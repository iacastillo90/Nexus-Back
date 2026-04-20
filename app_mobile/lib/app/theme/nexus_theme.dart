import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';
import 'app_typography.dart';
import 'app_dimensions.dart';

/// Nexus Cyberpunk Theme
class NexusTheme {
  NexusTheme._();

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,

      // ========== COLOR SCHEME ==========
      colorScheme: const ColorScheme.dark(
        primary: AppColors.nexusBlue,
        secondary: AppColors.cyberPurple,
        tertiary: AppColors.plasmaGreen,
        surface: AppColors.deepSpace,
        surfaceContainerHighest: AppColors.darkMatter,
        surfaceContainerHigh: AppColors.shadowGrey,
        surfaceContainer: AppColors.carbonFiber,
        error: AppColors.errorFlare,
        onPrimary: AppColors.voidBlack,
        onSecondary: AppColors.voidBlack,
        onSurface: AppColors.textPrimary,
        onError: AppColors.voidBlack,
      ),

      // ========== SCAFFOLD ==========
      scaffoldBackgroundColor: AppColors.voidBlack,

      // ========== APP BAR ==========
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.voidBlack,
        elevation: AppDimensions.appBarElevation,
        centerTitle: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
        titleTextStyle: TextStyle(
          fontFamily: 'Rajdhani',
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
        iconTheme: IconThemeData(
          color: AppColors.textPrimary,
          size: AppDimensions.iconMedium,
        ),
      ),

      // ========== CARD ==========
      cardTheme: CardThemeData(
        color: AppColors.darkMatter,
        elevation: AppDimensions.cardElevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        ),
        margin: const EdgeInsets.all(AppDimensions.space8),
      ),

      // ========== ELEVATED BUTTON ==========
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.nexusBlue,
          foregroundColor: AppColors.voidBlack,
          elevation: 0,
          shadowColor: AppColors.nexusBlue.withValues(alpha: 0.5),
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.space24,
            vertical: AppDimensions.space16,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          ),
          textStyle: AppTypography.labelLarge,
        ),
      ),

      // ========== TEXT BUTTON ==========
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.nexusBlue,
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.space16,
            vertical: AppDimensions.space12,
          ),
          textStyle: AppTypography.labelMedium,
        ),
      ),

      // ========== OUTLINED BUTTON ==========
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.nexusBlue,
          side: const BorderSide(
            color: AppColors.nexusBlue,
            width: 1.5,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.space24,
            vertical: AppDimensions.space16,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          ),
          textStyle: AppTypography.labelLarge,
        ),
      ),

      // ========== INPUT DECORATION ==========
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.shadowGrey,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.space16,
          vertical: AppDimensions.space16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          borderSide: const BorderSide(
            color: AppColors.carbonFiber,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          borderSide: const BorderSide(
            color: AppColors.carbonFiber,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          borderSide: const BorderSide(
            color: AppColors.nexusBlue,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          borderSide: const BorderSide(
            color: AppColors.errorFlare,
            width: 1,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          borderSide: const BorderSide(
            color: AppColors.errorFlare,
            width: 2,
          ),
        ),
        labelStyle: AppTypography.bodyMedium.copyWith(
          color: AppColors.textSecondary,
        ),
        hintStyle: AppTypography.bodyMedium.copyWith(
          color: AppColors.textTertiary,
        ),
        errorStyle: AppTypography.bodySmall.copyWith(
          color: AppColors.errorFlare,
        ),
      ),

      // ========== FLOATING ACTION BUTTON ==========
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.nexusBlue,
        foregroundColor: AppColors.voidBlack,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
        ),
      ),

      // ========== BOTTOM NAVIGATION BAR ==========
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.darkMatter,
        selectedItemColor: AppColors.nexusBlue,
        unselectedItemColor: AppColors.textTertiary,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        selectedLabelStyle: TextStyle(
          fontFamily: 'Inter',
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(
          fontFamily: 'Inter',
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
      ),

      // ========== DIVIDER ==========
      dividerTheme: const DividerThemeData(
        color: AppColors.carbonFiber,
        thickness: 1,
        space: 1,
      ),

      // ========== TYPOGRAPHY ==========
      textTheme: const TextTheme(
        displayLarge: AppTypography.displayLarge,
        displayMedium: AppTypography.displayMedium,
        displaySmall: AppTypography.displaySmall,
        headlineLarge: AppTypography.headlineLarge,
        headlineMedium: AppTypography.headlineMedium,
        headlineSmall: AppTypography.headlineSmall,
        titleLarge: AppTypography.titleLarge,
        titleMedium: AppTypography.titleMedium,
        titleSmall: AppTypography.titleSmall,
        bodyLarge: AppTypography.bodyLarge,
        bodyMedium: AppTypography.bodyMedium,
        bodySmall: AppTypography.bodySmall,
        labelLarge: AppTypography.labelLarge,
        labelMedium: AppTypography.labelMedium,
        labelSmall: AppTypography.labelSmall,
      ).apply(
        bodyColor: AppColors.textPrimary,
        displayColor: AppColors.textPrimary,
      ),
    );
  }
}
