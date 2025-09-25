import 'package:equatable/equatable.dart';

/// Entity for currency conversion rates
/// Contains conversion rates for different currencies
class CurrencyConversionEntity extends Equatable {
  final Map<String, double> conversionRates;

  const CurrencyConversionEntity({
    required this.conversionRates,
  });

  @override
  List<Object?> get props => [conversionRates];

  /// Gets the conversion rate for a specific currency
  /// Returns 1.0 if currency is not found
  double getConversionRate(String currency) {
    return conversionRates[currency] ?? 1.0;
  }

  /// Gets list of available currencies
  List<String> get availableCurrencies => conversionRates.keys.toList();

  /// Converts amount from one currency to another
  /// Returns converted amount or original amount if currencies not found
  double convertAmount(double amount, String fromCurrency, String toCurrency) {
    final fromRate = getConversionRate(fromCurrency);
    final toRate = getConversionRate(toCurrency);
    
    if (fromRate == 1.0 && toRate == 1.0) {
      return amount; // No conversion needed or currencies not found
    }
    
    // Convert to base currency (USD) first, then to target currency
    final baseAmount = amount / fromRate;
    return baseAmount * toRate;
  }

  /// Creates a copy of this entity with updated values
  CurrencyConversionEntity copyWith({
    Map<String, double>? conversionRates,
  }) {
    return CurrencyConversionEntity(
      conversionRates: conversionRates ?? this.conversionRates,
    );
  }
}