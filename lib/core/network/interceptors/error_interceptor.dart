import 'package:dio/dio.dart';
import 'package:mobile/core/network/api_exception.dart';

/// Interceptor that converts [DioException] to [ApiException].
///
/// This ensures all network errors are converted to domain-specific exceptions
/// before being propagated to the application layer.
class ErrorInterceptor extends Interceptor {
  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final apiException = ApiException.fromDio(err);
    return handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        error: apiException,
        type: DioExceptionType.unknown,
      ),
    );
  }
}
