import 'package:flutter/material.dart';
import '../../../../core/configs/app_configs.dart';
import '../../../../core/themes/colors.dart';
import '../../../../core/themes/fonts_manager.dart';
import '../../../../core/utils/filter_period.dart';
import 'filter_period_dropdown.dart';

/// Header component displaying user greeting and time period selector
class HomeHeader extends StatelessWidget {
  final String userName;
  final FilterPeriod selectedPeriod;
  final Function(FilterPeriod)? onPeriodChanged;

  const HomeHeader({
    super.key,
    required this.userName,
    this.selectedPeriod = FilterPeriod.allTime,
    this.onPeriodChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      height: 300,
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primaryColor,
            AppColors.primaryDark,
          ],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: SafeArea(
        child: Row(
          children: [
            // User avatar and greeting
            Expanded(
              child: Row(
                children: [
                  // User avatar
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      image: DecorationImage(
                        image: NetworkImage(AppConfigs.userAvatar),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Greeting text
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Good Morning',
                          style: TextStyle(
                            fontSize: FontSizes.s14,
                            fontWeight: FontWeights.regular,
                            color: (theme.colorScheme.surface).withValues(alpha: 0.8),
                          ),
                        ),
                        Text(
                          userName,
                          style: TextStyle(
                            fontSize: FontSizes.s18,
                            fontWeight: FontWeights.semiBold,
                            color: theme.colorScheme.surface,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Time period selector
            FilterPeriodDropdown(
              selectedPeriod: selectedPeriod,
              onPeriodChanged: onPeriodChanged,
            ),
          ],
        ),
      ),
    );
  }
}