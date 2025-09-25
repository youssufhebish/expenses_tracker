import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/currency_conversion_entity.dart';
import '../repositories/currency_conversion_repository.dart';

/// Use case for getting currency conversion rates
/// Handles business logic for fetching currency conversion data
class GetCurrencyConversionRatesUseCase {
  final CurrencyConversionRepository repository;

  const GetCurrencyConversionRatesUseCase({
    required this.repository,
  });

  /// Executes the use case to get currency conversion rates
  /// Returns [CurrencyConversionEntity] on success or [Failure] on error
  Future<Either<Failure, CurrencyConversionEntity>> call() async {
    return await repository.getCurrencyConversionRates();
  }
}