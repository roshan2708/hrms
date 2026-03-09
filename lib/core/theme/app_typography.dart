import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTypography {
  AppTypography._();

  static double _scale(BuildContext context, double baseSize) {
    double screenWidth = MediaQuery.of(context).size.width;
    double scaleFactor = screenWidth / 375;
    if (scaleFactor > 1.5) scaleFactor = 1.5;
    if (scaleFactor < 0.8) scaleFactor = 0.8;
    return baseSize * scaleFactor;
  }

  static TextStyle heading(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return TextStyle(
      fontSize: _scale(context, 32),
      fontWeight: FontWeight.bold,
      color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
    );
  }

  static TextStyle title(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return TextStyle(
      fontSize: _scale(context, 24),
      fontWeight: FontWeight.w600,
      color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
    );
  }

  static TextStyle subtitle(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return TextStyle(
      fontSize: _scale(context, 18),
      fontWeight: FontWeight.w500,
      color: isDark
          ? AppColors.darkTextSecondary
          : AppColors.lightTextSecondary,
    );
  }

  static TextStyle body(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return TextStyle(
      fontSize: _scale(context, 14),
      fontWeight: FontWeight.normal,
      color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
    );
  }

  static TextStyle caption(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return TextStyle(
      fontSize: _scale(context, 12),
      fontWeight: FontWeight.normal,
      color: isDark
          ? AppColors.darkTextSecondary
          : AppColors.lightTextSecondary,
    );
  }

  static TextStyle button(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return TextStyle(
      fontSize: _scale(context, 16),
      fontWeight: FontWeight.bold,
      color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
    );
  }
}
