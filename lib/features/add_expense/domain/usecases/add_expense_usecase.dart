import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/add_expense_entity.dart';
import '../repositories/add_expense_repository.dart';

/// Use case for adding a new expense
/// Handles business logic for expense creation
class AddExpenseUseCase {
  final AddExpenseRepository repository;

  const AddExpenseUseCase(this.repository);

  /// Executes the use case to add a new expense
  /// Returns either failure or success
  Future<Either<Failure, void>> call(AddExpenseParams params) async {
    // First validate the expense data
    final validationResult = repository.validateExpense(params.expense);
    if (validationResult.isLeft()) {
      return validationResult;
    }

    // Add the expense
    return await repository.addExpense(params.expense);
  }
}

/// Parameters for adding expense use case
class AddExpenseParams {
  final AddExpenseEntity expense;

  const AddExpenseParams({
    required this.expense,
  });
}