import 'package:flutter/material.dart';

import '../themes/colors.dart';
import 'ui_scales.dart';

InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
  filled: false,
  fillColor: AppColors.lightCardBackground,
  contentPadding: const EdgeInsets.symmetric(
    horizontal: UIScales.space16,
    vertical: UIScales.space14,
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(UIScales.formRadius),
    borderSide: const BorderSide(color: AppColors.primaryColor, width: 1.5),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(UIScales.formRadius),
    borderSide: const BorderSide(color: AppColors.lightDivider, width: 1.0),
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(UIScales.formRadius),
    borderSide: const BorderSide(color: AppColors.lightDivider, width: 1.0),
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(UIScales.formRadius),
    borderSide: const BorderSide(color: AppColors.error, width: 1.5),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(UIScales.formRadius),
    borderSide: const BorderSide(color: AppColors.error, width: 1.5),
  ),
  hintStyle: const TextStyle(
    color: AppColors.lightTextSecondary,
    fontSize: 16.0,
  ),
);

InputDecorationTheme darkInputDecoration = InputDecorationTheme(
  filled: false,
  fillColor: AppColors.darkCardBackground,
  contentPadding: const EdgeInsets.symmetric(
    horizontal: UIScales.space16,
    vertical: UIScales.space14,
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(UIScales.formRadius),
    borderSide: const BorderSide(color: AppColors.primaryColor, width: 1.5),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(UIScales.formRadius),
    borderSide: const BorderSide(color: AppColors.darkDivider, width: 1.0),
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(UIScales.formRadius),
    borderSide: const BorderSide(color: AppColors.darkDivider, width: 1.0),
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(UIScales.formRadius),
    borderSide: const BorderSide(color: AppColors.error, width: 1.5),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(UIScales.formRadius),
    borderSide: const BorderSide(color: AppColors.error, width: 1.5),
  ),
  hintStyle: const TextStyle(
    color: AppColors.darkTextSecondary,
    fontSize: 16.0,
  ),
);
