import 'package:flutter/material.dart';

class AppColors {
  // Primary colors - Updated to blue theme
  static const Color primaryColor = Color(0xFF1D55F2); // New blue primary color
  static const Color primaryDark = Color(0xFF1A4DD6); // Darker blue
  static const Color secondaryColor = Color(0xFF25F4EE); // TikTok cyan/teal
  static const Color accentColor = Color(0xFF161823); // TikTok dark blue

  // Light theme colors
  static const Color lightBackground = Color(0xFFFFFFFF); // White background
  static const Color lightSurface = Color(0xFFF8F9FA); // Light surface
  static const Color lightCardBackground = Color(
    0xFFFFFFFF,
  ); // White card background
  static const Color lightDivider = Color(0xFFE9ECEF); // Light divider
  static const Color lightTextPrimary = Color(0xFF212529); // Dark text on light
  static const Color lightTextSecondary = Color(0xFF6C757D); // Medium gray text
  static const Color lightTextTertiary = Color(0xFFADB5BD); // Light gray text

  // Dark theme colors
  static const Color darkBackground = Color(
    0xFF000000,
  ); // TikTok black background
  static const Color darkSurface = Color(0xFF121212); // Dark surface
  static const Color darkCardBackground = Color(0xFF1A1A1A); // Card background
  static const Color darkDivider = Color(0xFF2F2F2F); // Divider color
  static const Color darkTextPrimary = Color(0xFFFFFFFF); // White text
  static const Color darkTextSecondary = Color(0xFF8A8A8A); // Gray text
  static const Color darkTextTertiary = Color(0xFF666666); // Dark gray text

  // Common colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color textInverse = Color(0xFF000000);

  // TikTok accent colors
  static const Color likeRed = Color(0xFFFE2C55);
  static const Color commentBlue = Color(0xFF25F4EE);
  static const Color shareGreen = Color(0xFF25F4EE);
  static const Color bookmarkYellow = Color(0xFFFFD700);

  // TikTok status colors
  static const Color success = Color(0xFF00D4AA);
  static const Color warning = Color(0xFFFFB800);
  static const Color error = Color(0xFFFF4757);
  static const Color info = Color(0xFF25F4EE);

  // TikTok specific colors
  static const Color appBarColor = Color(0xFF000000);
  static const Color appBarColorDark = Color(0xFF000000);
  static const Color bottomNavBackground = Color(0xFF000000);
  static const Color bottomNavSelected = Color(0xFF1D55F2); // Updated to new primary
  static const Color bottomNavUnselected = Color(0xFF8A8A8A);
  static const Color videoOverlay = Color(
    0x80000000,
  ); // Semi-transparent overlay

  // Updated gradient colors
  static const Color gradientStart = Color(0xFF1D55F2); // Updated to new primary
  static const Color gradientEnd = Color(0xFF25F4EE);

  static const MaterialColor primarySwatch = MaterialColor(
    0xFF1D55F2, // New blue primary
    <int, Color>{
      50: Color(0xFFE3ECFE),
      100: Color(0xFFB8D0FD),
      200: Color(0xFF8AB1FB),
      300: Color(0xFF5C92F9),
      400: Color(0xFF3A7BF8),
      500: Color(0xFF1D55F2), // Primary
      600: Color(0xFF1A4DD6),
      700: Color(0xFF1742BA),
      800: Color(0xFF14389E),
      900: Color(0xFF0F2775),
    },
  );

  // Light theme color scheme
  static const ColorScheme lightColorScheme = ColorScheme(
    primary: primaryColor,
    secondary: secondaryColor,
    surface: lightBackground,
    error: error,
    onPrimary: white,
    onSecondary: lightTextSecondary,
    onSurface: lightTextPrimary,
    onError: white,
    brightness: Brightness.light,
  );

  // Dark theme color scheme
  static const ColorScheme darkColorScheme = ColorScheme(
    primary: primaryColor,
    secondary: secondaryColor,
    surface: darkBackground,
    error: error,
    onPrimary: white,
    onSecondary: darkTextSecondary,
    onSurface: darkTextPrimary,
    onError: white,
    brightness: Brightness.dark,
  );

  // Legacy support - keeping these for backward compatibility
  static const ColorScheme colorScheme = darkColorScheme;
  static const ColorScheme darkScheme = darkColorScheme;
}
