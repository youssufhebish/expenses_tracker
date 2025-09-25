import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/services/expense_refresh_service.dart';
import '../../../../generated/l10n.dart';
import '../../domain/entities/add_expense_entity.dart';
import '../../domain/usecases/add_expense_usecase.dart';
import '../../domain/usecases/save_receipt_usecase.dart';
import '../../domain/usecases/get_currency_conversion_rates_usecase.dart';
import 'add_expense_event.dart';
import 'add_expense_state.dart';

/// Bloc for managing add expense screen state and business logic
/// Handles expense submission, validation, receipt saving, currency conversion, and form state
class AddExpenseBloc extends Bloc<AddExpenseEvent, AddExpenseState> {
  final AddExpenseUseCase addExpenseUseCase;
  final SaveReceiptUseCase saveReceiptUseCase;
  final GetCurrencyConversionRatesUseCase getCurrencyConversionRatesUseCase;
  final ExpenseRefreshService expenseRefreshService;

  AddExpenseBloc({
    required this.addExpenseUseCase,
    required this.saveReceiptUseCase,
    required this.getCurrencyConversionRatesUseCase,
    required this.expenseRefreshService,
  }) : super(AddExpenseFormWithCurrencyState(
          formState: AddExpenseFormState(),
        )) {
    // Register event handlers
    on<AddExpenseSubmitEvent>(_onAddExpenseSubmit);
    on<SaveReceiptEvent>(_onSaveReceipt);
    on<ResetFormEvent>(_onResetForm);
    on<ValidateExpenseEvent>(_onValidateExpense);
    on<LoadCurrencyConversionRatesEvent>(_onLoadCurrencyConversionRates);
    on<UpdateFormFieldEvent>(_onUpdateFormField);
    on<SelectDateEvent>(_onSelectDate);
    on<UploadReceiptEvent>(_onUploadReceipt);
    on<UpdateCategoryEvent>(_onUpdateCategory);
    on<ToggleIncomeExpenseEvent>(_onToggleIncomeExpense);
    on<UpdateCurrencyEvent>(_onUpdateCurrency);
    on<UpdateAmountEvent>(_onUpdateAmount);
  }

  /// Handles adding a new expense
  Future<void> _onAddExpenseSubmit(
    AddExpenseSubmitEvent event,
    Emitter<AddExpenseState> emit,
  ) async {
    emit(const AddExpenseLoading());

    try {
      final result = await addExpenseUseCase(
        AddExpenseParams(expense: event.expense),
      );

      await result.fold(
        (failure) async {
          emit(AddExpenseError(message: failure.message));
        },
        (success) async {
          // Notify that expenses should be refreshed
          expenseRefreshService.notifyExpenseRefresh();
          
          emit(AddExpenseSuccess(
            message: AppLocalizations.current.expenseAddedSuccessfully,
          ));
        },
      );
    } catch (e) {
      emit(AddExpenseError(
        message: AppLocalizations.current.failedToAddExpense,
      ));
    }
  }

  /// Handles saving receipt image
  Future<void> _onSaveReceipt(
    SaveReceiptEvent event,
    Emitter<AddExpenseState> emit,
  ) async {
    emit(const ReceiptSaving());

    try {
      final result = await saveReceiptUseCase(
        SaveReceiptParams(
          imagePath: event.imagePath,
        ),
      );

      await result.fold(
        (failure) async {
          emit(ReceiptError(message: failure.message));
        },
        (imagePath) async {
          emit(ReceiptSaved(imagePath: imagePath));
        },
      );
    } catch (e) {
      emit(const ReceiptError(
        message: 'Failed to save receipt. Please try again.',
      ));
    }
  }

  /// Handles resetting the form
  void _onResetForm(
    ResetFormEvent event,
    Emitter<AddExpenseState> emit,
  ) {
    emit(AddExpenseFormWithCurrencyState(
      formState: AddExpenseFormState(),
    ));
  }

  /// Handles validating expense data
  void _onValidateExpense(
    ValidateExpenseEvent event,
    Emitter<AddExpenseState> emit,
  ) {
    final errors = <String, String>{};

    // Validate amount
    if (event.expense.amount <= 0) {
      errors['amount'] = 'Amount must be greater than 0';
    }

    // Validate category
    if (event.expense.category.isEmpty) {
      errors['category'] = 'Please select a category';
    }

    // Validate date
    if (event.expense.date.isAfter(DateTime.now())) {
      errors['date'] = 'Date cannot be in the future';
    }

    if (errors.isNotEmpty) {
      emit(AddExpenseValidationError(errors: errors));
    } else {
      // If validation passes, proceed with submission
      add(AddExpenseSubmitEvent(expense: event.expense));
    }
  }

