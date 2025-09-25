import 'package:flutter/material.dart';
import '../../../home/data/models/expense_model.dart';
import '../../../home/domain/entities/expense_entity.dart';
import '../../domain/entities/add_expense_entity.dart';

/// Model for adding expense data operations
/// Handles conversion between AddExpenseEntity and ExpenseModel
class AddExpenseModel extends AddExpenseEntity {
  const AddExpenseModel({
    required super.category,
    required super.amount,
    required super.date,
    super.receiptPath,
    required super.categoryIcon,
    required super.categoryIconColor,
    super.isIncome,
    super.currency,
  });

  /// Creates AddExpenseModel from AddExpenseEntity
  factory AddExpenseModel.fromEntity(AddExpenseEntity entity) {
    return AddExpenseModel(
      category: entity.category,
      amount: entity.amount,
      date: entity.date,
      receiptPath: entity.receiptPath,
      categoryIcon: entity.categoryIcon,
      categoryIconColor: entity.categoryIconColor,
      isIncome: entity.isIncome,
      currency: entity.currency,
    );
  }

  /// Converts AddExpenseModel to AddExpenseEntity
  AddExpenseEntity toEntity() {
    return AddExpenseEntity(
      category: category,
      amount: amount,
      date: date,
      receiptPath: receiptPath,
      categoryIcon: categoryIcon,
      categoryIconColor: categoryIconColor,
      isIncome: isIncome,
      currency: currency,
    );
  }

  /// Converts AddExpenseModel to ExpenseModel for storage
  /// Income amounts are stored as positive values
  ExpenseModel toExpenseModel() {
    final now = DateTime.now();
    final id = '${now.millisecondsSinceEpoch}_${category}_${amount}';
    
    return ExpenseModel(
      id: id,
      category: category,
      amount: amount.abs(), // Store all amounts as positive values
      date: date,
      receiptPath: receiptPath,
      createdAt: now,
      categoryIconCodePoint: categoryIcon.codePoint,
      categoryIconColorValue: categoryIconColor.value,
      isIncome: isIncome, // Track whether this is income or expense
    );
  }

  /// Creates a copy of this model with updated values
  @override
  AddExpenseModel copyWith({
    String? category,
    double? amount,
    DateTime? date,
    String? receiptPath,
    IconData? categoryIcon,
    Color? categoryIconColor,
    bool? isIncome,
    String? currency,
  }) {
    return AddExpenseModel(
      category: category ?? this.category,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      receiptPath: receiptPath ?? this.receiptPath,
      categoryIcon: categoryIcon ?? this.categoryIcon,
      categoryIconColor: categoryIconColor ?? this.categoryIconColor,
      isIncome: isIncome ?? this.isIncome,
      currency: currency ?? this.currency,
    );
  }
}