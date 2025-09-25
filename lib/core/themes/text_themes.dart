import 'package:flutter/material.dart';

import 'colors.dart';
import 'fonts_manager.dart';

class TextThemes {
  static const TextTheme textTheme = TextTheme(
    // Headlines
    headlineLarge: TextStyle(
      fontSize: FontSizes.s36,
      fontWeight: FontWeights.bold,
      color: AppColors.lightTextPrimary,
      letterSpacing: -0.5,
    ),
    headlineMedium: TextStyle(
      fontSize: FontSizes.s32,
      fontWeight: FontWeights.bold,
      color: AppColors.lightTextPrimary,
      letterSpacing: -0.25,
    ),
    headlineSmall: TextStyle(
      fontSize: FontSizes.s28,
      fontWeight: FontWeights.semiBold,
      color: AppColors.lightTextPrimary,
    ),

    // Titles
    titleLarge: TextStyle(
      fontSize: FontSizes.s24,
      fontWeight: FontWeights.semiBold,
      color: AppColors.lightTextPrimary,
    ),
    titleMedium: TextStyle(
      fontSize: FontSizes.s20,
      fontWeight: FontWeights.semiBold,
      color: AppColors.lightTextPrimary,
    ),
    titleSmall: TextStyle(
      fontSize: FontSizes.s16,
      fontWeight: FontWeights.semiBold,
      color: AppColors.lightTextPrimary,
    ),

    // Body text
    bodyLarge: TextStyle(
      fontSize: FontSizes.s18,
      fontWeight: FontWeights.regular,
      color: AppColors.lightTextPrimary,
    ),
    bodyMedium: TextStyle(
      fontSize: FontSizes.s16,
      fontWeight: FontWeights.regular,
      color: AppColors.lightTextPrimary,
    ),
    bodySmall: TextStyle(
      fontSize: FontSizes.s14,
      fontWeight: FontWeights.regular,
      color: AppColors.lightTextSecondary,
    ),

    // Labels
    labelLarge: TextStyle(
      fontSize: FontSizes.s18,
      fontWeight: FontWeights.medium,
      color: AppColors.lightTextPrimary,
    ),
    labelMedium: TextStyle(
      fontSize: FontSizes.s16,
      fontWeight: FontWeights.medium,
      color: AppColors.lightTextPrimary,
    ),
    labelSmall: TextStyle(
      fontSize: FontSizes.s14,
      fontWeight: FontWeights.medium,
      color: AppColors.lightTextSecondary,
    ),

    // Captions
    displayLarge: TextStyle(
      fontSize: FontSizes.s12,
      fontWeight: FontWeights.regular,
      color: AppColors.lightTextTertiary,
    ),
    displayMedium: TextStyle(
      fontSize: FontSizes.s10,
      fontWeight: FontWeights.regular,
      color: AppColors.lightTextTertiary,
    ),
  );
}

class DarkTextTheme {
  static const TextTheme textTheme = TextTheme(
    // Headlines
    headlineLarge: TextStyle(
      fontSize: FontSizes.s36,
      fontWeight: FontWeights.bold,
      color: AppColors.darkTextPrimary,
      letterSpacing: -0.5,
    ),
    headlineMedium: TextStyle(
      fontSize: FontSizes.s32,
      fontWeight: FontWeights.bold,
      color: AppColors.darkTextPrimary,
      letterSpacing: -0.25,
    ),
    headlineSmall: TextStyle(
      fontSize: FontSizes.s28,
      fontWeight: FontWeights.semiBold,
      color: AppColors.darkTextPrimary,
    ),

    // Titles
    titleLarge: TextStyle(
      fontSize: FontSizes.s24,
      fontWeight: FontWeights.semiBold,
      color: AppColors.darkTextPrimary,
    ),
    titleMedium: TextStyle(
      fontSize: FontSizes.s20,
      fontWeight: FontWeights.semiBold,
      color: AppColors.darkTextPrimary,
    ),
    titleSmall: TextStyle(
      fontSize: FontSizes.s16,
      fontWeight: FontWeights.semiBold,
      color: AppColors.darkTextPrimary,
    ),

    // Body text
    bodyLarge: TextStyle(
      fontSize: FontSizes.s18,
      fontWeight: FontWeights.regular,
      color: AppColors.darkTextPrimary,
    ),
    bodyMedium: TextStyle(
      fontSize: FontSizes.s16,
      fontWeight: FontWeights.regular,
      color: AppColors.darkTextPrimary,
    ),
    bodySmall: TextStyle(
      fontSize: FontSizes.s14,
      fontWeight: FontWeights.regular,
      color: AppColors.darkTextSecondary,
    ),

    // Labels
    labelLarge: TextStyle(
      fontSize: FontSizes.s18,
      fontWeight: FontWeights.medium,
      color: AppColors.darkTextPrimary,
    ),
    labelMedium: TextStyle(
      fontSize: FontSizes.s16,
      fontWeight: FontWeights.medium,
      color: AppColors.darkTextPrimary,
    ),
    labelSmall: TextStyle(
      fontSize: FontSizes.s14,
      fontWeight: FontWeights.medium,
      color: AppColors.darkTextSecondary,
    ),

    // Captions
    displayLarge: TextStyle(
      fontSize: FontSizes.s12,
      fontWeight: FontWeights.regular,
      color: AppColors.darkTextTertiary,
    ),
    displayMedium: TextStyle(
      fontSize: FontSizes.s10,
      fontWeight: FontWeights.regular,
      color: AppColors.darkTextTertiary,
    ),
  );
}
