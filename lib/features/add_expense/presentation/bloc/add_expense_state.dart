import 'package:equatable/equatable.dart';
import 'package:expenses_tracker_lite/features/add_expense/presentation/components/category_grid.dart';
import '../../domain/entities/currency_conversion_entity.dart';

/// Abstract base class for all add expense states
/// Defines the contract for add expense screen states
abstract class AddExpenseState extends Equatable {
  const AddExpenseState();

  @override
  List<Object?> get props => [];
}

/// Initial state when the add expense screen is first created
class AddExpenseInitial extends AddExpenseState {
  const AddExpenseInitial();
}

/// State when expense is being processed
class AddExpenseLoading extends AddExpenseState {
  const AddExpenseLoading();
}

/// State when expense is successfully added
class AddExpenseSuccess extends AddExpenseState {
  final String message;

  const AddExpenseSuccess({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}

/// State when there's an error adding expense
class AddExpenseError extends AddExpenseState {
  final String message;

  const AddExpenseError({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}

/// State when receipt is being saved
class ReceiptSaving extends AddExpenseState {
  const ReceiptSaving();
}

/// State when receipt is successfully saved
class ReceiptSaved extends AddExpenseState {
  final String imagePath;

  const ReceiptSaved({
    required this.imagePath,
  });

  @override
  List<Object?> get props => [imagePath];
}

/// State when there's an error saving receipt
class ReceiptError extends AddExpenseState {
  final String message;

  const ReceiptError({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}

/// State when form validation fails
class AddExpenseValidationError extends AddExpenseState {
  final Map<String, String> errors;

  const AddExpenseValidationError({
    required this.errors,
  });

  @override
  List<Object?> get props => [errors];
}

/// State when currency conversion rates are being loaded
class CurrencyConversionLoading extends AddExpenseState {
  const CurrencyConversionLoading();
}

/// State when currency conversion rates are successfully loaded
class CurrencyConversionLoaded extends AddExpenseState {
  final CurrencyConversionEntity currencyRates;

  const CurrencyConversionLoaded({
    required this.currencyRates,
  });

  @override
  List<Object?> get props => [currencyRates];
}

/// State when there's an error loading currency conversion rates
class CurrencyConversionError extends AddExpenseState {
  final String message;

  const CurrencyConversionError({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}

/// State that manages form data and UI state
/// Contains all form fields and their current values
class AddExpenseFormState extends AddExpenseState {
  final String amount;
  final DateTime? selectedDate;
  final ExpenseCategory? selectedCategory;
  final String? receiptPath;
  final bool isIncome;
  final String selectedCurrency;
  final double currencyRate;
  final bool isFormValid;
  final Map<String, String> validationErrors;
  final bool isDatePickerOpen;
  final bool isReceiptUploading;

  const AddExpenseFormState({
    this.amount = '',
    this.selectedDate,
    this.selectedCategory,
    this.receiptPath,
    this.isIncome = false,
    this.selectedCurrency = 'USD',
    this.currencyRate = 1.0,
    this.isFormValid = false,
    this.validationErrors = const {},
    this.isDatePickerOpen = false,
    this.isReceiptUploading = false,
  });

  /// Creates a copy of this state with updated values
  AddExpenseFormState copyWith({
    String? amount,
    DateTime? selectedDate,
    ExpenseCategory? selectedCategory,
    String? selectedGridCategory,
    String? receiptPath,
    bool? isIncome,
    String? selectedCurrency,
    double? currencyRate,
    bool? isFormValid,
    Map<String, String>? validationErrors,
    bool? isDatePickerOpen,
    bool? isReceiptUploading,
  }) {
    return AddExpenseFormState(
      amount: amount ?? this.amount,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      receiptPath: receiptPath ?? this.receiptPath,
      isIncome: isIncome ?? this.isIncome,
      selectedCurrency: selectedCurrency ?? this.selectedCurrency,
      currencyRate: currencyRate ?? this.currencyRate,
      isFormValid: isFormValid ?? this.isFormValid,
      validationErrors: validationErrors ?? this.validationErrors,
      isDatePickerOpen: isDatePickerOpen ?? this.isDatePickerOpen,
      isReceiptUploading: isReceiptUploading ?? this.isReceiptUploading,
    );
  }

  @override
  List<Object?> get props => [
        amount,
        selectedDate,
        selectedCategory,
        receiptPath,
        isIncome,
        selectedCurrency,
        isFormValid,
        validationErrors,
        isDatePickerOpen,
        isReceiptUploading,
      ];
}

/// Combined state that includes both form state and currency conversion state
/// This allows the UI to access both form data and currency information
class AddExpenseFormWithCurrencyState extends AddExpenseState {
  final AddExpenseFormState formState;
  final CurrencyConversionEntity? currencyRates;
  final bool isCurrencyLoading;
  final String? currencyError;

  const AddExpenseFormWithCurrencyState({
    required this.formState,
    this.currencyRates,
    this.isCurrencyLoading = false,
    this.currencyError,
  });

  /// Creates a copy of this state with updated values
  AddExpenseFormWithCurrencyState copyWith({
    AddExpenseFormState? formState,
    CurrencyConversionEntity? currencyRates,
    bool? isCurrencyLoading,
    String? currencyError,
  }) {
    return AddExpenseFormWithCurrencyState(
      formState: formState ?? this.formState,
      currencyRates: currencyRates ?? this.currencyRates,
      isCurrencyLoading: isCurrencyLoading ?? this.isCurrencyLoading,
      currencyError: currencyError ?? this.currencyError,
    );
  }

  @override
  List<Object?> get props => [
        formState,
        currencyRates,
        isCurrencyLoading,
        currencyError,
      ];
}