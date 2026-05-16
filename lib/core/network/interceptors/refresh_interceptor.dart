import 'package:dio/dio.dart';
import 'package:mobile/core/storage/secure_storage.dart';

/// Interceptor that handles 401 Unauthorized responses by refreshing the token.
///
/// When a 401 is encountered, this interceptor:
/// 1. Attempts to refresh the token using `/auth/refresh` endpoint
/// 2. Retries the original request with the new token
/// 3. Implements a single-request queue to prevent multiple refresh calls
///
/// If refresh fails, clears tokens and re-throws the error.
class RefreshInterceptor extends Interceptor {
  RefreshInterceptor(this._secureStorage, this._baseUrl, {Dio? refreshDio})
    : _refreshDioOverride = refreshDio;

  final SecureStorage _secureStorage;
  final String _baseUrl;
  final Dio? _refreshDioOverride;

  /// A separate Dio instance for refresh requests (avoids infinite loops)
  late final Dio _refreshDio =
      _refreshDioOverride ??
      Dio(
        BaseOptions(
          baseUrl: _baseUrl,
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
        ),
      );

  /// Queue for managing concurrent 401 errors (ensures only one refresh at a time)
  Future<void>? _refreshFuture;

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // Only handle 401 Unauthorized and 403 Forbidden
    final statusCode = err.response?.statusCode;
    if (statusCode != 401 && statusCode != 403) {
      return handler.next(err);
    }

    // Use a queue to ensure refresh is only called once for concurrent requests
    _refreshFuture ??= _performRefresh();

    try {
      await _refreshFuture;
      _refreshFuture = null; // Reset queue

      // Retry the original request
      return handler.resolve(await _retryRequest(err.requestOptions));
    } on DioException catch (refreshError) {
      _refreshFuture = null;

      // Refresh failed; clear tokens and re-throw
      await _secureStorage.clearTokens();
      return handler.next(refreshError);
    } catch (e) {
      _refreshFuture = null;

      // Unexpected error during refresh
      await _secureStorage.clearTokens();
      return handler.next(
        DioException(
          requestOptions: err.requestOptions,
          error: 'Token refresh failed: $e',
          type: DioExceptionType.unknown,
        ),
      );
    }
  }

  /// Performs the token refresh by calling `/auth/refresh` endpoint.
  Future<void> _performRefresh() async {
    final refreshToken = await _secureStorage.getRefreshToken();

    if (refreshToken == null || refreshToken.isEmpty) {
      throw DioException(
        requestOptions: RequestOptions(path: '/auth/refresh'),
        error: 'No refresh token available',
        type: DioExceptionType.unknown,
      );
    }

    try {
      final response = await _refreshDio.post(
        '/auth/refresh',
        data: {'refreshToken': refreshToken},
      );

      if (response.data is Map) {
        final newAccessToken = response.data['accessToken'] as String?;
        final newRefreshToken = response.data['refreshToken'] as String?;

        if (newAccessToken != null && newAccessToken.isNotEmpty) {
          await _secureStorage.saveAccessToken(newAccessToken);
        }
        if (newRefreshToken != null && newRefreshToken.isNotEmpty) {
          await _secureStorage.saveRefreshToken(newRefreshToken);
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  /// Retries the original request with updated authorization.
  Future<Response<dynamic>> _retryRequest(RequestOptions options) async {
    final token = await _secureStorage.getAccessToken();
    options.headers['Authorization'] = 'Bearer $token';

    return _refreshDio.fetch<dynamic>(options);
  }
}
