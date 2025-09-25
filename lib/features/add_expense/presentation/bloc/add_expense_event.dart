import 'package:equatable/equatable.dart';
import '../../domain/entities/add_expense_entity.dart';
import '../components/category_grid.dart';

/// Abstract base class for all add expense events
/// Defines the contract for add expense screen events
abstract class AddExpenseEvent extends Equatable {
  const AddExpenseEvent();

  @override
  List<Object?> get props => [];
}

/// Event to add a new expense
/// Triggered when user submits the expense form
class AddExpenseSubmitEvent extends AddExpenseEvent {
  final AddExpenseEntity expense;

  const AddExpenseSubmitEvent({
    required this.expense,
  });

  @override
  List<Object?> get props => [expense];
}

/// Event to save receipt image
/// Triggered when user uploads a receipt
class SaveReceiptEvent extends AddExpenseEvent {
  final String imagePath;
  final String expenseId;

  const SaveReceiptEvent({
    required this.imagePath,
    required this.expenseId,
  });

  @override
  List<Object?> get props => [imagePath, expenseId];
}

/// Event to reset the form state
/// Triggered when user wants to clear the form
class ResetFormEvent extends AddExpenseEvent {
  const ResetFormEvent();
}

/// Event to validate expense data
/// Triggered during form validation
class ValidateExpenseEvent extends AddExpenseEvent {
  final AddExpenseEntity expense;

  const ValidateExpenseEvent({
    required this.expense,
  });

  @override
  List<Object?> get props => [expense];
}

/// Event to load currency conversion rates
/// Triggered when user needs to see available currencies
class LoadCurrencyConversionRatesEvent extends AddExpenseEvent {
  const LoadCurrencyConversionRatesEvent();
}

/// Event to update form field values
/// Triggered when user changes form inputs
class UpdateFormFieldEvent extends AddExpenseEvent {
  final String? amount;
  final DateTime? selectedDate;
  final String? selectedCategory;
  final String? selectedGridCategory;
  final String? receiptPath;
  final bool? isIncome;
  final String? selectedCurrency;

  const UpdateFormFieldEvent({
    this.amount,
    this.selectedDate,
    this.selectedCategory,
    this.selectedGridCategory,
    this.receiptPath,
    this.isIncome,
    this.selectedCurrency,
  });

  @override
  List<Object?> get props => [
        amount,
        selectedDate,
        selectedCategory,
        selectedGridCategory,
        receiptPath,
        isIncome,
        selectedCurrency,
      ];
}

/// Event to select date
/// Triggered when user picks a date
class SelectDateEvent extends AddExpenseEvent {
  final DateTime selectedDate;

  const SelectDateEvent({
    required this.selectedDate,
  });

  @override
  List<Object?> get props => [selectedDate];
}

/// Event to upload receipt
/// Triggered when user uploads a receipt image
class UploadReceiptEvent extends AddExpenseEvent {
  const UploadReceiptEvent();
}

/// Event to update selected category
/// Triggered when user selects a category
class UpdateCategoryEvent extends AddExpenseEvent {
  final ExpenseCategory? category;

  const UpdateCategoryEvent({
    this.category,
  });

  @override
  List<Object?> get props => [category];
}

/// Event to toggle income/expense mode
/// Triggered when user switches between income and expense
class ToggleIncomeExpenseEvent extends AddExpenseEvent {
  final bool isIncome;

  const ToggleIncomeExpenseEvent({
    required this.isIncome,
  });

  @override
  List<Object?> get props => [isIncome];
}

/// Event to update selected currency
/// Triggered when user changes currency
class UpdateCurrencyEvent extends AddExpenseEvent {
  final String currency;

  const UpdateCurrencyEvent({
    required this.currency,
  });

  @override
  List<Object?> get props => [currency];
}

/// Event to update amount value
/// Triggered when user changes the amount input
class UpdateAmountEvent extends AddExpenseEvent {
  final String amount;

  const UpdateAmountEvent({
    required this.amount,
  });

  @override
  List<Object?> get props => [amount];
}