import 'package:flutter/material.dart';
import '../../../../core/themes/colors.dart';
import '../../../../core/themes/fonts_manager.dart';
import '../../../../generated/l10n.dart';

/// Toggle switch component for selecting between income and expense
/// Provides visual feedback and state management for transaction type selection
class IncomeExpenseToggle extends StatelessWidget {
  /// Whether the current selection is income (true) or expense (false)
  final bool isIncome;
  
  /// Callback function when the toggle state changes
  final ValueChanged<bool> onChanged;

  const IncomeExpenseToggle({
    super.key,
    required this.isIncome,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.lightDivider),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Toggle labels and switch
          Row(
            spacing: 12,
            children: [
              Text(
                AppLocalizations.current.expense,
                style: TextStyle(
                  color: !isIncome 
                      ? AppColors.primaryColor 
                      : AppColors.lightTextSecondary,
                  fontSize: FontSizes.s14,
                  fontWeight: !isIncome 
                      ? FontWeights.medium 
                      : FontWeights.regular,
                ),
              ),
              Switch(
                value: isIncome,
                onChanged: onChanged,
                activeColor: AppColors.success,
                inactiveThumbColor: AppColors.error,
                inactiveTrackColor: AppColors.error.withValues(alpha: 0.3),
                activeTrackColor: AppColors.success.withValues(alpha: 0.3),
              ),
              Text(
                AppLocalizations.current.income,
                style: TextStyle(
                  color: isIncome 
                      ? AppColors.success 
                      : AppColors.lightTextSecondary,
                  fontSize: FontSizes.s14,
                  fontWeight: isIncome 
                      ? FontWeights.medium 
                      : FontWeights.regular,
                ),
              ),
            ],
          ),
          // Type indicator icon
          Icon(
            isIncome ? Icons.trending_up : Icons.trending_down,
            color: isIncome ? AppColors.success : AppColors.error,
            size: 24,
          ),
        ],
      ),
    );
  }
}