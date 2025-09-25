import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/pagination_entity.dart';
import '../repositories/expense_repository.dart';

/// Use case for getting paginated expenses
/// Handles business logic for retrieving expenses with pagination and filtering
class GetExpensesUseCase {
  final ExpenseRepository repository;

  const GetExpensesUseCase(this.repository);

  /// Executes the use case to get paginated expenses with optional date filtering
  /// Returns either failure or paginated expense data
  Future<Either<Failure, PaginationEntity>> call(GetExpensesParams params) {
    return repository.getExpenses(
      page: params.page,
      limit: params.limit,
      startDate: params.startDate,
      endDate: params.endDate,
    );
  }
}

/// Parameters for getting expenses use case
class GetExpensesParams {
  final int page;
  final int limit;
  final DateTime? startDate;
  final DateTime? endDate;

  const GetExpensesParams({
    required this.page,
    this.limit = 10, // Default 10 items per page
    this.startDate,
    this.endDate,
  });
}