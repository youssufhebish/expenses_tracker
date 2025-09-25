import 'package:flutter/material.dart';
import '../core/themes/colors.dart';
import '../core/themes/fonts_manager.dart';
import 'app_loader.dart';

/// Common button component for the entire app
/// Provides primary action button with loading state, theme styling, and customization options
class AppButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isLoading;
  final String text;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double height;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final bool isFullWidth;

  const AppButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.isLoading = false,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.height = 56,
    this.margin,
    this.padding,
    this.borderRadius = 16,
    this.isFullWidth = true,
  });

  /// Factory constructor for primary button style
  factory AppButton.primary({
    Key? key,
    required VoidCallback? onPressed,
    required String text,
    bool isLoading = false,
    double? width,
    double height = 56,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    double borderRadius = 16,
    bool isFullWidth = true,
  }) {
    return AppButton(
      key: key,
      onPressed: onPressed,
      text: text,
      isLoading: isLoading,
      backgroundColor: AppColors.primaryColor,
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      borderRadius: borderRadius,
      isFullWidth: isFullWidth,
    );
  }

  /// Factory constructor for secondary button style
  factory AppButton.secondary({
    Key? key,
    required VoidCallback? onPressed,
    required String text,
    bool isLoading = false,
    double? width,
    double height = 56,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    double borderRadius = 16,
    bool isFullWidth = true,
  }) {
    return AppButton(
      key: key,
      onPressed: onPressed,
      text: text,
      isLoading: isLoading,
      backgroundColor: AppColors.lightSurface,
      textColor: AppColors.primaryColor,
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      borderRadius: borderRadius,
      isFullWidth: isFullWidth,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: isFullWidth ? double.infinity : width,
      height: height,
      margin: margin ?? const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      padding: padding,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          // Button color from theme or custom
          backgroundColor: backgroundColor ?? AppColors.primaryColor,
          // Disabled button color
          disabledBackgroundColor: AppColors.lightTextTertiary,
          // Remove default elevation
          elevation: 0,
          // Button shape with rounded corners
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          // Remove splash color for clean look
          splashFactory: NoSplash.splashFactory,
        ),
        child: isLoading
            ? _buildLoadingIndicator()
            : _buildButtonText(theme),
      ),
    );
  }

  /// Builds loading indicator for button
  Widget _buildLoadingIndicator() {
    return const SizedBox(
      width: 24,
      height: 24,
      child: AppLoader(),
    );
  }

  /// Builds button text with theme typography
  Widget _buildButtonText(ThemeData theme) {
    return Text(
      text,
      style: TextStyle(
        color: textColor ?? theme.colorScheme.surface,
        fontSize: FontSizes.s16,
        fontWeight: FontWeights.semiBold,
      ),
    );
  }
}