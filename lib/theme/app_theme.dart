import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_radius.dart';
import 'motiva_typography.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,

      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.primary,
        onPrimary: Colors.white,
        secondary: AppColors.primaryLight,
        onSecondary: Colors.white,
        error: AppColors.danger,
        onError: Colors.white,
        surface: AppColors.surface,
        onSurface: AppColors.textPrimary,
      ),

      scaffoldBackgroundColor: AppColors.background,

      fontFamily: MotivaTypography.fontFamily,

      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        foregroundColor: AppColors.textPrimary,
        titleTextStyle: MotivaTypography.h2.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w700,
        ),
      ),

      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: AppRadius.mediumBorder),
      ),

      textTheme: TextTheme(
        headlineLarge: MotivaTypography.h1.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.bold,
        ),

        headlineMedium: MotivaTypography.h2.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w700,
        ),

        headlineSmall: MotivaTypography.h3.copyWith(
          color: AppColors.textPrimary,
        ),

        bodyLarge: MotivaTypography.body.copyWith(color: AppColors.textPrimary),

        bodyMedium: MotivaTypography.bodySmall.copyWith(
          color: AppColors.textSecondary,
        ),

        bodySmall: MotivaTypography.caption.copyWith(
          color: AppColors.textMuted,
        ),

        labelLarge: MotivaTypography.button.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: AppRadius.smallBorder),
        ),
      ),

      dividerColor: AppColors.border,

      splashColor: AppColors.primary.withValues(alpha: 0.08),

      highlightColor: Colors.transparent,
    );
  }
}
