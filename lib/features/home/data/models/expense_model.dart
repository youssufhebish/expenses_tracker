import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/expense_entity.dart';

part 'expense_model.g.dart';

/// Hive model for expense data storage
/// Extends ExpenseEntity and adds Hive annotations for local storage
@HiveType(typeId: 0)
class ExpenseModel extends ExpenseEntity {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String category;

  @HiveField(2)
  final double amount;

  @HiveField(3)
  final DateTime date;

  @HiveField(4)
  final String? receiptPath;

  @HiveField(5)
  final DateTime createdAt;

  @HiveField(6)
  final int categoryIconCodePoint;

  @HiveField(7)
  final int categoryIconColorValue;

  @HiveField(8)
  final bool isIncome; // Track if this is income or expense

  ExpenseModel({
    required this.id,
    required this.category,
    required this.amount,
    required this.date,
    this.receiptPath,
    required this.createdAt,
    required this.categoryIconCodePoint,
    required this.categoryIconColorValue,
    this.isIncome = false, // Default to expense
  }) : super(
          id: id,
          category: category,
          amount: amount,
          date: date,
          receiptPath: receiptPath,
          createdAt: createdAt,
          categoryIcon: IconData(categoryIconCodePoint, fontFamily: 'MaterialIcons'),
          categoryIconColor: Color(categoryIconColorValue),
          isIncome: isIncome,
        );

  /// Creates ExpenseModel from ExpenseEntity
  factory ExpenseModel.fromEntity(ExpenseEntity entity) {
    return ExpenseModel(
      id: entity.id,
      category: entity.category,
      amount: entity.amount,
      date: entity.date,
      receiptPath: entity.receiptPath,
      createdAt: entity.createdAt,
      categoryIconCodePoint: entity.categoryIcon.codePoint,
      categoryIconColorValue: entity.categoryIconColor.value,
      isIncome: entity.isIncome,
    );
  }

  /// Converts ExpenseModel to ExpenseEntity
  ExpenseEntity toEntity() {
    return ExpenseEntity(
      id: id,
      category: category,
      amount: amount,
      date: date,
      receiptPath: receiptPath,
      createdAt: createdAt,
      categoryIcon: IconData(categoryIconCodePoint, fontFamily: 'MaterialIcons'),
      categoryIconColor: Color(categoryIconColorValue),
      isIncome: isIncome,
    );
  }

  /// Creates a copy of ExpenseModel with updated values
  @override
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
    return ExpenseModel(
      id: id ?? this.id,
      category: category ?? this.category,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      receiptPath: receiptPath ?? this.receiptPath,
      createdAt: createdAt ?? this.createdAt,
      categoryIconCodePoint: categoryIcon?.codePoint ?? categoryIconCodePoint,
      categoryIconColorValue: categoryIconColor?.value ?? categoryIconColorValue,
      isIncome: isIncome ?? this.isIncome,
    );
  }
}