  /// Handles loading currency conversion rates
  Future<void> _onLoadCurrencyConversionRates(
    LoadCurrencyConversionRatesEvent event,
    Emitter<AddExpenseState> emit,
  ) async {
    final currentState = state;
    if (currentState is AddExpenseFormWithCurrencyState) {
      emit(currentState.copyWith(isCurrencyLoading: true));
    }

    try {
      final result = await getCurrencyConversionRatesUseCase();

      await result.fold(
        (failure) async {
          if (currentState is AddExpenseFormWithCurrencyState) {
            emit(currentState.copyWith(
              isCurrencyLoading: false,
              currencyError: failure.message,
            ));
          }
        },
        (currencyRates) async {
          if (currentState is AddExpenseFormWithCurrencyState) {
            emit(currentState.copyWith(
              isCurrencyLoading: false,
              currencyRates: currencyRates,
              currencyError: null,
            ));
          }
        },
      );
    } catch (e) {
      if (currentState is AddExpenseFormWithCurrencyState) {
        emit(currentState.copyWith(
          isCurrencyLoading: false,
          currencyError: 'Failed to load currency rates. Please try again.',
        ));
      }
    }
  }

  /// Handles updating form field values
  void _onUpdateFormField(
    UpdateFormFieldEvent event,
    Emitter<AddExpenseState> emit,
  ) {
    final currentState = state;
    if (currentState is AddExpenseFormWithCurrencyState) {
      final updatedFormState = currentState.formState.copyWith(
        amount: event.amount,
        selectedDate: event.selectedDate,
        selectedGridCategory: event.selectedGridCategory,
        receiptPath: event.receiptPath,
        isIncome: event.isIncome,
        selectedCurrency: event.selectedCurrency,
      );
      
      emit(currentState.copyWith(formState: updatedFormState));
    }
  }

  /// Handles date selection
  void _onSelectDate(
    SelectDateEvent event,
    Emitter<AddExpenseState> emit,
  ) {
    final currentState = state;
    if (currentState is AddExpenseFormWithCurrencyState) {
      final updatedFormState = currentState.formState.copyWith(
        selectedDate: event.selectedDate,
      );
      
      emit(currentState.copyWith(formState: updatedFormState));
    }
  }

  /// Handles receipt upload
  void _onUploadReceipt(
    UploadReceiptEvent event,
    Emitter<AddExpenseState> emit,
  ) {
    final currentState = state;
    if (currentState is AddExpenseFormWithCurrencyState) {
      final updatedFormState = currentState.formState.copyWith(
        isReceiptUploading: true,
      );
      
      emit(currentState.copyWith(formState: updatedFormState));
      
      // TODO: Implement actual receipt upload logic
      // For now, just reset the uploading state
      final finalFormState = updatedFormState.copyWith(
        isReceiptUploading: false,
      );
      
      emit(currentState.copyWith(formState: finalFormState));
    }
  }

  /// Handles category update
  void _onUpdateCategory(
    UpdateCategoryEvent event,
    Emitter<AddExpenseState> emit,
  ) {
    final currentState = state;
    if (currentState is AddExpenseFormWithCurrencyState) {
      final updatedFormState = currentState.formState.copyWith(
        selectedCategory: event.category,
      );
      
      emit(currentState.copyWith(formState: updatedFormState));
    }
  }

  /// Handles income/expense toggle
  void _onToggleIncomeExpense(
    ToggleIncomeExpenseEvent event,
    Emitter<AddExpenseState> emit,
  ) {
    final currentState = state;
    if (currentState is AddExpenseFormWithCurrencyState) {
      final updatedFormState = currentState.formState.copyWith(
        isIncome: event.isIncome,
      );
      
      emit(currentState.copyWith(formState: updatedFormState));
    }
  }

  /// Handles currency update
  void _onUpdateCurrency(
    UpdateCurrencyEvent event,
    Emitter<AddExpenseState> emit,
  ) {
    final currentState = state;
    if (currentState is AddExpenseFormWithCurrencyState) {
      final currencyRate = currentState.currencyRates?.conversionRates[event.currency] ?? 1.0;
      final updatedFormState = currentState.formState.copyWith(
        selectedCurrency: event.currency,
        currencyRate: currencyRate,
      );
      
      emit(currentState.copyWith(formState: updatedFormState));
    }
  }

  /// Handles amount update
  void _onUpdateAmount(
    UpdateAmountEvent event,
    Emitter<AddExpenseState> emit,
  ) {
    final currentState = state;
    if (currentState is AddExpenseFormWithCurrencyState) {
      final updatedFormState = currentState.formState.copyWith(
        amount: event.amount,
      );
      
      emit(currentState.copyWith(formState: updatedFormState));
    }
  }
}