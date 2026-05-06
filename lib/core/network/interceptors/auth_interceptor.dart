import 'package:dio/dio.dart';
import 'package:mobile/core/storage/secure_storage.dart';

/// Interceptor that adds the authorization header with the access token.
///
/// Skips adding the header for public endpoints (login, register, refresh, forgot-password).
class AuthInterceptor extends Interceptor {
  AuthInterceptor(this._secureStorage);

  final SecureStorage _secureStorage;

  /// Public paths that don't require authorization
  static const _publicPaths = {
    '/auth/login',
    '/auth/register',
    '/auth/refresh',
    '/auth/forgot-password',
  };

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Skip adding token for public endpoints
    if (_isPublicPath(options.path)) {
      return handler.next(options);
    }

    // Try to get the access token from secure storage
    final token = await _secureStorage.getAccessToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    return handler.next(options);
  }

  /// Checks if a path is a public endpoint.
  bool _isPublicPath(String path) {
    // Extract the path from the full URL if necessary
    final uri = Uri.tryParse(path);
    final normalizedPath = uri != null && uri.hasScheme ? uri.path : path;

    return _publicPaths.any(
      (publicPath) => normalizedPath.startsWith(publicPath),
    );
  }
}
