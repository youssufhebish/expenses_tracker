import 'package:bloc_test/bloc_test.dart';
import 'package:expenses_tracker_lite/core/error/failures.dart';
import 'package:expenses_tracker_lite/core/services/expense_refresh_service.dart';
import 'package:expenses_tracker_lite/features/add_expense/domain/entities/add_expense_entity.dart';
import 'package:expenses_tracker_lite/features/add_expense/domain/usecases/add_expense_usecase.dart';
import 'package:expenses_tracker_lite/features/add_expense/domain/usecases/save_receipt_usecase.dart';
import 'package:expenses_tracker_lite/features/add_expense/domain/usecases/get_currency_conversion_rates_usecase.dart';
import 'package:expenses_tracker_lite/features/add_expense/presentation/bloc/add_expense_bloc.dart';
import 'package:expenses_tracker_lite/features/add_expense/presentation/bloc/add_expense_event.dart';
import 'package:expenses_tracker_lite/features/add_expense/presentation/bloc/add_expense_state.dart';
import 'package:expenses_tracker_lite/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

// Mock classes
class MockAddExpenseUseCase extends Mock implements AddExpenseUseCase {}
class MockSaveReceiptUseCase extends Mock implements SaveReceiptUseCase {}
class MockGetCurrencyConversionRatesUseCase extends Mock implements GetCurrencyConversionRatesUseCase {}
class MockExpenseRefreshService extends Mock implements ExpenseRefreshService {}

