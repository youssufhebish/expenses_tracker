import 'package:flutter/material.dart';
import '../../../../core/themes/colors.dart';

/// Bottom navigation component with floating action button
class CustomBottomNavigation extends StatelessWidget {
  final int currentIndex;
  final Function(int)? onTap;
  final VoidCallback? onAddTap;

  const CustomBottomNavigation({
    super.key,
    this.currentIndex = 0,
    this.onTap,
    this.onAddTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      height: 90,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Bottom navigation bar
          Container(
            height: 70,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Home tab
                _buildNavItem(
                  context,
                  icon: Icons.home_filled,
                  index: 0,
                  isSelected: currentIndex == 0,
                ),
                // Statistics tab
                _buildNavItem(
                  context,
                  icon: Icons.bar_chart,
                  index: 1,
                  isSelected: currentIndex == 1,
                ),
                // Spacer for FAB
                const SizedBox(width: 60),
                // Calendar tab
                _buildNavItem(
                  context,
                  icon: Icons.calendar_today,
                  index: 2,
                  isSelected: currentIndex == 2,
                ),
                // Profile tab
                _buildNavItem(
                  context,
                  icon: Icons.person,
                  index: 3,
                  isSelected: currentIndex == 3,
                ),
              ],
            ),
          ),
          // Floating Action Button
          GestureDetector(
            onTap: onAddTap,
            child: Container(
              width: 60,
              height: 60,
              decoration: const BoxDecoration(
                color: AppColors.primaryColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.add,
                color: theme.colorScheme.surface,
                size: 28,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Helper method to build navigation item
  Widget _buildNavItem(
    BuildContext context, {
    required IconData icon,
    required int index,
    required bool isSelected,
  }) {
    final theme = Theme.of(context);
    
    return GestureDetector(
      onTap: () => onTap?.call(index),
      child: Container(
        padding: const EdgeInsets.all(12),
        child: Icon(
          icon,
          color: isSelected 
              ? AppColors.primaryColor
              : theme.colorScheme.onSurface,
          size: 32,
        ),
      ),
    );
  }
}