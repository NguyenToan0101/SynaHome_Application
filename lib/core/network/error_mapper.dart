import 'package:dio/dio.dart';

import '../exceptions/app_exception.dart';

AppException mapDioException(DioException error) {
  if (error.type == DioExceptionType.connectionTimeout ||
      error.type == DioExceptionType.receiveTimeout ||
      error.type == DioExceptionType.sendTimeout) {
    return const RequestTimeoutException();
  }
  if (error.type == DioExceptionType.connectionError) {
    return const NetworkException();
  }

  final statusCode = error.response?.statusCode;
  return switch (statusCode) {
    400 || 422 => const ValidationException(),
    401 => const UnauthorizedException(),
    403 => const ForbiddenException(),
    404 => const NotFoundException(),
    500 => const ServerException(),
    _ => const UnknownException(),
  };
}
