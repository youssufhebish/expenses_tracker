import 'package:equatable/equatable.dart';
import '../../../../core/utils/filter_period.dart';

/// Abstract base class for all home events
/// Defines the contract for home screen events
abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

/// Event to load initial expenses data
/// Triggered when the home screen is first loaded
class LoadExpensesEvent extends HomeEvent {
  const LoadExpensesEvent();
}

/// Event to load more expenses (pagination)
/// Triggered when user scrolls to the bottom of the list
class LoadMoreExpensesEvent extends HomeEvent {
  const LoadMoreExpensesEvent();
}

/// Event to refresh expenses data
/// Triggered when user pulls to refresh
class RefreshExpensesEvent extends HomeEvent {
  const RefreshExpensesEvent();
}

/// Event to load balance and totals
/// Triggered to update financial summary
class LoadBalanceEvent extends HomeEvent {
  const LoadBalanceEvent();
}

/// Event to change filter period
/// Triggered when user selects a different filter period
class ChangeFilterPeriodEvent extends HomeEvent {
  final FilterPeriod filterPeriod;

  const ChangeFilterPeriodEvent(this.filterPeriod);

  @override
  List<Object?> get props => [filterPeriod];
}