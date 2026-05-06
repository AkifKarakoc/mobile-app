import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mobile/core/network/api_exception.dart';
import 'package:mobile/core/network/interceptors/error_interceptor.dart';

class MockErrorInterceptorHandler extends Mock
    implements ErrorInterceptorHandler {}

void main() {
  group('ErrorInterceptor', () {
    late ErrorInterceptor errorInterceptor;
    late MockErrorInterceptorHandler mockHandler;

    final testRequestOptions = RequestOptions(
      path: 'http://localhost/test',
      method: 'GET',
    );

    setUp(() {
      errorInterceptor = ErrorInterceptor();
      mockHandler = MockErrorInterceptorHandler();

      // Register fallback for DioException
      registerFallbackValue(
        DioException(
          requestOptions: testRequestOptions,
          type: DioExceptionType.unknown,
        ),
      );
    });

    test('converts connection timeout to NetworkException', () async {
      final error = DioException(
        requestOptions: testRequestOptions,
        type: DioExceptionType.connectionTimeout,
        message: 'Connection timed out',
      );

      when(() => mockHandler.reject(any())).thenAnswer((invocation) async {});

      await errorInterceptor.onError(error, mockHandler);

      final capturedCall =
          verify(() => mockHandler.reject(captureAny())).captured.first
              as DioException;

      expect(capturedCall.error, isA<NetworkException>());
    });

    test('converts 401 response to UnauthorizedException', () async {
      final error = DioException(
        requestOptions: testRequestOptions,
        response: Response(requestOptions: testRequestOptions, statusCode: 401),
        type: DioExceptionType.badResponse,
      );

      when(() => mockHandler.reject(any())).thenAnswer((invocation) async {});

      await errorInterceptor.onError(error, mockHandler);

      final capturedCall =
          verify(() => mockHandler.reject(captureAny())).captured.first
              as DioException;

      expect(capturedCall.error, isA<UnauthorizedException>());
    });

    test('converts 403 response to ForbiddenException', () async {
      final error = DioException(
        requestOptions: testRequestOptions,
        response: Response(requestOptions: testRequestOptions, statusCode: 403),
        type: DioExceptionType.badResponse,
      );

      when(() => mockHandler.reject(any())).thenAnswer((invocation) async {});

      await errorInterceptor.onError(error, mockHandler);

      final capturedCall =
          verify(() => mockHandler.reject(captureAny())).captured.first
              as DioException;

      expect(capturedCall.error, isA<ForbiddenException>());
    });

    test('converts 404 response to NotFoundException', () async {
      final error = DioException(
        requestOptions: testRequestOptions,
        response: Response(requestOptions: testRequestOptions, statusCode: 404),
        type: DioExceptionType.badResponse,
      );

      when(() => mockHandler.reject(any())).thenAnswer((invocation) async {});

      await errorInterceptor.onError(error, mockHandler);

      final capturedCall =
          verify(() => mockHandler.reject(captureAny())).captured.first
              as DioException;

      expect(capturedCall.error, isA<NotFoundException>());
    });

    test(
      'converts 422 response with validation errors to ValidationException',
      () async {
        final error = DioException(
          requestOptions: testRequestOptions,
          response: Response(
            requestOptions: testRequestOptions,
            statusCode: 422,
            data: {
              'errors': {
                'email': 'Invalid email format',
                'password': 'Password too short',
              },
            },
          ),
          type: DioExceptionType.badResponse,
        );

        when(() => mockHandler.reject(any())).thenAnswer((invocation) async {});

        await errorInterceptor.onError(error, mockHandler);

        final capturedCall =
            verify(() => mockHandler.reject(captureAny())).captured.first
                as DioException;

        expect(capturedCall.error, isA<ValidationException>());
        final validationError = capturedCall.error as ValidationException;
        expect(validationError.errors.length, 2);
        expect(validationError.errors['email'], 'Invalid email format');
        expect(validationError.errors['password'], 'Password too short');
      },
    );

    test('converts 500 response to ServerException', () async {
      final error = DioException(
        requestOptions: testRequestOptions,
        response: Response(requestOptions: testRequestOptions, statusCode: 500),
        type: DioExceptionType.badResponse,
      );

      when(() => mockHandler.reject(any())).thenAnswer((invocation) async {});

      await errorInterceptor.onError(error, mockHandler);

      final capturedCall =
          verify(() => mockHandler.reject(captureAny())).captured.first
              as DioException;

      expect(capturedCall.error, isA<ServerException>());
      final serverError = capturedCall.error as ServerException;
      expect(serverError.statusCode, 500);
    });

    test('converts unknown DioException to UnknownException', () async {
      final error = DioException(
        requestOptions: testRequestOptions,
        type: DioExceptionType.unknown,
        message: 'Something went wrong',
      );

      when(() => mockHandler.reject(any())).thenAnswer((invocation) async {});

      await errorInterceptor.onError(error, mockHandler);

      final capturedCall =
          verify(() => mockHandler.reject(captureAny())).captured.first
              as DioException;

      expect(capturedCall.error, isA<UnknownException>());
    });

    test('converts badCertificate to NetworkException', () async {
      final error = DioException(
        requestOptions: testRequestOptions,
        type: DioExceptionType.badCertificate,
      );

      when(() => mockHandler.reject(any())).thenAnswer((invocation) async {});

      await errorInterceptor.onError(error, mockHandler);

      final capturedCall =
          verify(() => mockHandler.reject(captureAny())).captured.first
              as DioException;

      expect(capturedCall.error, isA<NetworkException>());
    });
  });
}
