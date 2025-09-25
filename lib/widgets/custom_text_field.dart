import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../core/themes/colors.dart';
import '../core/themes/fonts_manager.dart';

/// Common text field widget with configurable options
/// Provides consistent styling and behavior across the application
class CustomTextField extends StatelessWidget {
  /// Text editing controller for the field
  final TextEditingController controller;
  
  /// Label text displayed above the field
  final String label;
  
  /// Hint text displayed inside the field when empty
  final String? hintText;
  
  /// Prefix text displayed at the start of the field
  final String? prefixText;
  
  /// Suffix icon displayed at the end of the field
  final Widget? suffixIcon;
  
  /// Prefix icon displayed at the start of the field
  final Widget? prefixIcon;
  
  /// Error text displayed below the field
  final String? errorText;
  
  /// Whether the field is enabled for input
  final bool enabled;
  
  /// Whether the field is read-only
  final bool readOnly;
  
  /// Keyboard type for the field
  final TextInputType keyboardType;
  
  /// Input formatters for the field
  final List<TextInputFormatter>? inputFormatters;
  
  /// Maximum number of lines for the field
  final int maxLines;
  
  /// Minimum number of lines for the field
  final int? minLines;
  
  /// Maximum length of input
  final int? maxLength;
  
  /// Whether to show the character counter
  final bool showCounter;
  
  /// Callback when the field is tapped
  final VoidCallback? onTap;
  
  /// Callback when the field value changes
  final ValueChanged<String>? onChanged;
  
  /// Callback when editing is complete
  final VoidCallback? onEditingComplete;
  
  /// Callback when the field is submitted
  final ValueChanged<String>? onSubmitted;
  
  /// Text capitalization behavior
  final TextCapitalization textCapitalization;
  
  /// Whether to obscure the text (for passwords)
  final bool obscureText;
  
  /// Custom border radius
  final double borderRadius;
  
  /// Custom padding
  final EdgeInsets? contentPadding;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    this.hintText,
    this.prefixText,
    this.suffixIcon,
    this.prefixIcon,
    this.errorText,
    this.enabled = true,
    this.readOnly = false,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.showCounter = false,
    this.onTap,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.textCapitalization = TextCapitalization.none,
    this.obscureText = false,
    this.borderRadius = 12.0,
    this.contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Build the complete text field with label, input, and error text
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Field label
        Text(
          label,
          style: TextStyle(
            color: theme.colorScheme.onSurface,
            fontSize: FontSizes.s14,
            fontWeight: FontWeights.medium,
          ),
        ),
        const SizedBox(height: 8),
        
        // Text field container with styling and border
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              // Border color changes based on error state
              color: errorText != null
                  ? AppColors.error
                  : AppColors.lightDivider,
              width: 1.0,
            ),
          ),
          child: TextField(
            // Dismiss keyboard when tapping outside
            onTapOutside: (_) => FocusScope.of(context).unfocus(),
            controller: controller,
            enabled: enabled,
            readOnly: readOnly,
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            maxLines: maxLines,
            minLines: minLines,
            // Show counter only if explicitly requested
            maxLength: showCounter ? maxLength : null,
            onTap: onTap,
            onChanged: onChanged,
            onEditingComplete: onEditingComplete,
            onSubmitted: onSubmitted,
            textCapitalization: textCapitalization,
            obscureText: obscureText,
            style: TextStyle(
              // Text color based on enabled state
              color: enabled 
                  ? AppColors.lightTextPrimary 
                  : AppColors.lightTextSecondary,
              fontSize: FontSizes.s14,
              fontWeight: FontWeights.regular,
            ),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                color: AppColors.lightTextSecondary,
                fontSize: FontSizes.s14,
                fontWeight: FontWeights.regular,
              ),
              prefixText: prefixText,
              prefixStyle: TextStyle(
                color: AppColors.lightTextPrimary,
                fontSize: FontSizes.s14,
                fontWeight: FontWeights.regular,
              ),
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              // Remove default border as we use container decoration
              border: InputBorder.none,
              contentPadding: contentPadding ?? 
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              // Hide counter text unless explicitly shown
              counterText: showCounter ? null : '',
            ),
          ),
        ),
        
        // Error text display when validation fails
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              errorText!,
              style: TextStyle(
                color: AppColors.error,
                fontSize: FontSizes.s12,
                fontWeight: FontWeights.regular,
              ),
            ),
          ),
      ],
    );
  }
}
