import 'package:equatable/equatable.dart';
import 'expense_entity.dart';

/// Pagination entity for handling paginated expense data
/// Contains expenses list with pagination metadata
class PaginationEntity extends Equatable {
  final List<ExpenseEntity> expenses;
  final int currentPage;
  final int totalPages;
  final int totalItems;
  final bool hasNextPage;
  final bool hasPreviousPage;

  const PaginationEntity({
    required this.expenses,
    required this.currentPage,
    required this.totalPages,
    required this.totalItems,
    required this.hasNextPage,
    required this.hasPreviousPage,
  });

  @override
  List<Object?> get props => [
        expenses,
        currentPage,
        totalPages,
        totalItems,
        hasNextPage,
        hasPreviousPage,
      ];

  /// Creates a copy of this pagination with updated values
  PaginationEntity copyWith({
    List<ExpenseEntity>? expenses,
    int? currentPage,
    int? totalPages,
    int? totalItems,
    bool? hasNextPage,
    bool? hasPreviousPage,
  }) {
    return PaginationEntity(
      expenses: expenses ?? this.expenses,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      totalItems: totalItems ?? this.totalItems,
      hasNextPage: hasNextPage ?? this.hasNextPage,
      hasPreviousPage: hasPreviousPage ?? this.hasPreviousPage,
    );
  }

  /// Creates empty pagination
  static const PaginationEntity empty = PaginationEntity(
    expenses: [],
    currentPage: 0,
    totalPages: 0,
    totalItems: 0,
    hasNextPage: false,
    hasPreviousPage: false,
  );
}