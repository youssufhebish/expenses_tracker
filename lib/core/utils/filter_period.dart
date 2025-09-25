/// Enum defining available time periods for filtering expenses
/// Used across the application to maintain consistency in filtering logic
enum FilterPeriod {
  /// Filter expenses from the last 7 days
  week('Last 7 days'),
  
  /// Filter expenses from the current month
  month('This month'),
  
  /// Show all expenses without time filtering
  allTime('All time');

  /// Human-readable display name for the filter period
  const FilterPeriod(this.displayName);

  /// The display name shown in UI components
  final String displayName;

  /// Get FilterPeriod from display name string
  /// Returns null if no matching period is found
  static FilterPeriod? fromDisplayName(String displayName) {
    for (final period in FilterPeriod.values) {
      if (period.displayName == displayName) {
        return period;
      }
    }
    return null;
  }

  /// Calculate the start date for the filter period
  /// Returns null for allTime period (no filtering)
  DateTime? getStartDate() {
    final now = DateTime.now();
    switch (this) {
      case FilterPeriod.week:
        return now.subtract(const Duration(days: 7));
      case FilterPeriod.month:
        return DateTime(now.year, now.month, 1);
      case FilterPeriod.allTime:
        return null;
    }
  }

  /// Calculate the end date for the filter period
  /// Returns null for allTime period (no filtering)
  DateTime? getEndDate() {
    final now = DateTime.now();
    switch (this) {
      case FilterPeriod.week:
      case FilterPeriod.month:
        return now;
      case FilterPeriod.allTime:
        return null;
    }
  }
}