void main() {
  group('AddExpenseBloc', () {
    late AddExpenseBloc addExpenseBloc;
    late MockAddExpenseUseCase mockAddExpenseUseCase;
    late MockSaveReceiptUseCase mockSaveReceiptUseCase;
    late MockGetCurrencyConversionRatesUseCase mockGetCurrencyConversionRatesUseCase;
    late MockExpenseRefreshService mockExpenseRefreshService;

    // Register fallback values for mocktail
    setUpAll(() async {
      // Initialize localization for tests
      await AppLocalizations.load(const Locale('en'));
      
      registerFallbackValue(const SaveReceiptParams(imagePath: ''));
      registerFallbackValue(AddExpenseEntity(
        category: '',
        amount: 0.0,
        date: DateTime.now(),
        isIncome: false,
        categoryIcon: Icons.category,
        categoryIconColor: Colors.grey,
      ));
      registerFallbackValue(AddExpenseParams(
        expense: AddExpenseEntity(
          category: '',
          amount: 0.0,
          date: DateTime.now(),
          isIncome: false,
          categoryIcon: Icons.category,
          categoryIconColor: Colors.grey,
        ),
      ));
    });

    setUp(() {
      mockAddExpenseUseCase = MockAddExpenseUseCase();
      mockSaveReceiptUseCase = MockSaveReceiptUseCase();
      mockGetCurrencyConversionRatesUseCase = MockGetCurrencyConversionRatesUseCase();
      mockExpenseRefreshService = MockExpenseRefreshService();
      
      addExpenseBloc = AddExpenseBloc(
        addExpenseUseCase: mockAddExpenseUseCase,
        saveReceiptUseCase: mockSaveReceiptUseCase,
        getCurrencyConversionRatesUseCase: mockGetCurrencyConversionRatesUseCase,
        expenseRefreshService: mockExpenseRefreshService,
      );
    });

    tearDown(() {
      addExpenseBloc.close();
    });

    test('initial state should be AddExpenseFormWithCurrencyState', () {
      expect(addExpenseBloc.state, isA<AddExpenseFormWithCurrencyState>());
    });

    group('AddExpenseSubmitEvent', () {
      final tAddExpenseEntity = AddExpenseEntity(
        category: 'Food',
        amount: 100.0,
        date: DateTime.now(),
        isIncome: false,
        categoryIcon: Icons.fastfood,
        categoryIconColor: Colors.red,
      );

      blocTest<AddExpenseBloc, AddExpenseState>(
        'should emit [AddExpenseLoading, AddExpenseSuccess] when adding expense is successful',
        build: () {
          when(() => mockAddExpenseUseCase(any()))
              .thenAnswer((_) async => const Right(null));
          when(() => mockExpenseRefreshService.notifyExpenseRefresh())
              .thenReturn(null);
          return addExpenseBloc;
        },
        act: (bloc) => bloc.add(AddExpenseSubmitEvent(expense: tAddExpenseEntity)),
        expect: () => [
          const AddExpenseLoading(),
          AddExpenseSuccess(message: 'Expense added successfully'),
        ],
        verify: (_) {
          verify(() => mockAddExpenseUseCase(any())).called(1);
          verify(() => mockExpenseRefreshService.notifyExpenseRefresh()).called(1);
        },
      );

      blocTest<AddExpenseBloc, AddExpenseState>(
        'should emit [AddExpenseLoading, AddExpenseError] when adding expense fails',
        build: () {
          when(() => mockAddExpenseUseCase(any()))
              .thenAnswer((_) async => Left(ValidationFailure(message: 'Validation Error')));
          return addExpenseBloc;
        },
        act: (bloc) => bloc.add(AddExpenseSubmitEvent(expense: tAddExpenseEntity)),
        expect: () => [
          const AddExpenseLoading(),
          const AddExpenseError(message: 'Validation Error'),
        ],
        verify: (_) {
          verify(() => mockAddExpenseUseCase(any())).called(1);
          verifyNever(() => mockExpenseRefreshService.notifyExpenseRefresh());
        },
      );

      blocTest<AddExpenseBloc, AddExpenseState>(
        'should emit [AddExpenseLoading, AddExpenseError] when adding expense fails with LocalStorageFailure',
        build: () {
          when(() => mockAddExpenseUseCase(any()))
              .thenAnswer((_) async => Left(LocalStorageFailure(message: 'Storage Error')));
          return addExpenseBloc;
        },
        act: (bloc) => bloc.add(AddExpenseSubmitEvent(expense: tAddExpenseEntity)),
        expect: () => [
          const AddExpenseLoading(),
          const AddExpenseError(message: 'Storage Error'),
        ],
        verify: (_) {
          verify(() => mockAddExpenseUseCase(any())).called(1);
          verifyNever(() => mockExpenseRefreshService.notifyExpenseRefresh());
        },
      );
    });

    group('SaveReceiptEvent', () {
      const tImagePath = '/path/to/image.jpg';
      const tSavedPath = '/saved/path/image.jpg';

      blocTest<AddExpenseBloc, AddExpenseState>(
        'should emit [ReceiptSaving, ReceiptSaved] when saving receipt is successful',
        build: () {
          when(() => mockSaveReceiptUseCase(any()))
              .thenAnswer((_) async => const Right(tSavedPath));
          return addExpenseBloc;
        },
        act: (bloc) => bloc.add(const SaveReceiptEvent(imagePath: tImagePath, expenseId: '1')),
        expect: () => [
          const ReceiptSaving(),
          const ReceiptSaved(imagePath: tSavedPath),
        ],
        verify: (_) {
          verify(() => mockSaveReceiptUseCase(any())).called(1);
        },
      );

      blocTest<AddExpenseBloc, AddExpenseState>(
        'should emit [ReceiptSaving, ReceiptError] when saving receipt fails',
        build: () {
          when(() => mockSaveReceiptUseCase(any()))
              .thenAnswer((_) async => Left(LocalStorageFailure(message: 'Failed to save receipt')));
          return addExpenseBloc;
        },
        act: (bloc) => bloc.add(const SaveReceiptEvent(imagePath: tImagePath, expenseId: '1')),
        expect: () => [
          const ReceiptSaving(),
          const ReceiptError(message: 'Failed to save receipt'),
        ],
        verify: (_) {
          verify(() => mockSaveReceiptUseCase(any())).called(1);
        },
      );
    });

    group('ResetFormEvent', () {
      blocTest<AddExpenseBloc, AddExpenseState>(
        'should emit [AddExpenseFormWithCurrencyState] when resetting form',
        build: () => addExpenseBloc,
        act: (bloc) => bloc.add(const ResetFormEvent()),
        expect: () => [
          isA<AddExpenseFormWithCurrencyState>(),
        ],
      );
    });
  });
}