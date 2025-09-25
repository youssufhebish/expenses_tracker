import 'package:dartz/dartz.dart';
import '../../error/failure.dart';

abstract class ApiService {
  Future<Either<dynamic, Failure>> get(
      String endpoint, {
        Map<String, dynamic>? queryParameters,
        Map<String, dynamic>? headers,
      });

  Future<Either<dynamic, Failure>> post(
      String endpoint, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Map<String, dynamic>? headers,
      });

  Future<Either<dynamic, Failure>> put(
      String endpoint, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Map<String, dynamic>? headers,
      });

  Future<Either<dynamic, Failure>> delete(
      String endpoint, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Map<String, dynamic>? headers,
      });

  Future<Either<dynamic, Failure>> request<T>({
    required String endpoint,
    required String method,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    T Function(dynamic)? converter,
  });
}