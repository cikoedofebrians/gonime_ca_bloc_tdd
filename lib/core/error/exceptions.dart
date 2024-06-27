import 'package:equatable/equatable.dart';

class ServerException extends Equatable implements Exception {
  const ServerException({
    required this.message,
    required this.statusCode,
  });

  final String message;
  final int? statusCode;

  @override
  List<Object?> get props => [statusCode];
}

class SystemException implements Exception {
  const SystemException({
    this.message = 'Something went wrong. Please try again later.',
  });

  final String message;
}
