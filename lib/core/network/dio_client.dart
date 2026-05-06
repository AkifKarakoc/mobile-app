import 'package:dio/dio.dart' hide LogInterceptor;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/app/env/env_provider.dart';
import 'package:mobile/core/network/interceptors/auth_interceptor.dart';
import 'package:mobile/core/network/interceptors/error_interceptor.dart';
import 'package:mobile/core/network/interceptors/log_interceptor.dart';
import 'package:mobile/core/network/interceptors/refresh_interceptor.dart';
import 'package:mobile/core/storage/secure_storage.dart';

/// Riverpod provider for the HTTP client.
///
/// Creates and configures a [Dio] instance with:
/// - Base URL from environment configuration ([envProvider])
/// - Standard timeouts (30s connect, 30s receive)
/// - Interceptor chain: log → auth → refresh → error
final dioClientProvider = Provider<Dio>((ref) {
  final env = ref.watch(envProvider);
  final secureStorage = ref.watch(secureStorageProvider);

  return _createDioClient(env.apiBaseUrl, secureStorage);
});

/// Creates and configures the [Dio] instance.
Dio _createDioClient(String baseUrl, SecureStorage secureStorage) {
  final dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      contentType: 'application/json',
    ),
  );

  // Interceptor chain: log → auth → refresh → error
  // Order matters: auth adds token, refresh handles 401, error converts to ApiException
  dio.interceptors.addAll([
    LogInterceptor(),
    AuthInterceptor(secureStorage),
    RefreshInterceptor(secureStorage, baseUrl),
    ErrorInterceptor(),
  ]);

  return dio;
}
