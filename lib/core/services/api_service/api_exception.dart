import 'package:equatable/equatable.dart';

class ApiException extends Equatable implements Exception {
  final int? statusCode;
  final String message;

  const ApiException({this.statusCode, required this.message});

  @override
  String toString() => 'ApiException: $statusCode - $message';

  @override
  List<Object> get props => [message];
}

class TimeoutException implements Exception {
  final String message;

  TimeoutException(this.message);

  @override
  String toString() => 'TimeoutException: $message';
}

class NetworkException implements Exception {
  final String message;

  NetworkException(this.message);

  @override
  String toString() => 'NetworkException: $message';
}

class RequestCancelledException implements Exception {
  final String message;

  RequestCancelledException(this.message);

  @override
  String toString() => 'RequestCancelledException: $message';
}