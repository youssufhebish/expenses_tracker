import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/themes/fonts_manager.dart';
import '../../../../generated/l10n.dart';
import '../bloc/add_expense_bloc.dart';
import '../bloc/add_expense_event.dart';
import '../components/save_button.dart';
import '../components/add_expense_body.dart';

/// Add expense screen with form components
/// Allows users to input expense details and save them
class AddExpenseScreen extends StatelessWidget {
  const AddExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider(
      create: (context) => sl<AddExpenseBloc>()..add(const LoadCurrencyConversionRatesEvent()),
      child: Scaffold(
        appBar: AppBar(
          // Remove default elevation for clean look
          elevation: 0,
          // Screen title with theme typography
          title: Text(
            AppLocalizations.current.addExpense,
            style: TextStyle(
              color: theme.colorScheme.onSurface,
              fontSize: FontSizes.s18,
              fontWeight: FontWeights.semiBold,
            ),
          ),
          // Center the title
          centerTitle: true,
        ),
        body: const AddExpenseBody(),
        bottomNavigationBar: const SaveButton(),
      ),
    );
  }
}
