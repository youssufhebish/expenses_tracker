import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/expense_repository.dart';

/// Use case for getting total balance
/// Handles business logic for calculating total balance with optional date filtering
class GetBalanceUseCase {
  final ExpenseRepository repository;

  const GetBalanceUseCase(this.repository);

  /// Executes the use case to get total balance with optional date filtering
  /// Returns either failure or balance amount
  Future<Either<Failure, double>> call({
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return repository.getTotalBalance(
      startDate: startDate,
      endDate: endDate,
    );
  }
}

/// Use case for getting total income
/// Handles business logic for calculating total income with optional date filtering
class GetIncomeUseCase {
  final ExpenseRepository repository;

  const GetIncomeUseCase(this.repository);

  /// Executes the use case to get total income with optional date filtering
  /// Returns either failure or income amount
  Future<Either<Failure, double>> call({
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return repository.getTotalIncome(
      startDate: startDate,
      endDate: endDate,
    );
  }
}

/// Use case for getting total expenses
/// Handles business logic for calculating total expenses with optional date filtering
class GetExpensesAmountUseCase {
  final ExpenseRepository repository;

  const GetExpensesAmountUseCase(this.repository);

  /// Executes the use case to get total expenses with optional date filtering
  /// Returns either failure or expenses amount
  Future<Either<Failure, double>> call({
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return repository.getTotalExpenses(
      startDate: startDate,
      endDate: endDate,
    );
  }
}