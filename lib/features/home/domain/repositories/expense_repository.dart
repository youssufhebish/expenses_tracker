import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/expense_entity.dart';
import '../entities/pagination_entity.dart';

/// Abstract repository interface for expense operations
/// Defines contracts for expense data operations
abstract class ExpenseRepository {
  /// Gets paginated expenses from local storage with optional date filtering
  /// Returns either failure or paginated expense data
  Future<Either<Failure, PaginationEntity>> getExpenses({
    required int page,
    required int limit,
    DateTime? startDate,
    DateTime? endDate,
  });

  /// Gets total balance (income - expenses) with optional date filtering
  /// Returns either failure or balance amount
  Future<Either<Failure, double>> getTotalBalance({
    DateTime? startDate,
    DateTime? endDate,
  });

  /// Gets total income amount with optional date filtering
  /// Returns either failure or income amount
  Future<Either<Failure, double>> getTotalIncome({
    DateTime? startDate,
    DateTime? endDate,
  });

  /// Gets total expenses amount with optional date filtering
  /// Returns either failure or expenses amount
  Future<Either<Failure, double>> getTotalExpenses({
    DateTime? startDate,
    DateTime? endDate,
  });

  /// Adds a new expense to local storage
  /// Returns either failure or success
  Future<Either<Failure, void>> addExpense(ExpenseEntity expense);

  /// Deletes an expense by ID
  /// Returns either failure or success
  Future<Either<Failure, void>> deleteExpense(String expenseId);

  /// Updates an existing expense
  /// Returns either failure or success
  Future<Either<Failure, void>> updateExpense(ExpenseEntity expense);
}