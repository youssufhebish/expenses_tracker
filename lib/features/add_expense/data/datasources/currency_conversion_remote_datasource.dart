import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/services/api_service/api_service.dart';
import '../../../../core/configs/end_points.dart';
import '../models/currency_conversion_model.dart';

/// Abstract interface for currency conversion remote data source
/// Defines contracts for fetching currency conversion rates from API
abstract class CurrencyConversionRemoteDataSource {
  /// Gets currency conversion rates from remote API
  /// Returns either failure or currency conversion data
  Future<Either<CurrencyConversionModel, Failure>> getCurrencyConversionRates({
    String baseCurrency = 'USD',
  });
}

/// Implementation of currency conversion remote data source
/// Handles API calls for currency conversion rates
class CurrencyConversionRemoteDataSourceImpl implements CurrencyConversionRemoteDataSource {
  final ApiService apiService;

  const CurrencyConversionRemoteDataSourceImpl({
    required this.apiService,
  });

  /// Gets currency conversion rates from remote API for specified base currency
  /// Returns either failure or currency conversion data
  @override
  Future<Either<CurrencyConversionModel, Failure>> getCurrencyConversionRates({
    String baseCurrency = 'USD',
  }) async {
    try {
      // Build endpoint with base currency
      final endpoint = '${EndPoints.currencyConversion}/$baseCurrency';
      
      final response = await apiService.get(endpoint);
      
      return response.fold(
        (data) {
          try {
            final currencyConversionModel = CurrencyConversionModel.fromJson(data);
            return Left(currencyConversionModel);
          } catch (e) {
            return Right(ServerFailure(
              'Failed to parse currency conversion data: ${e.toString()}',
            ));
          }
        },
        (failure) => Right(failure),
      );
    } catch (e) {
      return Right(ServerFailure(
        'Unexpected error occurred: ${e.toString()}',
      ));
    }
  }
}