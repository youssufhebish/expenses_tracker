import 'package:flutter/material.dart';

import '../themes/colors.dart';
import 'app_bar_theme.dart';
import 'input_decoration_theme.dart';
import 'text_selection_theme.dart';
import 'text_themes.dart';

ThemeData themeData() => ThemeData(
  useMaterial3: true,
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  primaryColor: AppColors.primaryColor,
  primarySwatch: AppColors.primarySwatch,
  colorScheme: AppColors.lightColorScheme,
  scaffoldBackgroundColor: AppColors.lightBackground,
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: AppColors.lightSurface,
    elevation: 0,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: AppColors.lightSurface,
    elevation: 0,
    selectedItemColor: AppColors.bottomNavSelected,
    unselectedItemColor: AppColors.lightTextSecondary,
    type: BottomNavigationBarType.fixed,
  ),
  textSelectionTheme: textSelectionThemeData,
  inputDecorationTheme: inputDecorationTheme,
  appBarTheme: appBarTheme,
  iconTheme: const IconThemeData(color: AppColors.lightTextPrimary, size: 24.0),
  textTheme: TextThemes.textTheme,
  typography: Typography(),
  cardTheme: CardThemeData(
    color: AppColors.lightCardBackground,
    elevation: 1.0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primaryColor,
      foregroundColor: AppColors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    ),
  ),
  dividerTheme: const DividerThemeData(
    color: AppColors.lightDivider,
    thickness: 1.0,
  ),
);

ThemeData darkThemeMode() => ThemeData(
  useMaterial3: true,
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  primaryColor: AppColors.primaryColor,
  primarySwatch: AppColors.primarySwatch,
  colorScheme: AppColors.darkColorScheme,
  scaffoldBackgroundColor: AppColors.darkBackground,
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: AppColors.darkSurface,
    elevation: 0,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: AppColors.bottomNavBackground,
    elevation: 0,
    selectedItemColor: AppColors.bottomNavSelected,
    unselectedItemColor: AppColors.bottomNavUnselected,
    type: BottomNavigationBarType.fixed,
  ),
  textSelectionTheme: darkTextSelectionThemeData,
  inputDecorationTheme: darkInputDecoration,
  appBarTheme: darkAppBarTheme,
  iconTheme: const IconThemeData(color: AppColors.darkTextPrimary, size: 24.0),
  textTheme: DarkTextTheme.textTheme,
  typography: Typography(),
  cardTheme: CardThemeData(
    color: AppColors.darkCardBackground,
    elevation: 1.0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primaryColor,
      foregroundColor: AppColors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    ),
  ),
  dividerTheme: const DividerThemeData(
    color: AppColors.darkDivider,
    thickness: 1.0,
  ),
);
