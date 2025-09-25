import 'package:flutter/material.dart';

/// Widget that displays an empty state when no expenses are available
/// Shows an icon, title, and description to guide users to add their first expense
class EmptyStateWidget extends StatelessWidget {
  /// Optional custom message to display instead of default
  final String? message;
  
  /// Optional custom description to display instead of default
  final String? description;

  const EmptyStateWidget({
    super.key,
    this.message,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          // Empty state icon
          Icon(
            Icons.receipt_long,
            size: 48,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
          ),
          const SizedBox(height: 16),
          
          // Main message
          Text(
            message ?? 'No expenses yet',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
          const SizedBox(height: 8),
          
          // Description text
          Text(
            description ?? 'Start tracking your expenses by adding your first expense',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}