import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppGradients {
  AppGradients._();

  // Main Motiva brand gradient
  static const LinearGradient primary = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.primary, AppColors.primaryLight],
  );

  // Subtle application background
  static const LinearGradient background = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.background, AppColors.backgroundElevated],
  );

  // Calm / breathing / relaxation
  static const LinearGradient calm = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF176E75), Color(0xFF27A6A0)],
  );

  // Wellness / grounding
  static const LinearGradient wellness = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF165D6B), Color(0xFF48B7A7)],
  );

  // Very subtle highlight used on cards
  static const LinearGradient cardHighlight = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0x18FFFFFF), Color(0x00FFFFFF)],
  );
}
