import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/themes/colors.dart';
import '../../../../generated/l10n.dart';
import '../../../../widgets/app_button.dart';
import '../../domain/entities/add_expense_entity.dart';
import '../bloc/add_expense_bloc.dart';
import '../bloc/add_expense_event.dart';
import '../bloc/add_expense_state.dart';

/// Save button widget for expense/income submission
/// Designed to be used as bottom navigation bar in Scaffold
/// Integrates with AddExpenseBloc to handle form validation and submission
class SaveButton extends StatelessWidget {
  const SaveButton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
      ),
      child: SafeArea(
        child: BlocBuilder<AddExpenseBloc, AddExpenseState>(
          builder: (context, state) {
            // Get form state from current state
            final formState = state is AddExpenseFormWithCurrencyState 
                ? state.formState 
                : null;
            
            return AppButton.primary(
              onPressed: formState != null 
                  ? () => _saveExpense(context, formState) 
                  : null,
              text: AppLocalizations.current.saveExpense,
              isLoading: state is AddExpenseLoading,
            );
          },
        ),
      ),
    );
  }

  /// Handles saving the expense
  /// Validates form data and triggers expense submission
  void _saveExpense(BuildContext context, AddExpenseFormState formState) {
    // Parse amount
    double amount = (double.tryParse(formState.amount) ?? 0.0) / formState.currencyRate;
    amount = double.tryParse(amount.toStringAsFixed(2)) ?? 0.0;

    // Validate category selection
    if (formState.selectedCategory == null || formState.selectedCategory!.name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.current.pleaseSelectCategory),
            backgroundColor: AppColors.error,
          ),
      );
      return;
    }

    // Create expense entity
    final expense = AddExpenseEntity(
      category: formState.selectedCategory!.name,
      amount: amount,
      date: formState.selectedDate ?? DateTime.now(),
      receiptPath: formState.receiptPath,
      categoryIcon: formState.selectedCategory!.icon,
      categoryIconColor: formState.selectedCategory!.color,
      isIncome: formState.isIncome,
      currency: formState.selectedCurrency,
    );

    // Trigger validation and submission
    context.read<AddExpenseBloc>().add(
      ValidateExpenseEvent(expense: expense),
    );
  }
}
