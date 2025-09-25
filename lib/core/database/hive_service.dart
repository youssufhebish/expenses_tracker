import 'package:hive_flutter/hive_flutter.dart';
import '../../features/home/data/models/expense_model.dart';

/// Service class for managing Hive database operations
/// Handles initialization and registration of Hive adapters
class HiveService {
  static const String _expensesBoxName = 'expenses';

  /// Initializes Hive database
  /// Registers adapters and opens required boxes
  static Future<void> init() async {
    // Initialize Hive for Flutter
    await Hive.initFlutter();

    // Register adapters
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(ExpenseModelAdapter());
    }

    // Open boxes
    await Hive.openBox<ExpenseModel>(_expensesBoxName);
  }

  /// Gets the expenses box
  static Box<ExpenseModel> get expensesBox {
    return Hive.box<ExpenseModel>(_expensesBoxName);
  }

  /// Closes all Hive boxes
  static Future<void> close() async {
    await Hive.close();
  }

  /// Clears all data (for testing purposes)
  static Future<void> clearAllData() async {
    final expensesBox = Hive.box<ExpenseModel>(_expensesBoxName);
    await expensesBox.clear();
  }
}