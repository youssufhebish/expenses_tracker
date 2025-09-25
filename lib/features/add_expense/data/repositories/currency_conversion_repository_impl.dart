import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/currency_conversion_entity.dart';
import '../../domain/repositories/currency_conversion_repository.dart';
import '../datasources/currency_conversion_remote_datasource.dart';

/// Implementation of [CurrencyConversionRepository]
/// Handles currency conversion data operations through remote data source
class CurrencyConversionRepositoryImpl implements CurrencyConversionRepository {
  final CurrencyConversionRemoteDataSource remoteDataSource;

  const CurrencyConversionRepositoryImpl({
    required this.remoteDataSource,
  });

  /// Fetches currency conversion rates from remote data source
  /// Returns [CurrencyConversionEntity] on success or [Failure] on error
  @override
  Future<Either<Failure, CurrencyConversionEntity>> getCurrencyConversionRates() async {
    try {
      final result = await remoteDataSource.getCurrencyConversionRates();
      return result.fold(
        (model) => Right(model.toEntity()),
        (failure) => Left(failure),
      );
    } catch (e) {
      return Left(ServerFailure('Failed to get currency conversion rates: ${e.toString()}'));
    }
  }
}