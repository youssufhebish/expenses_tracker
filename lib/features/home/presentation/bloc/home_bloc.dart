import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import '../../../../core/services/expense_refresh_service.dart';
import '../../../../core/utils/filter_period.dart';
import '../../domain/usecases/get_expenses_usecase.dart';
import '../../domain/usecases/get_balance_usecase.dart';
import 'home_event.dart';
import 'home_state.dart';

/// Bloc for managing home screen state and business logic
/// Handles expenses loading, pagination, filtering, and financial calculations
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetExpensesUseCase getExpensesUseCase;
  final GetBalanceUseCase getBalanceUseCase;
  final GetIncomeUseCase getIncomeUseCase;
  final GetExpensesAmountUseCase getExpensesAmountUseCase;
  final ExpenseRefreshService expenseRefreshService;

  static const int _limit = 10; // Items per page
  FilterPeriod _currentFilter = FilterPeriod.month; // Current filter period
  
  // Stream subscription for expense refresh events
  StreamSubscription<bool>? _refreshSubscription;

  HomeBloc({
    required this.getExpensesUseCase,
    required this.getBalanceUseCase,
    required this.getIncomeUseCase,
    required this.getExpensesAmountUseCase,
    required this.expenseRefreshService,
  }) : super(const HomeInitial()) {
    // Register event handlers
    on<LoadExpensesEvent>(_onLoadExpenses);
    on<LoadMoreExpensesEvent>(_onLoadMoreExpenses);
    on<RefreshExpensesEvent>(_onRefreshExpenses);
    on<LoadBalanceEvent>(_onLoadBalance);
    on<ChangeFilterPeriodEvent>(_onChangeFilterPeriod);
    
    // Listen to expense refresh events
    _refreshSubscription = expenseRefreshService.expenseRefreshStream.listen((_) {
      add(const RefreshExpensesEvent());
    });
  }

  /// Handles changing filter period
  Future<void> _onChangeFilterPeriod(
    ChangeFilterPeriodEvent event,
    Emitter<HomeState> emit,
  ) async {
    _currentFilter = event.filterPeriod;
    // Reload data with new filter
    add(const LoadExpensesEvent());
  }

  /// Handles loading initial expenses data
  Future<void> _onLoadExpenses(
    LoadExpensesEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(const HomeLoading());

    try {
      // Get date range for current filter
      final startDate = _currentFilter.getStartDate();
      final endDate = _currentFilter.getEndDate();

      // Load expenses for first page with filtering
      final expensesResult = await getExpensesUseCase(
        GetExpensesParams(
          page: 0, 
          limit: _limit,
          startDate: startDate,
          endDate: endDate,
        ),
      );

      // Load financial data with filtering
      final balanceResult = await getBalanceUseCase(
        startDate: startDate,
        endDate: endDate,
      );
      final incomeResult = await getIncomeUseCase(
        startDate: startDate,
        endDate: endDate,
      );
      final expensesAmountResult = await getExpensesAmountUseCase(
        startDate: startDate,
        endDate: endDate,
      );

      // Handle results
      await expensesResult.fold(
        (failure) async {
          emit(HomeError(message: failure.message));
        },
        (paginationEntity) async {
          final balance = await balanceResult.fold(
            (failure) => 0.0,
            (balance) => balance,
          );

          final income = await incomeResult.fold(
            (failure) => 0.0,
            (income) => income,
          );

          final totalExpenses = await expensesAmountResult.fold(
            (failure) => 0.0,
            (expenses) => expenses,
          );

          emit(HomeLoaded(
            expenses: paginationEntity.expenses,
            totalBalance: balance,
            totalIncome: income,
            totalExpenses: totalExpenses,
            hasReachedMax: !paginationEntity.hasNextPage,
            currentPage: paginationEntity.currentPage,
            currentFilter: _currentFilter,
          ));
        },
      );
    } catch (e) {
      emit(const HomeError(message: 'Failed to load expenses'));
    }
  }

  /// Handles loading more expenses for pagination
  Future<void> _onLoadMoreExpenses(
    LoadMoreExpensesEvent event,
    Emitter<HomeState> emit,
  ) async {
    final currentState = state;
    if (currentState is! HomeLoaded || currentState.hasReachedMax) {
      return;
    }

    // Show loading indicator for pagination
    emit(currentState.copyWith(isLoadingMore: true));

    try {
      // Get date range for current filter
      final startDate = _currentFilter.getStartDate();
      final endDate = _currentFilter.getEndDate();

      final nextPage = currentState.currentPage + 1;
      final result = await getExpensesUseCase(
        GetExpensesParams(
          page: nextPage, 
          limit: _limit,
          startDate: startDate,
          endDate: endDate,
        ),
      );

      await result.fold(
        (failure) async {
          // Revert loading state on error
          emit(currentState.copyWith(isLoadingMore: false));
        },
        (paginationEntity) async {
          final updatedExpenses = [
            ...currentState.expenses,
            ...paginationEntity.expenses,
          ];

          emit(currentState.copyWith(
            expenses: updatedExpenses,
            hasReachedMax: !paginationEntity.hasNextPage,
            currentPage: nextPage,
            isLoadingMore: false,
          ));
        },
      );
    } catch (e) {
      emit(currentState.copyWith(isLoadingMore: false));
    }
  }

  /// Handles refreshing expenses data
  Future<void> _onRefreshExpenses(
    RefreshExpensesEvent event,
    Emitter<HomeState> emit,
  ) async {
    // Reset to first page and reload
    add(const LoadExpensesEvent());
  }

  /// Handles loading balance and financial data
  Future<void> _onLoadBalance(
    LoadBalanceEvent event,
    Emitter<HomeState> emit,
  ) async {
    final currentState = state;
    if (currentState is! HomeLoaded) {
      return;
    }

    try {
      // Get date range for current filter
      final startDate = _currentFilter.getStartDate();
      final endDate = _currentFilter.getEndDate();

      final balanceResult = await getBalanceUseCase(
        startDate: startDate,
        endDate: endDate,
      );
      final incomeResult = await getIncomeUseCase(
        startDate: startDate,
        endDate: endDate,
      );
      final expensesAmountResult = await getExpensesAmountUseCase(
        startDate: startDate,
        endDate: endDate,
      );

      final balance = await balanceResult.fold(
        (failure) => currentState.totalBalance,
        (balance) => balance,
      );

      final income = await incomeResult.fold(
        (failure) => currentState.totalIncome,
        (income) => income,
      );

      final totalExpenses = await expensesAmountResult.fold(
        (failure) => currentState.totalExpenses,
        (expenses) => expenses,
      );

      emit(currentState.copyWith(
        totalBalance: balance,
        totalIncome: income,
        totalExpenses: totalExpenses,
      ));
    } catch (e) {
      // Keep current state on error
    }
  }

  @override
  Future<void> close() {
    _refreshSubscription?.cancel();
    return super.close();
  }
}