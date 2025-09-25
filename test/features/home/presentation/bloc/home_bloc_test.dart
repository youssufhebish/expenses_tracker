import 'package:bloc_test/bloc_test.dart';
import 'package:expenses_tracker_lite/core/error/failures.dart';
import 'package:expenses_tracker_lite/core/services/expense_refresh_service.dart';
import 'package:expenses_tracker_lite/features/home/domain/entities/expense_entity.dart';
import 'package:expenses_tracker_lite/features/home/domain/entities/pagination_entity.dart';
import 'package:expenses_tracker_lite/features/home/domain/usecases/get_expenses_usecase.dart';
import 'package:expenses_tracker_lite/features/home/domain/usecases/get_balance_usecase.dart';
import 'package:expenses_tracker_lite/features/home/presentation/bloc/home_bloc.dart';
import 'package:expenses_tracker_lite/features/home/presentation/bloc/home_event.dart';
import 'package:expenses_tracker_lite/features/home/presentation/bloc/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

// Mock classes
class MockGetExpensesUseCase extends Mock implements GetExpensesUseCase {}
class MockGetBalanceUseCase extends Mock implements GetBalanceUseCase {}
class MockGetIncomeUseCase extends Mock implements GetIncomeUseCase {}
class MockGetExpensesAmountUseCase extends Mock implements GetExpensesAmountUseCase {}
class MockExpenseRefreshService extends Mock implements ExpenseRefreshService {}

