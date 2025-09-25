import 'package:expenses_tracker_lite/core/configs/app_configs.dart';
import 'package:expenses_tracker_lite/widgets/error_message_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../widgets/app_loader.dart';
import '../../../../core/utils/filter_period.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';
import 'home_header.dart';
import 'balance_card.dart';
import 'recent_expenses_list.dart';

/// Home screen body component
class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: () async {
            context.read<HomeBloc>().add(const RefreshExpensesEvent());
          },
          child: _buildContent(context, state),
        );
      },
    );
  }

  /// Build content based on current state
  Widget _buildContent(BuildContext context, HomeState state) {

    if (state is HomeLoading) {
      return const AppLoader();
    }

    if (state is HomeError) {
      return ErrorMessageWidget(
        message: state.message,
        onRetry: () {
          context.read<HomeBloc>().add(const LoadExpensesEvent());
        },
      );
    }

    if (state is HomeLoaded) {
      return Column(
        spacing: 20,
        children: [
          // Header with user greeting and time selector
          Stack(
            children: [
              HomeHeader(
                userName: AppConfigs.userName,
                selectedPeriod: state.currentFilter,
                onPeriodChanged: (FilterPeriod newPeriod) {
                   context.read<HomeBloc>().add(
                     ChangeFilterPeriodEvent(newPeriod),
                   );
                 },
              ),
              // Balance card with real data
              BalanceCard(
                totalBalance: state.totalBalance,
                income: state.totalIncome,
                expenses: state.totalExpenses,
              ),
            ],
          ),
          // Main content area with scrollable expenses list
          RecentExpensesList(
            expenses: state.expenses,
            onSeeAllTap: () {
              // Handle see all tap
            },
          ),
        ],
      );
    }

    // Default fallback
    return const SizedBox.shrink();
  }
}
