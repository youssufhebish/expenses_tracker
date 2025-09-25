import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../widgets/category_icon.dart';
import '../../domain/entities/expense_entity.dart';

/// Widget that displays a single expense item
/// Shows expense category, icon, date, time, and amount with proper styling
class ExpenseItemWidget extends StatelessWidget {
  /// The expense entity to display
  final ExpenseEntity expense;

  const ExpenseItemWidget({
    super.key,
    required this.expense,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat('MMM dd, yyyy');
    final timeFormat = DateFormat('hh:mm a');

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.colorScheme.outline.withValues(alpha: 0.1)),
      ),
      child: Row(
        children: [
          // Category icon with colored background
          CategoryIcon(
            color: expense.categoryIconColor,
            icon: expense.categoryIcon,
            isSelected: false,
          ),
          const SizedBox(width: 12),

          // Expense details section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Category name
                Text(
                  expense.category,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                // Date and time information
                Text(
                  '${dateFormat.format(expense.date)} • ${timeFormat.format(expense.createdAt)}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ),

          // Amount with income/expense indicator
          Text(
            '${expense.isIncome ? '+' : '-'}\$${expense.amount.toStringAsFixed(2)}',
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: expense.isIncome
                  ? theme.colorScheme.primary
                  : theme.colorScheme.error,
            ),
          ),
        ],
      ),
    );
  }
}