import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

/// Interceptor that logs HTTP requests and responses.
///
/// Only active in debug builds to avoid logging sensitive data in production.
/// Uses [PrettyDioLogger] for formatted output.
class LogInterceptor extends Interceptor {
  LogInterceptor() {
    if (kDebugMode) {
      _logger = PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: true,
        compact: false,
        error: true,
        logPrint: (Object object) {
          // Use print for now; can be replaced with logger package
          // ignore: avoid_print
          print(object);
        },
      );
    }
  }

  PrettyDioLogger? _logger;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (_logger != null) {
      return _logger!.onRequest(options, handler);
    }
    return handler.next(options);
  }

  @override
  Future<void> onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) async {
    if (_logger != null) {
      return _logger!.onResponse(response, handler);
    }
    return handler.next(response);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (_logger != null) {
      return _logger!.onError(err, handler);
    }
    return handler.next(err);
  }
}
