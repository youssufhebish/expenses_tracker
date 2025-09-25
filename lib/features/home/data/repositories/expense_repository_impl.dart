import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/expense_entity.dart';
import '../../domain/entities/pagination_entity.dart';
import '../../domain/repositories/expense_repository.dart';
import '../datasources/expense_local_datasource.dart';
import '../models/expense_model.dart';

/// Implementation of ExpenseRepository
/// Handles data operations and error handling for expenses
class ExpenseRepositoryImpl implements ExpenseRepository {
  final ExpenseLocalDataSource localDataSource;

  const ExpenseRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, PaginationEntity>> getExpenses({
    required int page,
    required int limit,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      // Get paginated expenses with date filtering
      final expenses = await localDataSource.getExpenses(
        page: page,
        limit: limit,
        startDate: startDate,
        endDate: endDate,
      );

      // Get total count for pagination metadata with same filtering
      final totalCount = await localDataSource.getTotalExpensesCount(
        startDate: startDate,
        endDate: endDate,
      );
      final totalPages = (totalCount / limit).ceil();

      // Convert models to entities
      final expenseEntities = expenses
          .map((model) => model.toEntity())
          .toList();

      // Create pagination entity
      final paginationEntity = PaginationEntity(
        expenses: expenseEntities,
        currentPage: page,
        totalPages: totalPages,
        totalItems: totalCount,
        hasNextPage: page < totalPages - 1,
        hasPreviousPage: page > 0,
      );

      return Right(paginationEntity);
    } catch (e) {
      if (e is Failure) {
        return Left(e);
      }
      return const Left(LocalStorageFailure(message: 'Failed to get expenses'));
    }
  }

  @override
  Future<Either<Failure, double>> getTotalBalance({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final totalIncome = await _calculateTotalIncome(
        startDate: startDate,
        endDate: endDate,
      );
      final totalExpenses = await _calculateTotalExpenses(
        startDate: startDate,
        endDate: endDate,
      );
      return Right(totalIncome - totalExpenses);
    } catch (e) {
      if (e is Failure) {
        return Left(e);
      }
      return const Left(
        LocalStorageFailure(message: 'Failed to calculate total balance'),
      );
    }
  }

  @override
  Future<Either<Failure, double>> getTotalIncome({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final totalIncome = await _calculateTotalIncome(
        startDate: startDate,
        endDate: endDate,
      );
      return Right(totalIncome);
    } catch (e) {
      return const Left(
        LocalStorageFailure(message: 'Failed to calculate total income'),
      );
    }
  }

  @override
  Future<Either<Failure, double>> getTotalExpenses({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final totalExpenses = await _calculateTotalExpenses(
        startDate: startDate,
        endDate: endDate,
      );
      return Right(totalExpenses);
    } catch (e) {
      if (e is Failure) {
        return Left(e);
      }
      return const Left(
        LocalStorageFailure(message: 'Failed to calculate total expenses'),
      );
    }
  }

  @override
  Future<Either<Failure, void>> addExpense(ExpenseEntity expense) async {
    try {
      final expenseModel = ExpenseModel.fromEntity(expense);
      await localDataSource.addExpense(expenseModel);
      return const Right(null);
    } catch (e) {
      if (e is Failure) {
        return Left(e);
      }
      return const Left(LocalStorageFailure(message: 'Failed to add expense'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteExpense(String expenseId) async {
    try {
      await localDataSource.deleteExpense(expenseId);
      return const Right(null);
    } catch (e) {
      if (e is Failure) {
        return Left(e);
      }
      return const Left(
        LocalStorageFailure(message: 'Failed to delete expense'),
      );
    }
  }

  @override
  Future<Either<Failure, void>> updateExpense(ExpenseEntity expense) async {
    try {
      final expenseModel = ExpenseModel.fromEntity(expense);
      await localDataSource.updateExpense(expenseModel);
      return const Right(null);
    } catch (e) {
      if (e is Failure) {
        return Left(e);
      }
      return const Left(
        LocalStorageFailure(message: 'Failed to update expense'),
      );
    }
  }

  /// Helper method to calculate total expenses
  Future<double> _calculateTotalExpenses({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final allExpenses = await localDataSource.getAllExpenses(
      startDate: startDate,
      endDate: endDate,
    );
    return allExpenses
        .where((expense) => !expense.isIncome) // Only count expenses
        .fold<double>(0.0, (sum, expense) => sum + expense.amount);
  }

  /// Helper method to calculate total income
  Future<double> _calculateTotalIncome({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final allExpenses = await localDataSource.getAllExpenses(
      startDate: startDate,
      endDate: endDate,
    );
    return allExpenses
        .where((expense) => expense.isIncome) // Only count income
        .fold<double>(0.0, (sum, expense) => sum + expense.amount);
  }
}
