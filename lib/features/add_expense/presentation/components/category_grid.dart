import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../../core/themes/colors.dart';
import '../../../../core/themes/fonts_manager.dart';
import '../../../../core/utils/category_icon_mapper.dart';
import '../../../../widgets/category_icon.dart';

/// Category model for expense and income categories
class ExpenseCategory {
  final String name;
  final IconData icon;
  final Color color;

  const ExpenseCategory({
    required this.name,
    required this.icon,
    required this.color,
  });
}

/// Category grid component for selecting expense and income categories
/// Displays predefined categories with icons in a grid layout based on income/expense toggle
class CategoryGrid extends StatelessWidget {
  final String? selectedCategory;
  final ValueChanged<ExpenseCategory> onCategorySelected;
  final bool isIncome; // New parameter to determine category type

  const CategoryGrid({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
    this.isIncome = false, // Default to expense categories
  });

  /// Gets categories based on income/expense type
  List<ExpenseCategory> get categories {
    final categoryNames = CategoryIconMapper.getAllCategories(isIncome: isIncome);
    return categoryNames.map((name) {
      final iconData = CategoryIconMapper.getIconAndColorForCategory(name, isIncome: isIncome);
      return ExpenseCategory(
        name: name,
        icon: iconData['icon'] as IconData,
        color: iconData['color'] as Color,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section title
        Text(
          isIncome ? 'Income Categories' : 'Expense Categories',
          style: TextStyle(
            color: theme.colorScheme.onSurface,
            fontSize: FontSizes.s18,
            fontWeight: FontWeights.semiBold,
          ),
        ),
        const SizedBox(height: 16),
        // Category grid with staggered animations
        AnimationLimiter(
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.8,
            ),
            itemCount: categories.length + 1, // +1 for "Add Category" button
            itemBuilder: (context, index) {
              return AnimationConfiguration.staggeredGrid(
                position: index,
                duration: const Duration(milliseconds: 375),
                columnCount: 4,
                child: ScaleAnimation(
                  child: FadeInAnimation(
                    child: _buildGridItem(index, theme),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  /// Builds grid item (category or add button) based on index
  Widget _buildGridItem(int index, ThemeData theme) {
    // Add Category button as last item
    if (index == categories.length) {
      return _buildAddCategoryButton(theme);
    }

    final category = categories[index];
    final isSelected = selectedCategory == category.name;

    return _buildCategoryItem(category, isSelected, theme);
  }

  /// Builds individual category item with icon and label
  Widget _buildCategoryItem(ExpenseCategory category, bool isSelected, ThemeData theme) {
    return AnimatedContainer(
      key: ValueKey(isSelected),
      duration: const Duration(milliseconds: 300),
      child: GestureDetector(
        onTap: () => onCategorySelected(category),
        child: Column(
          spacing: 8,
          children: [
            // Category icon container
            CategoryIcon(
              color: category.color,
              icon: category.icon,
              isSelected: isSelected,
            ),
            // Category label
            Text(
              category.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: theme.colorScheme.onSurface.withValues(alpha: isSelected ? 1.0 : 0.6),
                fontSize: FontSizes.s12,
                fontWeight: isSelected ? FontWeights.medium : FontWeights.regular,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  /// Builds "Add Category" button
  Widget _buildAddCategoryButton(ThemeData theme) {
    return GestureDetector(
      onTap: () {
        // Handle add category action
        // This could open a dialog or navigate to add category screen
      },
      child: Column(
        children: [
          // Add button container
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppColors.primaryColor,
                width: 2,
                style: BorderStyle.solid,
              ),
            ),
            child: const Icon(
              Icons.add,
              color: AppColors.primaryColor,
              size: 24,
            ),
          ),
          const SizedBox(height: 8),
          // Add category label
          Text(
            'Add Category',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              fontSize: FontSizes.s12,
              fontWeight: FontWeights.regular,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}