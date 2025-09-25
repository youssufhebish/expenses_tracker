import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// Expense entity representing a single expense record
/// Contains all the core properties of an expense
class ExpenseEntity extends Equatable {
  final String id;
  final String category;
  final double amount;
  final DateTime date;
  final String? receiptPath;
  final DateTime createdAt;
  final IconData categoryIcon;
  final Color categoryIconColor;
  final bool isIncome; // Track if this is income or expense

  const ExpenseEntity({
    required this.id,
    required this.category,
    required this.amount,
    required this.date,
    this.receiptPath,
    required this.createdAt,
    required this.categoryIcon,
    required this.categoryIconColor,
    this.isIncome = false, // Default to expense
  });

  @override
  List<Object?> get props => [
        id,
        category,
        amount,
        date,
        receiptPath,
        createdAt,
        categoryIcon,
        categoryIconColor,
        isIncome,
      ];

  /// Creates a copy of this expense with updated values
  ExpenseEntity copyWith({
    String? id,
    String? category,
    double? amount,
    DateTime? date,
    String? receiptPath,
    DateTime? createdAt,
    IconData? categoryIcon,
    Color? categoryIconColor,
    bool? isIncome,
  }) {
    return ExpenseEntity(
      id: id ?? this.id,
      category: category ?? this.category,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      receiptPath: receiptPath ?? this.receiptPath,
      createdAt: createdAt ?? this.createdAt,
      categoryIcon: categoryIcon ?? this.categoryIcon,
      categoryIconColor: categoryIconColor ?? this.categoryIconColor,
      isIncome: isIncome ?? this.isIncome,
    );
  }
}