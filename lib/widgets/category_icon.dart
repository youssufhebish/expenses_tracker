import 'package:flutter/material.dart';

/// A reusable widget for displaying category icons with customizable appearance
/// Supports selected/unselected states with different visual styles
class CategoryIcon extends StatelessWidget {
  /// The icon to display
  final IconData icon;
  
  /// The color associated with the category
  final Color color;
  
  /// Whether this category icon is currently selected
  final bool isSelected;

  const CategoryIcon({
    super.key,
    required this.icon,
    required this.color,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        // Background color: full color when selected, transparent when not
        color: isSelected ? color : color.withValues(alpha: 0.1),
        shape: BoxShape.circle,
        // Border: visible when selected
        border: isSelected
            ? Border.all(color: color, width: 2)
            : null,
      ),
      child: Icon(
        icon,
        // Icon color: white when selected, category color when not
        color: isSelected ? Colors.white : color,
      ),
    );
  }
}
