import 'package:flutter/material.dart';
import '../../../../core/themes/colors.dart';
import '../../../../core/themes/fonts_manager.dart';
import '../../../../core/utils/filter_period.dart';

/// Custom dropdown widget for selecting filter periods
/// Styled to match the provided design with rounded corners and custom appearance
class FilterPeriodDropdown extends StatelessWidget {
  final FilterPeriod selectedPeriod;
  final Function(FilterPeriod)? onPeriodChanged;

  const FilterPeriodDropdown({
    super.key,
    required this.selectedPeriod,
    this.onPeriodChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: theme.colorScheme.surface.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<FilterPeriod>(
          value: selectedPeriod,
          dropdownColor: AppColors.primaryDark,
          isDense: true,
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: theme.colorScheme.surface,
            size: 16,
          ),
          style: TextStyle(
            fontSize: FontSizes.s14,
            fontWeight: FontWeights.medium,
            color: theme.colorScheme.surface,
          ),
          items: FilterPeriod.values.map((FilterPeriod period) {
            return DropdownMenuItem<FilterPeriod>(
              value: period,
              child: Text(
                period.displayName,
                style: TextStyle(
                  fontSize: FontSizes.s14,
                  fontWeight: FontWeights.medium,
                  color: theme.colorScheme.surface,
                ),
              ),
            );
          }).toList(),
          onChanged: (FilterPeriod? newValue) {
            if (newValue != null && onPeriodChanged != null) {
              onPeriodChanged!(newValue);
            }
          },
        ),
      ),
    );
  }
}