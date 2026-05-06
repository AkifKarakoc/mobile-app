import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mobile/core/network/api_exception.dart';
import 'package:mobile/core/storage/secure_storage.dart';
import 'package:mobile/features/auth/application/auth_notifier.dart';
import 'package:mobile/features/auth/data/auth_repository.dart';
import 'package:mobile/features/auth/data/dto/login_response.dart';
import 'package:mobile/features/auth/data/dto/register_response.dart';

// Mocks
class MockAuthRepository extends Mock implements AuthRepository {}

class MockSecureStorage extends Mock implements SecureStorage {}

void main() {
  group('AuthNotifier', () {
    late MockAuthRepository mockAuthRepository;
    late MockSecureStorage mockSecureStorage;
    late ProviderContainer container;

    setUp(() {
      mockAuthRepository = MockAuthRepository();
      mockSecureStorage = MockSecureStorage();
      when(
        () => mockSecureStorage.getAccessToken(),
      ).thenAnswer((_) async => null);

      container = ProviderContainer(
        overrides: [
          authRepositoryProvider.overrideWithValue(mockAuthRepository),
          secureStorageProvider.overrideWithValue(mockSecureStorage),
        ],
      );
    });

    tearDown(() {
      container.dispose();
    });

    test('build returns true if access token exists', () async {
      when(
        () => mockSecureStorage.getAccessToken(),
      ).thenAnswer((_) async => 'valid_token');

      final result = await container.read(authNotifierProvider.future);

      expect(result, true);
      verify(() => mockSecureStorage.getAccessToken()).called(1);
    });

    test('build returns false if no access token', () async {
      when(
        () => mockSecureStorage.getAccessToken(),
      ).thenAnswer((_) async => null);

      final result = await container.read(authNotifierProvider.future);

      expect(result, false);
      verify(() => mockSecureStorage.getAccessToken()).called(1);
    });

    test('login success updates state to authenticated', () async {
      when(
        () => mockAuthRepository.login(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer(
        (_) async => const LoginResponse(
          accessToken: 'access',
          refreshToken: 'refresh',
          role: 'TOURIST',
        ),
      );

      // Initialize auth notifier
      await container.read(authNotifierProvider.future);

      final notifier = container.read(authNotifierProvider.notifier);
      await notifier.login(email: 'test@example.com', password: 'password123');

      final state = container.read(authNotifierProvider);
      expect(
        state.maybeWhen(data: (isAuth) => isAuth, orElse: () => false),
        true,
      );
    });

    test('login failure sets error state', () async {
      when(
        () => mockAuthRepository.login(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenThrow(const UnauthorizedException('Invalid credentials'));

      await container.read(authNotifierProvider.future);

      final notifier = container.read(authNotifierProvider.notifier);

      expect(
        () => notifier.login(email: 'test@example.com', password: 'wrong'),
        throwsA(isA<UnauthorizedException>()),
      );

      final state = container.read(authNotifierProvider);
      expect(state.isLoading, false);
    });

    test('register success updates state to authenticated', () async {
      when(
        () => mockAuthRepository.register(
          email: any(named: 'email'),
          password: any(named: 'password'),
          firstName: any(named: 'firstName'),
          lastName: any(named: 'lastName'),
          phoneNumber: any(named: 'phoneNumber'),
          preferredLanguage: any(named: 'preferredLanguage'),
          ageGroup: any(named: 'ageGroup'),
        ),
      ).thenAnswer(
        (_) async => const RegisterResponse(
          userId: '123',
          email: 'new@example.com',
          firstName: 'John',
          lastName: 'Doe',
          role: 'TOURIST',
          accessToken: 'access',
          refreshToken: 'refresh',
        ),
      );

      await container.read(authNotifierProvider.future);

      final notifier = container.read(authNotifierProvider.notifier);
      await notifier.register(
        email: 'new@example.com',
        password: 'password123',
        firstName: 'John',
        lastName: 'Doe',
      );

      final state = container.read(authNotifierProvider);
      expect(
        state.maybeWhen(data: (isAuth) => isAuth, orElse: () => false),
        true,
      );
    });

    test('register with existing email throws validation error', () async {
      when(
        () => mockAuthRepository.register(
          email: any(named: 'email'),
          password: any(named: 'password'),
          firstName: any(named: 'firstName'),
          lastName: any(named: 'lastName'),
          phoneNumber: any(named: 'phoneNumber'),
          preferredLanguage: any(named: 'preferredLanguage'),
          ageGroup: any(named: 'ageGroup'),
        ),
      ).thenThrow(const ValidationException({'email': 'already taken'}));

      await container.read(authNotifierProvider.future);

      final notifier = container.read(authNotifierProvider.notifier);

      expect(
        () => notifier.register(
          email: 'existing@example.com',
          password: 'password123',
          firstName: 'Jane',
          lastName: 'Smith',
        ),
        throwsA(isA<ValidationException>()),
      );
    });

    test('logout clears state', () async {
      when(() => mockAuthRepository.logout()).thenAnswer((_) async {});

      await container.read(authNotifierProvider.future);

      final notifier = container.read(authNotifierProvider.notifier);
      await notifier.logout();

      final state = container.read(authNotifierProvider);
      expect(
        state.maybeWhen(data: (isAuth) => isAuth, orElse: () => true),
        false,
      );

      verify(() => mockAuthRepository.logout()).called(1);
    });

    test('logout does not throw even if API fails', () async {
      when(
        () => mockAuthRepository.logout(),
      ).thenThrow(Exception('Network error'));

      await container.read(authNotifierProvider.future);

      final notifier = container.read(authNotifierProvider.notifier);

      // Should not throw
      await notifier.logout();

      final state = container.read(authNotifierProvider);
      expect(
        state.maybeWhen(data: (isAuth) => isAuth, orElse: () => true),
        false,
      );
    });

    test(
      'isAuthenticatedProvider returns false when unauthenticated',
      () async {
        when(
          () => mockSecureStorage.getAccessToken(),
        ).thenAnswer((_) async => null);

        await container.read(authNotifierProvider.future);

        final isAuth = container.read(isAuthenticatedProvider);
        expect(isAuth, false);
      },
    );

    test('isAuthenticatedProvider returns true when authenticated', () async {
      when(
        () => mockSecureStorage.getAccessToken(),
      ).thenAnswer((_) async => 'token');

      await container.read(authNotifierProvider.future);

      final isAuth = container.read(isAuthenticatedProvider);
      expect(isAuth, true);
    });
  });
}
