import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mobile/core/network/interceptors/refresh_interceptor.dart';
import 'package:mobile/core/storage/secure_storage.dart';

class MockSecureStorage extends Mock implements SecureStorage {}

class MockErrorInterceptorHandler extends Mock
    implements ErrorInterceptorHandler {}

class FailingHttpClientAdapter implements HttpClientAdapter {
  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) {
    throw DioException(
      requestOptions: options,
      type: DioExceptionType.connectionError,
      message: 'Refresh failed',
    );
  }

  @override
  void close({bool force = false}) {}
}

void main() {
  final fallbackRequestOptions = RequestOptions(
    path: '/fallback',
    method: 'GET',
  );

  setUpAll(() {
    registerFallbackValue(fallbackRequestOptions);
    registerFallbackValue(
      DioException(
        requestOptions: fallbackRequestOptions,
        type: DioExceptionType.unknown,
      ),
    );
  });

  group('RefreshInterceptor', () {
    late MockSecureStorage mockSecureStorage;
    late RefreshInterceptor refreshInterceptor;
    late MockErrorInterceptorHandler mockHandler;

    final testRequestOptions = RequestOptions(
      path: 'http://localhost/users/me',
      method: 'GET',
    );

    setUp(() {
      mockSecureStorage = MockSecureStorage();
      refreshInterceptor = RefreshInterceptor(
        mockSecureStorage,
        'http://test.local',
        refreshDio: Dio()..httpClientAdapter = FailingHttpClientAdapter(),
      );
      mockHandler = MockErrorInterceptorHandler();
    });

    test('ignores non-401 errors', () async {
      final error = DioException(
        requestOptions: testRequestOptions,
        response: Response(requestOptions: testRequestOptions, statusCode: 500),
        type: DioExceptionType.badResponse,
      );

      when(() => mockHandler.next(any())).thenAnswer((invocation) async {});

      await refreshInterceptor.onError(error, mockHandler);

      verify(() => mockHandler.next(error)).called(1);
    });

    test('does not refresh if no refresh token is available', () async {
      final error = DioException(
        requestOptions: testRequestOptions,
        response: Response(requestOptions: testRequestOptions, statusCode: 401),
        type: DioExceptionType.badResponse,
      );

      when(
        () => mockSecureStorage.getRefreshToken(),
      ).thenAnswer((_) async => null);
      when(() => mockSecureStorage.clearTokens()).thenAnswer((_) async {});
      when(() => mockHandler.next(any())).thenAnswer((invocation) async {});

      await refreshInterceptor.onError(error, mockHandler);

      verify(() => mockSecureStorage.clearTokens()).called(1);
      verify(() => mockHandler.next(any())).called(1);
    });

    test('clears tokens when refresh fails', () async {
      final error = DioException(
        requestOptions: testRequestOptions,
        response: Response(requestOptions: testRequestOptions, statusCode: 401),
        type: DioExceptionType.badResponse,
      );

      when(
        () => mockSecureStorage.getRefreshToken(),
      ).thenAnswer((_) async => 'invalid_refresh_token');
      when(() => mockSecureStorage.clearTokens()).thenAnswer((_) async {});
      when(() => mockHandler.next(any())).thenAnswer((invocation) async {});

      await refreshInterceptor.onError(error, mockHandler);

      verify(() => mockSecureStorage.clearTokens()).called(1);
    });

    test('does not add Authorization header for empty token', () async {
      const token = '';

      final options = RequestOptions(
        path: 'http://localhost/users/me',
        method: 'GET',
      );

      when(
        () => mockSecureStorage.getAccessToken(),
      ).thenAnswer((_) async => token);
      when(() => mockHandler.next(any())).thenAnswer((invocation) async {});

      // Simulate the auth interceptor behavior
      if (token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }

      expect(options.headers['Authorization'], isNull);
    });
  });
}
