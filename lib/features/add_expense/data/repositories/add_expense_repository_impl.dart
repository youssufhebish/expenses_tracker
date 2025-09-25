import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/add_expense_entity.dart';
import '../../domain/repositories/add_expense_repository.dart';
import '../datasources/add_expense_local_datasource.dart';
import '../models/add_expense_model.dart';

/// Implementation of AddExpenseRepository
/// Handles data operations and error handling for adding expenses
class AddExpenseRepositoryImpl implements AddExpenseRepository {
  final AddExpenseLocalDataSource localDataSource;

  const AddExpenseRepositoryImpl({
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, void>> addExpense(AddExpenseEntity expense) async {
    try {
      // Convert entity to model
      final expenseModel = AddExpenseModel.fromEntity(expense);
      
      // Convert to storage model and add to local storage
      final storageModel = expenseModel.toExpenseModel();
      await localDataSource.addExpense(storageModel);
      
      return const Right(null);
    } catch (e) {
      if (e is Failure) {
        return Left(e);
      }
      return const Left(
        LocalStorageFailure(
          message: 'Failed to add expense',
        ),
      );
    }
  }

  @override
  Either<Failure, void> validateExpense(AddExpenseEntity expense) {
    try {
      // Validate category
      if (expense.category.trim().isEmpty) {
        return const Left(
          ValidationFailure(
            message: 'Category cannot be empty',
          ),
        );
      }

      // Validate amount
      if (expense.amount <= 0) {
        return const Left(
          ValidationFailure(
            message: 'Amount must be greater than zero',
          ),
        );
      }

      // Validate date (should not be in the future)
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final expenseDate = DateTime(
        expense.date.year,
        expense.date.month,
        expense.date.day,
      );
      
      if (expenseDate.isAfter(today)) {
        return const Left(
          ValidationFailure(
            message: 'Expense date cannot be in the future',
          ),
        );
      }

      return const Right(null);
    } catch (e) {
      return const Left(
        ValidationFailure(
          message: 'Failed to validate expense data',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, String>> saveReceiptImage(String imagePath) async {
    try {
      final savedPath = await localDataSource.saveReceiptImage(imagePath);
      return Right(savedPath);
    } catch (e) {
      if (e is Failure) {
        return Left(e);
      }
      return const Left(
        LocalStorageFailure(
          message: 'Failed to save receipt image',
        ),
      );
    }
  }
}