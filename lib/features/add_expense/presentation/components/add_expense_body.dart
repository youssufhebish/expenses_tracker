import 'package:expenses_tracker_lite/widgets/app_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../core/themes/colors.dart';
import '../bloc/add_expense_bloc.dart';
import '../bloc/add_expense_event.dart';
import '../bloc/add_expense_state.dart';
import 'income_expense_toggle.dart';
import 'expense_form.dart';

/// Main body component for the add expense screen
/// Handles form display and user interactions through bloc
class AddExpenseBody extends HookWidget {
  const AddExpenseBody({super.key});

  @override
  Widget build(BuildContext context) {
    // Form controllers
    final amountController = useTextEditingController();
    final dateController = useTextEditingController();
    final receiptController = useTextEditingController();

    return BlocListener<AddExpenseBloc, AddExpenseState>(
      listener: (context, state) {
        if (state is AddExpenseSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: AppColors.success,
            ),
          );
          Navigator.of(context).pop();
        } else if (state is AddExpenseError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: AppColors.error,
            ),
          );
        }
      },
      child: BlocBuilder<AddExpenseBloc, AddExpenseState>(
        builder: (context, state) {
          if (state is AddExpenseFormWithCurrencyState) {
            final formState = state.formState;
            final currencyRates = state.currencyRates;
            final isLoadingCurrencies = state.isCurrencyLoading;

            // Update controllers when form state changes
            if (amountController.text != formState.amount) {
              amountController.text = formState.amount;
            }

            // Update date controller
            if (formState.selectedDate != null) {
              final date = formState.selectedDate;
              dateController.text = '${date?.day.toString().padLeft(2, '0')}/${date?.month.toString().padLeft(2, '0')}/${date?.year.toString().substring(2)}';
            }

            // Update receipt controller
            if (formState.receiptPath != null) {
              receiptController.text = 'Receipt uploaded';
            } else {
              receiptController.text = '';
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 24,
                children: [
                  // Income/Expense Toggle
                  IncomeExpenseToggle(
                    isIncome: formState.isIncome,
                    onChanged: (isIncome) {
                      context.read<AddExpenseBloc>().add(
                        ToggleIncomeExpenseEvent(isIncome: isIncome),
                      );
                    },
                  ),
                  // Expense Form
                  ExpenseForm(
                    amountController: amountController,
                    dateController: dateController,
                    receiptController: receiptController,
                    selectedGridCategory: formState.selectedCategory?.name,
                    isIncome: formState.isIncome,
                    selectedCurrency: formState.selectedCurrency,
                    availableCurrencies: currencyRates?.availableCurrencies ?? ['USD'],
                    isLoadingCurrencies: isLoadingCurrencies,
                    onAmountChanged: (amount) {
                      context.read<AddExpenseBloc>().add(
                        UpdateAmountEvent(amount: amount),
                      );
                    },
                    onCategorySelected: (category) {
                      context.read<AddExpenseBloc>().add(
                        UpdateCategoryEvent(
                          category: category,
                        ),
                      );
                    },
                    onDateTap: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: formState.selectedDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now(),
                      );
                      if (picked != null) {
                        context.read<AddExpenseBloc>().add(
                          SelectDateEvent(selectedDate: picked),
                        );
                      }
                    },
                    onReceiptTap: () {
                      // Simple receipt upload simulation
                      context.read<AddExpenseBloc>().add(
                        const UpdateFormFieldEvent(receiptPath: 'receipt_uploaded.jpg'),
                      );
                    },
                    onCurrencyChanged: (currency) {
                      if (currency != null) {
                        context.read<AddExpenseBloc>().add(
                          UpdateCurrencyEvent(currency: currency),
                        );
                      }
                    },
                    currencyRate: state.formState.currencyRate, // Default rate
                    onLoadCurrencies: () {
                      context.read<AddExpenseBloc>().add(
                        const LoadCurrencyConversionRatesEvent(),
                      );
                    },
                  ),
                ],
              ),
            );
          }

          // Fallback for other states
          return const AppLoader();
        },
      ),
    );
  }
}
