import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// Entity for adding a new expense
/// Contains all the required data for creating an expense
class AddExpenseEntity extends Equatable {
  final String category;
  final double amount;
  final DateTime date;
  final String? receiptPath;
  final IconData categoryIcon;
  final Color categoryIconColor;
  final bool isIncome; // Track if this is income or expense
  final String currency; // Currency for the expense

  const AddExpenseEntity({
    required this.category,
    required this.amount,
    required this.date,
    this.receiptPath,
    required this.categoryIcon,
    required this.categoryIconColor,
    this.isIncome = false, // Default to expense
    this.currency = 'USD', // Default currency
  });

  @override
  List<Object?> get props => [
        category,
        amount,
        date,
        receiptPath,
        categoryIcon,
        categoryIconColor,
        isIncome,
        currency,
      ];

  /// Creates a copy of this entity with updated values
  AddExpenseEntity copyWith({
    String? category,
    double? amount,
    DateTime? date,
    String? receiptPath,
    IconData? categoryIcon,
    Color? categoryIconColor,
    bool? isIncome,
    String? currency,
  }) {
    return AddExpenseEntity(
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