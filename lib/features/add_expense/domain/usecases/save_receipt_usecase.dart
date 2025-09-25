import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/add_expense_repository.dart';

/// Use case for saving receipt images
/// Handles business logic for receipt image storage
class SaveReceiptUseCase {
  final AddExpenseRepository repository;

  const SaveReceiptUseCase(this.repository);

  /// Executes the use case to save a receipt image
  /// Returns either failure or saved file path
  Future<Either<Failure, String>> call(SaveReceiptParams params) {
    return repository.saveReceiptImage(params.imagePath);
  }
}

/// Parameters for saving receipt use case
class SaveReceiptParams {
  final String imagePath;

  const SaveReceiptParams({
    required this.imagePath,
  });
}