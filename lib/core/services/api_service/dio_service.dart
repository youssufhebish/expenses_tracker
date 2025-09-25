import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../configs/environment_config.dart';
import '../../error/failure.dart';
import 'custom_interceptor.dart';

import 'api_service.dart';

class DioService implements ApiService {
  static DioService? _instance;
  final Dio _dio;
  final String baseUrl;

  DioService._({required this.baseUrl, Map<String, dynamic>? headers})
    : _dio = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(milliseconds: 30000),
          receiveTimeout: const Duration(milliseconds: 30000),
          headers: headers,
        ),
      );

  factory DioService() {
    _instance ??= DioService._(baseUrl: EnvironmentConfig.url);
    _instance?._dio.interceptors.addAll([
      AppInterceptors(),
      if (kDebugMode)
        LogInterceptor(
          request: true,
          responseBody: true,
          requestBody: true,
          requestHeader: true,
          responseHeader: false,
        ),
    ]);
    return _instance!;
  }

  static DioService get instance {
    if (_instance == null) {
      throw Exception('DioService not initialized. Call DioService() first.');
    }
    return _instance!;
  }

  @override
  Future<Either<dynamic, Failure>> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.get(
        endpoint,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return Left(response.data);
    } on DioException catch (e) {
      final exception = _handleError(e);
      return Right(exception);
    }
  }

  @override
  Future<Either<dynamic, Failure>> post(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.post(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return Left(response.data);
    } on DioException catch (e) {
      final exception = _handleError(e);
      return Right(exception);
    }
  }

  @override
  Future<Either<dynamic, Failure>> put(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.put(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return Left(response.data);
    } on DioException catch (e) {
      final exception = _handleError(e);
      return Right(exception);
    }
  }

  @override
  Future<Either<dynamic, Failure>> delete(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.delete(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return Left(response.data);
    } on DioException catch (e) {
      final exception = _handleError(e);
      return Right(exception);
    }
  }

  @override
  Future<Either<dynamic, Failure>> request<T>({
    required String endpoint,
    required String method,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    T Function(dynamic)? converter,
  }) async {
    try {
      final response = await _dio.request(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: Options(method: method, headers: headers),
      );

      return Left(response.data);
    } on DioException catch (e) {
      final exception = _handleError(e);
      return Right(exception);
    }
  }

  // Error handler
  Failure _handleError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ServerFailure(e.message ?? 'Connection timed out');
      case DioExceptionType.badResponse:
        return ServerFailure(_getErrorMessage(e.response));
      case DioExceptionType.cancel:
        return CommonFailure(e.message ?? 'Request was cancelled');
      default:
        return ConnectionFailure(e.message ?? 'Network error occurred');
    }
  }

  // Extract error message from response
  String _getErrorMessage(Response? response) {
    if (response == null || response.data == null) {
      return 'Unknown error occurred';
    }

    if (response.data is Map && response.data['message'] != null) {
      return response.data['message'];
    }

    if (response.data is Map && response.data['detail'] != null) {
      return response.data['detail'];
    }

    return 'Error ${response.statusCode}: ${response.statusMessage}';
  }
}
