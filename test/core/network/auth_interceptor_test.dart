import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mobile/core/network/interceptors/auth_interceptor.dart';
import 'package:mobile/core/storage/secure_storage.dart';

class MockSecureStorage extends Mock implements SecureStorage {}

class MockRequestInterceptorHandler extends Mock
    implements RequestInterceptorHandler {}

void main() {
  setUpAll(() {
    registerFallbackValue(RequestOptions(path: '/fallback', method: 'GET'));
  });

  group('AuthInterceptor', () {
    late MockSecureStorage mockSecureStorage;
    late AuthInterceptor authInterceptor;
    late MockRequestInterceptorHandler mockHandler;

    setUp(() {
      mockSecureStorage = MockSecureStorage();
      authInterceptor = AuthInterceptor(mockSecureStorage);
      mockHandler = MockRequestInterceptorHandler();
    });

    test('adds Authorization header when token is available', () async {
      const token = 'test_access_token';

      final options = RequestOptions(
        path: 'http://localhost/users/me',
        method: 'GET',
      );

      when(
        () => mockSecureStorage.getAccessToken(),
      ).thenAnswer((_) async => token);
      when(() => mockHandler.next(any())).thenAnswer((invocation) async {});

      await authInterceptor.onRequest(options, mockHandler);

      expect(options.headers['Authorization'], 'Bearer $token');
      verify(() => mockHandler.next(options)).called(1);
    });

    test(
      'does not add Authorization header when token is not available',
      () async {
        final options = RequestOptions(
          path: 'http://localhost/users/me',
          method: 'GET',
        );

        when(
          () => mockSecureStorage.getAccessToken(),
        ).thenAnswer((_) async => null);
        when(() => mockHandler.next(any())).thenAnswer((invocation) async {});

        await authInterceptor.onRequest(options, mockHandler);

        expect(options.headers['Authorization'], isNull);
        verify(() => mockHandler.next(options)).called(1);
      },
    );

    test('skips Authorization header for /auth/login endpoint', () async {
      const token = 'test_access_token';

      final options = RequestOptions(
        path: 'http://localhost/auth/login',
        method: 'POST',
      );

      when(
        () => mockSecureStorage.getAccessToken(),
      ).thenAnswer((_) async => token);
      when(() => mockHandler.next(any())).thenAnswer((invocation) async {});

      await authInterceptor.onRequest(options, mockHandler);

      expect(options.headers['Authorization'], isNull);
      verify(() => mockHandler.next(options)).called(1);
    });

    test('skips Authorization header for /auth/register endpoint', () async {
      const token = 'test_access_token';

      final options = RequestOptions(
        path: 'http://localhost/auth/register',
        method: 'POST',
      );

      when(
        () => mockSecureStorage.getAccessToken(),
      ).thenAnswer((_) async => token);
      when(() => mockHandler.next(any())).thenAnswer((invocation) async {});

      await authInterceptor.onRequest(options, mockHandler);

      expect(options.headers['Authorization'], isNull);
      verify(() => mockHandler.next(options)).called(1);
    });

    test('skips Authorization header for /auth/refresh endpoint', () async {
      const token = 'test_access_token';

      final options = RequestOptions(
        path: 'http://localhost/auth/refresh',
        method: 'POST',
      );

      when(
        () => mockSecureStorage.getAccessToken(),
      ).thenAnswer((_) async => token);
      when(() => mockHandler.next(any())).thenAnswer((invocation) async {});

      await authInterceptor.onRequest(options, mockHandler);

      expect(options.headers['Authorization'], isNull);
      verify(() => mockHandler.next(options)).called(1);
    });

    test(
      'skips Authorization header for /auth/forgot-password endpoint',
      () async {
        const token = 'test_access_token';

        final options = RequestOptions(
          path: 'http://localhost/auth/forgot-password',
          method: 'POST',
        );

        when(
          () => mockSecureStorage.getAccessToken(),
        ).thenAnswer((_) async => token);
        when(() => mockHandler.next(any())).thenAnswer((invocation) async {});

        await authInterceptor.onRequest(options, mockHandler);

        expect(options.headers['Authorization'], isNull);
        verify(() => mockHandler.next(options)).called(1);
      },
    );
  });
}
