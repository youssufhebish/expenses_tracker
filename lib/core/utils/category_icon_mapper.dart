import 'package:flutter/material.dart';

/// Utility class for mapping expense and income categories to their corresponding icons and colors
/// Provides consistent visual representation for different expense and income categories
class CategoryIconMapper {
  /// Map of expense category names to their corresponding icon data
  static const Map<String, IconData> _expenseCategoryIcons = {
    'Entertainment': Icons.movie,
    'Groceries': Icons.shopping_cart,
    'Transport': Icons.directions_car,
    'Shopping': Icons.shopping_bag,
    'Gas': Icons.local_gas_station,
    'Rent': Icons.home,
    'News Paper': Icons.newspaper,
    'Food': Icons.restaurant,
    'Health': Icons.local_hospital,
    'Education': Icons.school,
    'Utilities': Icons.electrical_services,
    'Travel': Icons.flight,
    'Clothing': Icons.checkroom,
    'Sports': Icons.sports_soccer,
    'Technology': Icons.computer,
    'Other': Icons.category,
  };

  /// Map of income category names to their corresponding icon data
  static const Map<String, IconData> _incomeCategoryIcons = {
    'Salary': Icons.work,
    'Freelance': Icons.laptop_mac,
    'Business': Icons.business,
    'Investment': Icons.trending_up,
    'Rental': Icons.apartment,
    'Bonus': Icons.card_giftcard,
    'Dividend': Icons.account_balance,
    'Interest': Icons.savings,
    'Pension': Icons.elderly,
    'Gift': Icons.redeem,
    'Refund': Icons.money_off,
    'Commission': Icons.handshake,
    'Royalty': Icons.copyright,
    'Grant': Icons.volunteer_activism,
    'Prize': Icons.emoji_events,
    'Other': Icons.category,
  };

  /// Map of expense category names to their corresponding colors
  static const Map<String, Color> _expenseCategoryColors = {
    'Entertainment': Colors.orange,
    'Groceries': Colors.blue,
    'Transport': Colors.purple,
    'Shopping': Colors.pink,
    'Gas': Colors.green,
    'Rent': Colors.brown,
    'News Paper': Colors.grey,
    'Food': Colors.red,
    'Health': Colors.teal,
    'Education': Colors.indigo,
    'Utilities': Colors.amber,
    'Travel': Colors.cyan,
    'Clothing': Colors.deepPurple,
    'Sports': Colors.lightGreen,
    'Technology': Colors.blueGrey,
    'Other': Colors.grey,
  };

  /// Map of income category names to their corresponding colors
  static const Map<String, Color> _incomeCategoryColors = {
    'Salary': Color(0xFF4CAF50), // Green
    'Freelance': Color(0xFF2196F3), // Blue
    'Business': Color(0xFF9C27B0), // Purple
    'Investment': Color(0xFF00BCD4), // Cyan
    'Rental': Color(0xFFFF9800), // Orange
    'Bonus': Color(0xFFE91E63), // Pink
    'Dividend': Color(0xFF3F51B5), // Indigo
    'Interest': Color(0xFF8BC34A), // Light Green
    'Pension': Color(0xFF795548), // Brown
    'Gift': Color(0xFFFF5722), // Deep Orange
    'Refund': Color(0xFF607D8B), // Blue Grey
    'Commission': Color(0xFF009688), // Teal
    'Royalty': Color(0xFFCDDC39), // Lime
    'Grant': Color(0xFFFFC107), // Amber
    'Prize': Color(0xFFFFEB3B), // Yellow
    'Other': Colors.grey,
  };

  /// Gets the icon for a given category based on income/expense type
  /// Returns default category icon if category is not found
  static IconData getIconForCategory(String category, {bool isIncome = false}) {
    if (isIncome) {
      return _incomeCategoryIcons[category] ?? Icons.category;
    } else {
      return _expenseCategoryIcons[category] ?? Icons.category;
    }
  }

  /// Gets the color for a given category based on income/expense type
  /// Returns default grey color if category is not found
  static Color getColorForCategory(String category, {bool isIncome = false}) {
    if (isIncome) {
      return _incomeCategoryColors[category] ?? Colors.grey;
    } else {
      return _expenseCategoryColors[category] ?? Colors.grey;
    }
  }

  /// Gets both icon and color for a given category based on income/expense type
  /// Returns a map with 'icon' and 'color' keys
  static Map<String, dynamic> getIconAndColorForCategory(String category, {bool isIncome = false}) {
    return {
      'icon': getIconForCategory(category, isIncome: isIncome),
      'color': getColorForCategory(category, isIncome: isIncome),
    };
  }

  /// Gets all available categories based on income/expense type
  static List<String> getAllCategories({bool isIncome = false}) {
    if (isIncome) {
      return _incomeCategoryIcons.keys.toList();
    } else {
      return _expenseCategoryIcons.keys.toList();
    }
  }

  /// Checks if a category has a custom icon mapping based on income/expense type
  static bool hasCustomIcon(String category, {bool isIncome = false}) {
    if (isIncome) {
      return _incomeCategoryIcons.containsKey(category);
    } else {
      return _expenseCategoryIcons.containsKey(category);
    }
  }
}