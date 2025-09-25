import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../widgets/app_button.dart';
import '../bloc/add_expense_bloc.dart';
import '../bloc/add_expense_state.dart';

/// Save button component for expense/income submission
/// Integrates with AddExpenseBloc to handle loading states and submission
class ExpenseSaveButton extends StatelessWidget {
  /// Callback function when the save button is pressed
  final VoidCallback onPressed;

  const ExpenseSaveButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddExpenseBloc, AddExpenseState>(
      builder: (context, state) {
        return AppButton.primary(
          onPressed: onPressed,
          text: 'Save',
          isLoading: state is AddExpenseLoading,
        );
      },
    );
  }
}