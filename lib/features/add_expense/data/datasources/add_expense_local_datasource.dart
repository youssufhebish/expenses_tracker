import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import '../../../../core/error/failures.dart';
import '../../../home/data/datasources/expense_local_datasource.dart';
import '../../../home/data/models/expense_model.dart';

/// Abstract interface for add expense local data source
/// Defines contracts for adding expense operations
abstract class AddExpenseLocalDataSource {
  /// Adds a new expense to local storage
  Future<void> addExpense(ExpenseModel expense);

  /// Saves receipt image to local storage
  Future<String> saveReceiptImage(String imagePath);
}

/// Implementation of AddExpenseLocalDataSource
/// Handles local storage operations for adding expenses
class AddExpenseLocalDataSourceImpl implements AddExpenseLocalDataSource {
  final ExpenseLocalDataSource expenseLocalDataSource;

  const AddExpenseLocalDataSourceImpl({
    required this.expenseLocalDataSource,
  });

  @override
  Future<void> addExpense(ExpenseModel expense) async {
    try {
      await expenseLocalDataSource.addExpense(expense);
    } catch (e) {
      throw const LocalStorageFailure(
        message: 'Failed to add expense to storage',
      );
    }
  }

  @override
  Future<String> saveReceiptImage(String imagePath) async {
    try {
      // Get application documents directory
      final appDir = await getApplicationDocumentsDirectory();
      final receiptsDir = Directory(path.join(appDir.path, 'receipts'));
      
      // Create receipts directory if it doesn't exist
      if (!await receiptsDir.exists()) {
        await receiptsDir.create(recursive: true);
      }

      // Generate unique filename
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final extension = path.extension(imagePath);
      final fileName = 'receipt_$timestamp$extension';
      final newPath = path.join(receiptsDir.path, fileName);

      // Copy the image to the receipts directory
      final sourceFile = File(imagePath);
      final targetFile = await sourceFile.copy(newPath);

      return targetFile.path;
    } catch (e) {
      throw const LocalStorageFailure(
        message: 'Failed to save receipt image',
      );
    }
  }
}