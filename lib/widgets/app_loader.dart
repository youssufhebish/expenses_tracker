import 'package:flutter/material.dart';

/// Common loading indicator widget for the entire app
/// Displays a circular progress indicator with customizable color
/// Used to show loading states in buttons, screens, and other components
class AppLoader extends StatelessWidget {
  /// Optional color for the loader background
  /// If not provided, uses the theme's surface color
  final Color? color;

  const AppLoader({
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Center the circular progress indicator
    return Center(
      child: CircularProgressIndicator(
        // Use custom color or fallback to theme surface color
        backgroundColor: color ?? Theme.of(context).colorScheme.surface,
        // Set stroke width for better visibility
        strokeWidth: 3,
      ),
    );
  }
}
