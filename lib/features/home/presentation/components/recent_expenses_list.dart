import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../domain/entities/expense_entity.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import 'empty_state_widget.dart';
import 'expense_item_widget.dart';

/// Widget that displays a scrollable list of recent expenses
/// Shows expense items with icons, categories, amounts, and dates
/// Handles pagination through scroll events
class RecentExpensesList extends HookWidget {
  final List<ExpenseEntity> expenses;
  final VoidCallback? onSeeAllTap;

  const RecentExpensesList({
    super.key,
    required this.expenses,
    this.onSeeAllTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Initialize scroll controller using hook
    final scrollController = useScrollController();

    // Handle scroll events for pagination
    void onScroll() {
      if (!scrollController.hasClients) return;
      final maxScroll = scrollController.position.maxScrollExtent;
      final currentScroll = scrollController.offset;
      final isBottom = currentScroll >= (maxScroll * 0.9);

      if (isBottom) {
        context.read<HomeBloc>().add(const LoadMoreExpensesEvent());
      }
    }

    // Add scroll listener using hook
    useEffect(() {
      scrollController.addListener(onScroll);
      return () => scrollController.removeListener(onScroll);
    }, [scrollController]);

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header with title and "See All" button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent Expenses',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                if (onSeeAllTap != null)
                  TextButton(
                    onPressed: onSeeAllTap,
                    child: Text(
                      'See All',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),

            // Scrollable expenses list with staggered animations
            if (expenses.isEmpty)
              const EmptyStateWidget()
            else
              Expanded(
                child: AnimationLimiter(
                  child: ListView.builder(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    controller: scrollController,
                    itemCount: expenses.length,
                    itemBuilder: (context, index) {
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 375),
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                            child: ExpenseItemWidget(expense: expenses[index]),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
