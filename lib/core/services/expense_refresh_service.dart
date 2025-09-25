import 'dart:async';

/// Service to handle expense refresh notifications across the app
/// Provides a way for different features to communicate expense updates
class ExpenseRefreshService {
  static final ExpenseRefreshService _instance = ExpenseRefreshService._internal();
  
  factory ExpenseRefreshService() => _instance;
  
  ExpenseRefreshService._internal();

  // Stream controller for expense refresh events
  final StreamController<bool> _expenseRefreshController = StreamController<bool>.broadcast();

  /// Stream that emits when expenses should be refreshed
  Stream<bool> get expenseRefreshStream => _expenseRefreshController.stream;

  /// Notify that expenses should be refreshed
  /// Call this after successfully adding, updating, or deleting an expense
  void notifyExpenseRefresh() {
    if (!_expenseRefreshController.isClosed) {
      _expenseRefreshController.add(true);
    }
  }

  /// Dispose the service and close streams
  void dispose() {
    _expenseRefreshController.close();
  }
}