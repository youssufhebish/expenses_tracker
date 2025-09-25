import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/currency_conversion_entity.dart';

/// Repository interface for currency conversion operations
/// Provides methods to fetch currency conversion rates
abstract class CurrencyConversionRepository {
  /// Fetches currency conversion rates from the API
  /// Returns [CurrencyConversionEntity] on success or [Failure] on error
  Future<Either<Failure, CurrencyConversionEntity>> getCurrencyConversionRates();
}