import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_radius.dart';
import 'motiva_typography.dart';

class AppTheme {
  AppTheme._();

  // ─────────────────────────────────────────────
  // DARK THEME
  // ─────────────────────────────────────────────

  static ThemeData get dark {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,

      // ─────────────────────────────────────────
      // COLOR SCHEME
      // ─────────────────────────────────────────
      colorScheme: const ColorScheme(
        brightness: Brightness.dark,

        primary: AppColors.primary,
        onPrimary: Colors.white,

        secondary: AppColors.primaryLight,
        onSecondary: Colors.white,

        error: AppColors.danger,
        onError: Colors.white,

        surface: AppColors.surface,
        onSurface: AppColors.textPrimary,
      ),

      // ─────────────────────────────────────────
      // APP BACKGROUND
      // ─────────────────────────────────────────
      scaffoldBackgroundColor: AppColors.background,

      // ─────────────────────────────────────────
      // TYPOGRAPHY
      // ─────────────────────────────────────────
      fontFamily: MotivaTypography.fontFamily,

      textTheme: TextTheme(
        headlineLarge: MotivaTypography.h1.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w700,
        ),

        headlineMedium: MotivaTypography.h2.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w700,
        ),

        headlineSmall: MotivaTypography.h3.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w600,
        ),

        bodyLarge: MotivaTypography.body.copyWith(color: AppColors.textPrimary),

        bodyMedium: MotivaTypography.bodySmall.copyWith(
          color: AppColors.textSecondary,
        ),

        bodySmall: MotivaTypography.caption.copyWith(
          color: AppColors.textMuted,
        ),

        labelLarge: MotivaTypography.button.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w600,
        ),
      ),

      // ─────────────────────────────────────────
      // APP BAR
      // ─────────────────────────────────────────
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

      // ─────────────────────────────────────────
      // CARDS
      // ─────────────────────────────────────────
      cardTheme: CardThemeData(
        color: AppColors.surface,

        elevation: 0,

        margin: EdgeInsets.zero,

        shape: RoundedRectangleBorder(borderRadius: AppRadius.mediumBorder),

        shadowColor: AppColors.cardShadow,
      ),

      // ─────────────────────────────────────────
      // ELEVATED BUTTON
      // ─────────────────────────────────────────
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,

          elevation: 0,

          minimumSize: const Size(0, 52),

          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),

          shape: RoundedRectangleBorder(borderRadius: AppRadius.smallBorder),

          textStyle: MotivaTypography.button,
        ),
      ),

      // ─────────────────────────────────────────
      // TEXT BUTTON
      // ─────────────────────────────────────────
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primaryLight,

          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),

          textStyle: MotivaTypography.button,
        ),
      ),

      // ─────────────────────────────────────────
      // OUTLINED BUTTON
      // ─────────────────────────────────────────
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.textPrimary,

          side: const BorderSide(color: AppColors.border),

          minimumSize: const Size(0, 52),

          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),

          shape: RoundedRectangleBorder(borderRadius: AppRadius.smallBorder),

          textStyle: MotivaTypography.button,
        ),
      ),

      // ─────────────────────────────────────────
      // DIVIDERS
      // ─────────────────────────────────────────
      dividerTheme: const DividerThemeData(
        color: AppColors.border,
        thickness: 1,
        space: 1,
      ),

      // ─────────────────────────────────────────
      // ICONS
      // ─────────────────────────────────────────
      iconTheme: const IconThemeData(color: AppColors.textSecondary, size: 24),

      // ─────────────────────────────────────────
      // INPUT FIELDS
      // ─────────────────────────────────────────
      inputDecorationTheme: InputDecorationTheme(
        filled: true,

        fillColor: AppColors.surface,

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),

        border: OutlineInputBorder(
          borderRadius: AppRadius.mediumBorder,
          borderSide: const BorderSide(color: AppColors.border),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadius.mediumBorder,
          borderSide: const BorderSide(color: AppColors.border),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadius.mediumBorder,
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: AppRadius.mediumBorder,
          borderSide: const BorderSide(color: AppColors.danger),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: AppRadius.mediumBorder,
          borderSide: const BorderSide(color: AppColors.danger, width: 1.5),
        ),

        hintStyle: MotivaTypography.body.copyWith(color: AppColors.textMuted),

        labelStyle: MotivaTypography.body.copyWith(
          color: AppColors.textSecondary,
        ),
      ),

      // ─────────────────────────────────────────
      // BOTTOM SHEETS
      // ─────────────────────────────────────────
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        modalElevation: 0,
      ),

      // ─────────────────────────────────────────
      // DIALOGS
      // ─────────────────────────────────────────
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,

        shape: RoundedRectangleBorder(borderRadius: AppRadius.largeBorder),

        shadowColor: AppColors.cardShadow,
      ),

      // ─────────────────────────────────────────
      // INTERACTION
      // ─────────────────────────────────────────
      splashColor: AppColors.primary.withValues(alpha: 0.08),

      highlightColor: Colors.transparent,

      hoverColor: AppColors.primary.withValues(alpha: 0.06),

      focusColor: AppColors.primary.withValues(alpha: 0.08),
    );
  }
}
