import 'package:hive/hive.dart';
import '../../../../core/error/failures.dart';
import '../models/expense_model.dart';

/// Abstract interface for expense local data source
/// Defines contracts for local storage operations
abstract class ExpenseLocalDataSource {
  /// Gets paginated expenses from local storage with optional date filtering
  Future<List<ExpenseModel>> getExpenses({
    required int page,
    required int limit,
    DateTime? startDate,
    DateTime? endDate,
  });

  /// Gets total count of expenses with optional date filtering
  Future<int> getTotalExpensesCount({
    DateTime? startDate,
    DateTime? endDate,
  });

  /// Adds a new expense to local storage
  Future<void> addExpense(ExpenseModel expense);

  /// Deletes an expense by ID
  Future<void> deleteExpense(String expenseId);

  /// Updates an existing expense
  Future<void> updateExpense(ExpenseModel expense);

  /// Gets all expenses with optional date filtering (for calculating totals)
  Future<List<ExpenseModel>> getAllExpenses({
    DateTime? startDate,
    DateTime? endDate,
  });
}

/// Implementation of ExpenseLocalDataSource using Hive
/// Handles all local storage operations for expenses
class ExpenseLocalDataSourceImpl implements ExpenseLocalDataSource {
  static const String _boxName = 'expenses';
  late Box<ExpenseModel> _expenseBox;

  /// Initializes the Hive box for expenses
  Future<void> init() async {
    try {
      _expenseBox = await Hive.openBox<ExpenseModel>(_boxName);
    } catch (e) {
      throw const LocalStorageFailure(
        message: 'Failed to initialize expense storage',
      );
    }
  }

  @override
  Future<List<ExpenseModel>> getExpenses({
    required int page,
    required int limit,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final allExpenses = _expenseBox.values.toList();
      
      // Filter by date range if provided
      List<ExpenseModel> filteredExpenses = allExpenses;
      if (startDate != null || endDate != null) {
        filteredExpenses = allExpenses.where((expense) {
          final expenseDate = expense.date;
          if (startDate != null && expenseDate.isBefore(startDate)) {
            return false;
          }
          if (endDate != null && expenseDate.isAfter(endDate)) {
            return false;
          }
          return true;
        }).toList();
      }
      
      // Sort by creation date (newest first)
      filteredExpenses.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      
      // Calculate pagination
      final startIndex = page * limit;
      final endIndex = (startIndex + limit).clamp(0, filteredExpenses.length);
      
      if (startIndex >= filteredExpenses.length) {
        return [];
      }
      
      return filteredExpenses.sublist(startIndex, endIndex);
    } catch (e) {
      throw const LocalStorageFailure(
        message: 'Failed to get expenses from storage',
      );
    }
  }

  @override
  Future<int> getTotalExpensesCount({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      if (startDate == null && endDate == null) {
        return _expenseBox.length;
      }
      
      final allExpenses = _expenseBox.values.toList();
      final filteredExpenses = allExpenses.where((expense) {
        final expenseDate = expense.date;
        if (startDate != null && expenseDate.isBefore(startDate)) {
          return false;
        }
        if (endDate != null && expenseDate.isAfter(endDate)) {
          return false;
        }
        return true;
      }).toList();
      
      return filteredExpenses.length;
    } catch (e) {
      throw const LocalStorageFailure(
        message: 'Failed to get expenses count',
      );
    }
  }

  @override
  Future<void> addExpense(ExpenseModel expense) async {
    try {
      await _expenseBox.put(expense.id, expense);
    } catch (e) {
      throw const LocalStorageFailure(
        message: 'Failed to add expense to storage',
      );
    }
  }

  @override
  Future<void> deleteExpense(String expenseId) async {
    try {
      await _expenseBox.delete(expenseId);
    } catch (e) {
      throw const LocalStorageFailure(
        message: 'Failed to delete expense from storage',
      );
    }
  }

  @override
  Future<void> updateExpense(ExpenseModel expense) async {
    try {
      await _expenseBox.put(expense.id, expense);
    } catch (e) {
      throw const LocalStorageFailure(
        message: 'Failed to update expense in storage',
      );
    }
  }

  @override
  Future<List<ExpenseModel>> getAllExpenses({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final allExpenses = _expenseBox.values.toList();
      
      if (startDate == null && endDate == null) {
        return allExpenses;
      }
      
      final filteredExpenses = allExpenses.where((expense) {
        final expenseDate = expense.date;
        if (startDate != null && expenseDate.isBefore(startDate)) {
          return false;
        }
        if (endDate != null && expenseDate.isAfter(endDate)) {
          return false;
        }
        return true;
      }).toList();
      
      return filteredExpenses;
    } catch (e) {
      throw const LocalStorageFailure(
        message: 'Failed to get all expenses from storage',
      );
    }
  }
}