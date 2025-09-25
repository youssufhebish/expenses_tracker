import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/add_expense_entity.dart';

/// Abstract repository interface for adding expenses
/// Defines contracts for expense creation operations
abstract class AddExpenseRepository {
  /// Adds a new expense to local storage
  /// Returns either failure or success
  Future<Either<Failure, void>> addExpense(AddExpenseEntity expense);

  /// Validates expense data before adding
  /// Returns either failure or success
  Either<Failure, void> validateExpense(AddExpenseEntity expense);

  /// Saves receipt image to local storage
  /// Returns either failure or file path
  Future<Either<Failure, String>> saveReceiptImage(String imagePath);
}