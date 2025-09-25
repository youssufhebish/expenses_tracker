import '../../domain/entities/currency_conversion_entity.dart';

/// Model for currency conversion API response
/// Handles JSON parsing and conversion to entity
class CurrencyConversionModel extends CurrencyConversionEntity {
  const CurrencyConversionModel({
    required super.conversionRates,
  });

  /// Creates CurrencyConversionModel from JSON response
  factory CurrencyConversionModel.fromJson(Map<String, dynamic> json) {
    final conversionRatesJson = json['conversion_rates'] as Map<String, dynamic>? ?? {};
    
    // Convert dynamic values to double
    final conversionRates = <String, double>{};
    conversionRatesJson.forEach((key, value) {
      if (value is num) {
        conversionRates[key] = value.toDouble();
      }
    });

    return CurrencyConversionModel(
      conversionRates: conversionRates,
    );
  }

  /// Creates CurrencyConversionModel from CurrencyConversionEntity
  factory CurrencyConversionModel.fromEntity(CurrencyConversionEntity entity) {
    return CurrencyConversionModel(
      conversionRates: entity.conversionRates,
    );
  }

  /// Converts CurrencyConversionModel to CurrencyConversionEntity
  CurrencyConversionEntity toEntity() {
    return CurrencyConversionEntity(
      conversionRates: conversionRates,
    );
  }

  /// Converts CurrencyConversionModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'conversion_rates': conversionRates,
    };
  }

  /// Creates a copy of this model with updated values
  @override
  CurrencyConversionModel copyWith({
    Map<String, double>? conversionRates,
  }) {
    return CurrencyConversionModel(
      conversionRates: conversionRates ?? this.conversionRates,
    );
  }

  @override
  String toString() {
    return 'CurrencyConversionModel(conversionRates: $conversionRates)';
  }
}