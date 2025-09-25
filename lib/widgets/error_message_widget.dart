import 'package:flutter/material.dart';
import '../generated/l10n.dart';

/// Common error message widget for displaying error states
/// Shows an error message with an optional retry button
/// Used throughout the app to provide consistent error handling UI
class ErrorMessageWidget extends StatelessWidget {
  /// The error message to display to the user
  final String message;
  
  /// Callback function executed when retry button is pressed
  final VoidCallback? onRetry;
  
  /// Whether to show the retry button
  /// Defaults to true if onRetry callback is provided
  final bool showRetryButton;

  const ErrorMessageWidget({
    super.key,
    required this.message,
    this.onRetry,
    this.showRetryButton = true,
  });

  @override
  Widget build(BuildContext context) {
    // Get theme for consistent styling
    final theme = Theme.of(context);
    
    // Center the error message and retry button
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Display error message with theme styling
          Text(
            message,
            style: theme.textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          // Show retry button if enabled and callback is provided
          if (showRetryButton && onRetry != null) ...[
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                // Set minimum button size for better touch target
                minimumSize: const Size(120, 40),
                padding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              child: Text(AppLocalizations.current.retry),
            ),
          ],
        ],
      ),
    );
  }
}
