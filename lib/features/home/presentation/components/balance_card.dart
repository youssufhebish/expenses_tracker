import 'package:flutter/material.dart';
import '../../../../core/themes/colors.dart';
import '../../../../core/themes/fonts_manager.dart';

/// Balance card component displaying total balance, income, and expenses
class BalanceCard extends StatelessWidget {
  final double totalBalance;
  final double income;
  final double expenses;

  const BalanceCard({
    super.key,
    required this.totalBalance,
    required this.income,
    required this.expenses,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20).copyWith(
        top: 140,
      ),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Color(0xFF496ff2),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Total Balance header
          Row(
            children: [
              Text(
                'Total Balance',
                style: TextStyle(
                  fontSize: FontSizes.s16,
                  fontWeight: FontWeights.medium,
                  color: theme.colorScheme.surface,
                ),
              ),
              const SizedBox(width: 4,),
              Icon(
                totalBalance >= 0 ? Icons.keyboard_arrow_up_rounded : Icons
                    .keyboard_arrow_down_rounded,
                color: theme.colorScheme.surface,
              ),
              const Spacer(),
              // More options button
              Container(
                padding: const EdgeInsets.all(4),
                child: Icon(
                  Icons.more_horiz,
                  color: theme.colorScheme.surface,
                  size: 24,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Total balance amount
          Text(
            '\$${_formatAmount(totalBalance)}',
            style: TextStyle(
              fontSize: FontSizes.s36,
              fontWeight: FontWeights.bold,
              color: theme.colorScheme.surface,
            ),
          ),
          const SizedBox(height: 24),
          // Income and Expenses row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Income card
              _buildIncomeExpenseCard(
                icon: Icons.arrow_downward,
                label: 'Income',
                amount: income,
                isIncome: true,
                theme: theme,
              ),
              // Expenses card
              _buildIncomeExpenseCard(
                icon: Icons.arrow_upward,
                label: 'Expenses',
                amount: expenses,
                isIncome: false,
                theme: theme,
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Helper method to build income/expense cards
  Widget _buildIncomeExpenseCard({
    required IconData icon,
    required String label,
    required double amount,
    required bool isIncome,
    required ThemeData theme,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Icon and label
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: theme.colorScheme.surface,
                size: 16,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: FontSizes.s14,
                fontWeight: FontWeights.medium,
                color: theme.colorScheme.surface.withValues(alpha: 0.8),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        // Amount
        Text(
          '\$${_formatAmount(amount)}',
          style: TextStyle(
            fontSize: FontSizes.s20,
            fontWeight: FontWeights.semiBold,
            color: theme.colorScheme.surface,
          ),
        ),
      ],
    );
  }

  /// Helper method to format amount with commas
  String _formatAmount(double amount) {
    return amount.toStringAsFixed(2).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }
}