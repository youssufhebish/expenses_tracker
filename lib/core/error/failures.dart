import 'package:equatable/equatable.dart';

/// Abstract base class for all failures in the application
/// Provides a common interface for error handling
abstract class Failure extends Equatable {
  final String message;
  final int? code;

  const Failure({
    required this.message,
    this.code,
  });

  @override
  List<Object?> get props => [message, code];
}

/// Failure for local storage operations
class LocalStorageFailure extends Failure {
  const LocalStorageFailure({
    required super.message,
    super.code,
  });
}

/// Failure for data parsing operations
class DataParsingFailure extends Failure {
  const DataParsingFailure({
    required super.message,
    super.code,
  });
}

/// Failure for validation operations
class ValidationFailure extends Failure {
  const ValidationFailure({
    required super.message,
    super.code,
  });
}

/// Failure for general operations
class GeneralFailure extends Failure {
  const GeneralFailure({
    required super.message,
    super.code,
  });
}