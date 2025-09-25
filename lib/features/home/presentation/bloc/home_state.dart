import 'package:equatable/equatable.dart';
import '../../domain/entities/expense_entity.dart';
import '../../../../core/utils/filter_period.dart';

/// Abstract base class for all home states
/// Defines the contract for home screen states
abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

/// Initial state when the home screen is first created
class HomeInitial extends HomeState {
  const HomeInitial();
}

/// State when expenses are being loaded
class HomeLoading extends HomeState {
  const HomeLoading();
}

/// State when expenses are successfully loaded
class HomeLoaded extends HomeState {
  final List<ExpenseEntity> expenses;
  final double totalBalance;
  final double totalIncome;
  final double totalExpenses;
  final bool hasReachedMax;
  final int currentPage;
  final bool isLoadingMore;
  final FilterPeriod currentFilter;

  const HomeLoaded({
    required this.expenses,
    required this.totalBalance,
    required this.totalIncome,
    required this.totalExpenses,
    required this.hasReachedMax,
    required this.currentPage,
    this.isLoadingMore = false,
    this.currentFilter = FilterPeriod.month,
  });

  @override
  List<Object?> get props => [
        expenses,
        totalBalance,
        totalIncome,
        totalExpenses,
        hasReachedMax,
        currentPage,
        isLoadingMore,
        currentFilter,
      ];

  /// Creates a copy of this state with updated values
  HomeLoaded copyWith({
    List<ExpenseEntity>? expenses,
    double? totalBalance,
    double? totalIncome,
    double? totalExpenses,
    bool? hasReachedMax,
    int? currentPage,
    bool? isLoadingMore,
    FilterPeriod? currentFilter,
  }) {
    return HomeLoaded(
      expenses: expenses ?? this.expenses,
      totalBalance: totalBalance ?? this.totalBalance,
      totalIncome: totalIncome ?? this.totalIncome,
      totalExpenses: totalExpenses ?? this.totalExpenses,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentPage: currentPage ?? this.currentPage,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      currentFilter: currentFilter ?? this.currentFilter,
    );
  }
}

/// State when there's an error loading expenses
class HomeError extends HomeState {
  final String message;

  const HomeError({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}