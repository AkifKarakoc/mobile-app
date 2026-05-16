import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mobile/core/network/api_exception.dart';
import 'package:mobile/core/storage/secure_storage.dart';
import 'package:mobile/features/auth/data/auth_api.dart';
import 'package:mobile/features/auth/data/auth_repository.dart';
import 'package:mobile/features/auth/data/dto/login_request.dart';
import 'package:mobile/features/auth/data/dto/login_response.dart';
import 'package:mobile/features/auth/data/dto/register_request.dart';
import 'package:mobile/features/auth/data/dto/register_response.dart';
import 'package:mobile/features/auth/data/dto/refresh_request.dart';
import 'package:mobile/features/auth/data/dto/refresh_response.dart';

// Mock classes
class MockAuthApi extends Mock implements AuthApi {}

class MockSecureStorage extends Mock implements SecureStorage {}

void main() {
  setUpAll(() {
    registerFallbackValue(RequestOptions(path: '/'));
    registerFallbackValue(
      const RegisterRequest(
        email: 'test@example.com',
        password: 'Password123',
        firstName: 'John',
        lastName: 'Doe',
      ),
    );
    registerFallbackValue(
      const LoginRequest(email: 'test@example.com', password: 'Password123'),
    );
    registerFallbackValue(const RefreshRequest(refreshToken: 'refresh_token'));
  });

  group('AuthRepository', () {
    late MockAuthApi mockAuthApi;
    late MockSecureStorage mockSecureStorage;
    late AuthRepository authRepository;

    setUp(() {
      mockAuthApi = MockAuthApi();
      mockSecureStorage = MockSecureStorage();
      authRepository = AuthRepositoryImpl(
        api: mockAuthApi,
        secureStorage: mockSecureStorage,
      );
    });

    group('login', () {
      test('should return LoginResponse and save tokens on success', () async {
        // Arrange
        const email = 'test@example.com';
        const password = 'Password123';
        const response = LoginResponse(
          accessToken: 'access_token_123',
          refreshToken: 'refresh_token_456',
          role: 'TOURIST',
        );

        when(() => mockAuthApi.login(any())).thenAnswer((_) async => response);
        when(
          () => mockSecureStorage.saveAccessToken(any()),
        ).thenAnswer((_) async {});
        when(
          () => mockSecureStorage.saveRefreshToken(any()),
        ).thenAnswer((_) async {});

        // Act
        final result = await authRepository.login(
          email: email,
          password: password,
        );

        // Assert
        expect(result, equals(response));
        verify(
          () => mockSecureStorage.saveAccessToken('access_token_123'),
        ).called(1);
        verify(
          () => mockSecureStorage.saveRefreshToken('refresh_token_456'),
        ).called(1);
      });

      test('should throw UnauthorizedException on 401 error', () async {
        // Arrange
        const email = 'test@example.com';
        const password = 'WrongPassword';
        final dioException = DioException(
          requestOptions: RequestOptions(path: '/auth/login'),
          response: Response(
            requestOptions: RequestOptions(path: '/auth/login'),
            statusCode: 401,
            data: {'message': 'Invalid credentials'},
          ),
          type: DioExceptionType.badResponse,
        );

        when(() => mockAuthApi.login(any())).thenThrow(dioException);

        // Act & Assert
        expect(
          () => authRepository.login(email: email, password: password),
          throwsA(isA<UnauthorizedException>()),
        );
      });

      test('should throw NetworkException on connection timeout', () async {
        // Arrange
        const email = 'test@example.com';
        const password = 'Password123';
        final dioException = DioException(
          requestOptions: RequestOptions(path: '/auth/login'),
          type: DioExceptionType.connectionTimeout,
          message: 'Connection timeout',
        );

        when(() => mockAuthApi.login(any())).thenThrow(dioException);

        // Act & Assert
        expect(
          () => authRepository.login(email: email, password: password),
          throwsA(isA<NetworkException>()),
        );
      });
    });

    group('register', () {
      test(
        'should return RegisterResponse and save tokens on success',
        () async {
          // Arrange
          const email = 'newuser@example.com';
          const password = 'Password123';
          const firstName = 'Jane';
          const lastName = 'Doe';
          const response = RegisterResponse(
            userId: 'user-uuid-123',
            email: email,
            firstName: firstName,
            lastName: lastName,
            role: 'TOURIST',
            accessToken: 'access_token_789',
            refreshToken: 'refresh_token_012',
          );

          when(
            () => mockAuthApi.register(any()),
          ).thenAnswer((_) async => response);
          when(
            () => mockSecureStorage.saveAccessToken(any()),
          ).thenAnswer((_) async {});
          when(
            () => mockSecureStorage.saveRefreshToken(any()),
          ).thenAnswer((_) async {});

          // Act
          final result = await authRepository.register(
            email: email,
            password: password,
            firstName: firstName,
            lastName: lastName,
          );

          // Assert
          expect(result, equals(response));
          verify(
            () => mockSecureStorage.saveAccessToken('access_token_789'),
          ).called(1);
          verify(
            () => mockSecureStorage.saveRefreshToken('refresh_token_012'),
          ).called(1);
        },
      );

      test(
        'should handle optional fields (phoneNumber, preferredLanguage)',
        () async {
          // Arrange
          const response = RegisterResponse(
            userId: 'user-uuid-123',
            email: 'test@example.com',
            firstName: 'John',
            lastName: 'Doe',
            role: 'TOURIST',
            accessToken: 'access_token_789',
            refreshToken: 'refresh_token_012',
          );

          when(
            () => mockAuthApi.register(any()),
          ).thenAnswer((_) async => response);
          when(
            () => mockSecureStorage.saveAccessToken(any()),
          ).thenAnswer((_) async {});
          when(
            () => mockSecureStorage.saveRefreshToken(any()),
          ).thenAnswer((_) async {});

          // Act
          final result = await authRepository.register(
            email: 'test@example.com',
            password: 'Password123',
            firstName: 'John',
            lastName: 'Doe',
            phoneNumber: '+1234567890',
            preferredLanguage: 'en',
            birthDate: DateTime(1990, 1, 15),
          );

          // Assert
          expect(result.userId, equals('user-uuid-123'));
        },
      );

      test('should throw ValidationException on 422 error', () async {
        // Arrange
        final dioException = DioException(
          requestOptions: RequestOptions(path: '/auth/register'),
          response: Response(
            requestOptions: RequestOptions(path: '/auth/register'),
            statusCode: 422,
            data: {
              'errors': {
                'email': 'Email already exists',
                'password': 'Password too weak',
              },
            },
          ),
          type: DioExceptionType.badResponse,
        );

        when(() => mockAuthApi.register(any())).thenThrow(dioException);

        // Act & Assert
        expect(
          () => authRepository.register(
            email: 'test@example.com',
            password: 'weak',
            firstName: 'John',
            lastName: 'Doe',
          ),
          throwsA(isA<ValidationException>()),
        );
      });
    });

    group('refreshTokens', () {
      test('should update tokens on success', () async {
        // Arrange
        const currentRefreshToken = 'old_refresh_token';
        const response = RefreshResponse(
          accessToken: 'new_access_token',
          refreshToken: 'new_refresh_token',
        );

        when(
          () => mockSecureStorage.getRefreshToken(),
        ).thenAnswer((_) async => currentRefreshToken);
        when(
          () => mockAuthApi.refresh(any()),
        ).thenAnswer((_) async => response);
        when(
          () => mockSecureStorage.saveAccessToken(any()),
        ).thenAnswer((_) async {});
        when(
          () => mockSecureStorage.saveRefreshToken(any()),
        ).thenAnswer((_) async {});

        // Act
        await authRepository.refreshTokens();

        // Assert
        verify(
          () => mockSecureStorage.saveAccessToken('new_access_token'),
        ).called(1);
        verify(
          () => mockSecureStorage.saveRefreshToken('new_refresh_token'),
        ).called(1);
      });

      test(
        'should throw UnauthorizedException if no refresh token exists',
        () async {
          // Arrange
          when(
            () => mockSecureStorage.getRefreshToken(),
          ).thenAnswer((_) async => null);

          // Act & Assert
          expect(
            () => authRepository.refreshTokens(),
            throwsA(isA<UnauthorizedException>()),
          );
        },
      );

      test('should throw NetworkException on connection error', () async {
        // Arrange
        const currentRefreshToken = 'old_refresh_token';
        final dioException = DioException(
          requestOptions: RequestOptions(path: '/auth/refresh'),
          type: DioExceptionType.connectionError,
          message: 'Network unreachable',
        );

        when(
          () => mockSecureStorage.getRefreshToken(),
        ).thenAnswer((_) async => currentRefreshToken);
        when(() => mockAuthApi.refresh(any())).thenThrow(dioException);

        // Act & Assert
        expect(
          () => authRepository.refreshTokens(),
          throwsA(isA<NetworkException>()),
        );
      });
    });

    group('logout', () {
      test('should call API and clear tokens on success', () async {
        // Arrange
        when(() => mockAuthApi.logout()).thenAnswer((_) async {});
        when(() => mockSecureStorage.clearTokens()).thenAnswer((_) async {});

        // Act
        await authRepository.logout();

        // Assert
        verify(() => mockAuthApi.logout()).called(1);
        verify(() => mockSecureStorage.clearTokens()).called(1);
      });

      test('should clear tokens even if API call fails', () async {
        // Arrange
        final dioException = DioException(
          requestOptions: RequestOptions(path: '/auth/logout'),
          type: DioExceptionType.connectionError,
          message: 'Network error',
        );

        when(() => mockAuthApi.logout()).thenThrow(dioException);
        when(() => mockSecureStorage.clearTokens()).thenAnswer((_) async {});

        // Act
        await authRepository.logout();

        // Assert
        // Should not throw, and tokens should be cleared
        verify(() => mockSecureStorage.clearTokens()).called(1);
      });

      test('should clear tokens even if API call returns 500 error', () async {
        // Arrange
        final dioException = DioException(
          requestOptions: RequestOptions(path: '/auth/logout'),
          response: Response(
            requestOptions: RequestOptions(path: '/auth/logout'),
            statusCode: 500,
          ),
          type: DioExceptionType.badResponse,
        );

        when(() => mockAuthApi.logout()).thenThrow(dioException);
        when(() => mockSecureStorage.clearTokens()).thenAnswer((_) async {});

        // Act
        await authRepository.logout();

        // Assert
        verify(() => mockSecureStorage.clearTokens()).called(1);
      });

      test('should never throw an exception', () async {
        // Arrange
        when(
          () => mockAuthApi.logout(),
        ).thenThrow(Exception('Unexpected error'));
        when(
          () => mockSecureStorage.clearTokens(),
        ).thenThrow(Exception('Storage error'));

        // Act & Assert
        expect(authRepository.logout(), completes);
      });
    });
  });
}
