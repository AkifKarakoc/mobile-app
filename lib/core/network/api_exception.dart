import 'package:dio/dio.dart';

/// Exception hierarchy for API errors.
///
/// All network-related errors are converted to [ApiException] subtypes.
/// This sealed class ensures exhaustive pattern matching in error handling.
sealed class ApiException implements Exception {
  const ApiException();

  /// Network connection / timeout exception
  const factory ApiException.network(String message) = NetworkException;

  /// 401 Unauthorized
  const factory ApiException.unauthorized(String message) =
      UnauthorizedException;

  /// 403 Forbidden
  const factory ApiException.forbidden(String message) = ForbiddenException;

  /// 404 Not Found
  const factory ApiException.notFound(String message) = NotFoundException;

  /// 422 Unprocessable Entity — validation errors
  const factory ApiException.validation(Map<String, String> errors) =
      ValidationException;

  /// 5xx Server error
  const factory ApiException.server(int statusCode) = ServerException;

  /// Unclassified error
  const factory ApiException.unknown(String message) = UnknownException;

  /// Converts [DioException] to [ApiException].
  static ApiException fromDio(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.connectionError:
        return ApiException.network('Connection timeout: ${e.message}');

      case DioExceptionType.badResponse:
        if (e.response == null) {
          return ApiException.unknown('Bad response: ${e.message}');
        }

        final statusCode = e.response!.statusCode ?? 0;
        final responseData = e.response!.data;

        switch (statusCode) {
          case 401:
            return ApiException.unauthorized('Unauthorized');

          case 403:
            return ApiException.forbidden('Forbidden');

          case 404:
            return ApiException.notFound('Not found');

          case 422:
            // Extract validation errors from response body
            final errors = _parseValidationErrors(responseData);
            return ApiException.validation(errors);

          case >= 500:
            return ApiException.server(statusCode);

          default:
            return ApiException.unknown('HTTP $statusCode: ${e.message}');
        }

      case DioExceptionType.cancel:
        return ApiException.unknown('Request cancelled');

      case DioExceptionType.unknown:
        return ApiException.unknown(e.message ?? 'Unknown error');

      case DioExceptionType.badCertificate:
        return ApiException.network('Bad certificate');
    }
  }

  /// Parses validation errors from API response.
  /// Expected format: `{ "errors": { "field": "message" } }` or `{ "field": "message" }`
  static Map<String, String> _parseValidationErrors(dynamic responseData) {
    final result = <String, String>{};

    if (responseData is Map) {
      final errors = responseData['errors'] ?? responseData;
      if (errors is Map) {
        errors.forEach((key, value) {
          result[key.toString()] = value.toString();
        });
      }
    }

    return result;
  }

  @override
  String toString() => 'ApiException: $message';

  String get message;
}

/// Network connection / timeout exception
final class NetworkException extends ApiException {
  const NetworkException(this.message);

  @override
  final String message;
}

/// 401 Unauthorized
final class UnauthorizedException extends ApiException {
  const UnauthorizedException(this.message);

  @override
  final String message;
}

/// 403 Forbidden
final class ForbiddenException extends ApiException {
  const ForbiddenException(this.message);

  @override
  final String message;
}

/// 404 Not Found
final class NotFoundException extends ApiException {
  const NotFoundException(this.message);

  @override
  final String message;
}

/// 422 Unprocessable Entity — validation errors
final class ValidationException extends ApiException {
  const ValidationException(this.errors);

  final Map<String, String> errors;

  @override
  String get message => 'Validation failed: ${errors.length} field(s)';
}

/// 5xx Server error
final class ServerException extends ApiException {
  const ServerException(this.statusCode);

  final int statusCode;

  @override
  String get message => 'Server error: $statusCode';
}

/// Unclassified error
final class UnknownException extends ApiException {
  const UnknownException(this.message);

  @override
  final String message;
}