void main() {
  group('HomeBloc', () {
    late HomeBloc homeBloc;
    late MockGetExpensesUseCase mockGetExpensesUseCase;
    late MockGetBalanceUseCase mockGetBalanceUseCase;
    late MockGetIncomeUseCase mockGetIncomeUseCase;
    late MockGetExpensesAmountUseCase mockGetExpensesAmountUseCase;
    late MockExpenseRefreshService mockExpenseRefreshService;

    setUp(() {
      mockGetExpensesUseCase = MockGetExpensesUseCase();
      mockGetBalanceUseCase = MockGetBalanceUseCase();
      mockGetIncomeUseCase = MockGetIncomeUseCase();
      mockGetExpensesAmountUseCase = MockGetExpensesAmountUseCase();
      mockExpenseRefreshService = MockExpenseRefreshService();
      
      // Mock the expense refresh stream
      when(() => mockExpenseRefreshService.expenseRefreshStream)
          .thenAnswer((_) => Stream.value(true));
      
      homeBloc = HomeBloc(
        getExpensesUseCase: mockGetExpensesUseCase,
        getBalanceUseCase: mockGetBalanceUseCase,
        getIncomeUseCase: mockGetIncomeUseCase,
        getExpensesAmountUseCase: mockGetExpensesAmountUseCase,
        expenseRefreshService: mockExpenseRefreshService,
      );
    });

    tearDown(() {
      homeBloc.close();
    });

    test('initial state should be HomeInitial', () {
      expect(homeBloc.state, equals(const HomeInitial()));
    });

    group('LoadExpensesEvent', () {
      final tExpensesList = [
        ExpenseEntity(
          id: '1',
          category: 'Food',
          amount: 100.0,
          date: DateTime.now(),
          createdAt: DateTime.now(),
          categoryIcon: Icons.fastfood,
          categoryIconColor: Colors.red,
        ),
        ExpenseEntity(
          id: '2',
          category: 'Transport',
          amount: 200.0,
          date: DateTime.now(),
          createdAt: DateTime.now(),
          categoryIcon: Icons.directions_car,
          categoryIconColor: Colors.blue,
        ),
      ];

      final tPaginationEntity = PaginationEntity(
        expenses: tExpensesList,
        hasNextPage: true,
        currentPage: 0,
        totalPages: 5,
        totalItems: 50,
        hasPreviousPage: false,
      );

      blocTest<HomeBloc, HomeState>(
        'should emit [HomeLoading, HomeLoaded] when LoadExpensesEvent is successful',
        build: () {
          when(() => mockGetExpensesUseCase(any()))
              .thenAnswer((_) async => Right(tPaginationEntity));
          when(() => mockGetBalanceUseCase(startDate: any(named: 'startDate'), endDate: any(named: 'endDate')))
              .thenAnswer((_) async => const Right(1000.0));
          when(() => mockGetIncomeUseCase(startDate: any(named: 'startDate'), endDate: any(named: 'endDate')))
              .thenAnswer((_) async => const Right(2000.0));
          when(() => mockGetExpensesAmountUseCase(startDate: any(named: 'startDate'), endDate: any(named: 'endDate')))
              .thenAnswer((_) async => const Right(300.0));
          return homeBloc;
        },
        act: (bloc) => bloc.add(const LoadExpensesEvent()),
        expect: () => [
          const HomeLoading(),
          HomeLoaded(
            expenses: tExpensesList,
            totalBalance: 1000.0,
            totalIncome: 2000.0,
            totalExpenses: 300.0,
            hasReachedMax: false,
            currentPage: 0,
          ),
        ],
        verify: (_) {
          verify(() => mockGetExpensesUseCase(any())).called(1);
          verify(() => mockGetBalanceUseCase(startDate: any(named: 'startDate'), endDate: any(named: 'endDate'))).called(1);
          verify(() => mockGetIncomeUseCase(startDate: any(named: 'startDate'), endDate: any(named: 'endDate'))).called(1);
          verify(() => mockGetExpensesAmountUseCase(startDate: any(named: 'startDate'), endDate: any(named: 'endDate'))).called(1);
        },
      );

      blocTest<HomeBloc, HomeState>(
        'should emit [HomeLoading, HomeError] when LoadExpensesEvent fails',
        build: () {
          when(() => mockGetExpensesUseCase(any()))
              .thenAnswer((_) async => Left(LocalStorageFailure(message: 'Server Error')));
          return homeBloc;
        },
        act: (bloc) => bloc.add(const LoadExpensesEvent()),
        expect: () => [
          const HomeLoading(),
          const HomeError(message: 'Server Error'),
        ],
        verify: (_) {
          verify(() => mockGetExpensesUseCase(any())).called(1);
        },
      );
    });

    group('LoadMoreExpensesEvent', () {
      final tExpensesList = [
        ExpenseEntity(
          id: '1',
          category: 'Food',
          amount: 100.0,
          date: DateTime.now(),
          createdAt: DateTime.now(),
          categoryIcon: Icons.fastfood,
          categoryIconColor: Colors.red,
        ),
      ];

      final tSecondPageExpenses = [
        ExpenseEntity(
          id: '2',
          category: 'Transport',
          amount: 200.0,
          date: DateTime.now(),
          createdAt: DateTime.now(),
          categoryIcon: Icons.directions_car,
          categoryIconColor: Colors.blue,
        ),
      ];

      final tSecondPagePagination = PaginationEntity(
        expenses: tSecondPageExpenses,
        hasNextPage: false,
        currentPage: 1,
        totalPages: 2,
        totalItems: 2,
        hasPreviousPage: true,
      );

      blocTest<HomeBloc, HomeState>(
        'should emit [HomeLoaded] with combined expenses when loading more pages',
        build: () {
          when(() => mockGetExpensesUseCase(any()))
              .thenAnswer((_) async => Right(tSecondPagePagination));
          return homeBloc;
        },
        seed: () => HomeLoaded(
          expenses: tExpensesList,
          totalBalance: 1000.0,
          totalIncome: 2000.0,
          totalExpenses: 300.0,
          hasReachedMax: false,
          currentPage: 0,
        ),
        act: (bloc) => bloc.add(const LoadMoreExpensesEvent()),
        expect: () => [
          HomeLoaded(
            expenses: tExpensesList,
            totalBalance: 1000.0,
            totalIncome: 2000.0,
            totalExpenses: 300.0,
            hasReachedMax: false,
            currentPage: 0,
            isLoadingMore: true,
          ),
          HomeLoaded(
            expenses: [...tExpensesList, ...tSecondPageExpenses],
            totalBalance: 1000.0,
            totalIncome: 2000.0,
            totalExpenses: 300.0,
            hasReachedMax: true,
            currentPage: 1,
            isLoadingMore: false,
          ),
        ],
        verify: (_) {
          verify(() => mockGetExpensesUseCase(any())).called(1);
        },
      );

      blocTest<HomeBloc, HomeState>(
        'should not load more when hasReachedMax is true',
        build: () => homeBloc,
        seed: () => HomeLoaded(
          expenses: tExpensesList,
          totalBalance: 1000.0,
          totalIncome: 2000.0,
          totalExpenses: 300.0,
          hasReachedMax: true,
          currentPage: 1,
        ),
        act: (bloc) => bloc.add(const LoadMoreExpensesEvent()),
        expect: () => [],
        verify: (_) {
          verifyNever(() => mockGetExpensesUseCase(any()));
        },
      );
    });

    group('RefreshExpensesEvent', () {
      final tExpensesList = [
        ExpenseEntity(
          id: '1',
          category: 'Food',
          amount: 100.0,
          date: DateTime.now(),
          createdAt: DateTime.now(),
          categoryIcon: Icons.fastfood,
          categoryIconColor: Colors.red,
        ),
      ];

      final tPaginationEntity = PaginationEntity(
        expenses: tExpensesList,
        hasNextPage: false,
        currentPage: 0,
        totalPages: 1,
        totalItems: 1,
        hasPreviousPage: false,
      );

      blocTest<HomeBloc, HomeState>(
        'should emit [HomeLoading, HomeLoaded] when refreshing expenses',
        build: () {
          when(() => mockGetExpensesUseCase(any()))
              .thenAnswer((_) async => Right(tPaginationEntity));
          when(() => mockGetBalanceUseCase())
              .thenAnswer((_) async => const Right(1000.0));
          when(() => mockGetIncomeUseCase())
              .thenAnswer((_) async => const Right(2000.0));
          when(() => mockGetExpensesAmountUseCase())
              .thenAnswer((_) async => const Right(300.0));
          return homeBloc;
        },
        act: (bloc) => bloc.add(const RefreshExpensesEvent()),
        expect: () => [
          const HomeLoading(),
          HomeLoaded(
            expenses: tExpensesList,
            totalBalance: 1000.0,
            totalIncome: 2000.0,
            totalExpenses: 300.0,
            hasReachedMax: true,
            currentPage: 0,
          ),
        ],
        verify: (_) {
          verify(() => mockGetExpensesUseCase(any())).called(1);
        },
      );
    });
  });
}