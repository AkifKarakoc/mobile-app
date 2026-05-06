import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mobile/features/user/data/dto/update_user_request.dart';
import 'package:mobile/features/user/data/dto/user_response.dart';
import 'package:mobile/features/user/data/user_repository.dart';
import 'package:mobile/features/user/application/profile_provider.dart';
import 'package:mobile/core/network/api_exception.dart';

// Mock repository
class MockUserRepository extends Mock implements IUserRepository {}

void main() {
  setUpAll(() {
    registerFallbackValue(UpdateUserRequest());
    registerFallbackValue(
      UserResponse(
        id: '',
        email: '',
        firstName: '',
        lastName: '',
        preferredLanguage: 'tr',
        role: 'TOURIST',
        expPoints: 0,
        level: 1,
      ),
    );
  });

  group('ProfileProvider', () {
    late MockUserRepository mockRepository;

    setUp(() {
      mockRepository = MockUserRepository();
    });

    test('initial state loads profile successfully', () async {
      final userResponse = UserResponse(
        id: '123',
        email: 'test@example.com',
        firstName: 'John',
        lastName: 'Doe',
        preferredLanguage: 'tr',
        role: 'TOURIST',
        expPoints: 500,
        level: 1,
      );

      when(
        () => mockRepository.getProfile(),
      ).thenAnswer((_) async => userResponse);

      final container = ProviderContainer(
        overrides: [userRepositoryProvider.overrideWithValue(mockRepository)],
      );
      addTearDown(container.dispose);

      final state = await container.read(profileProvider.future);

      expect(state?.email, equals('test@example.com'));
      expect(state?.firstName, equals('John'));
      expect(state?.level, equals(1));
    });

    test('refresh reloads profile', () async {
      final userResponse = UserResponse(
        id: '123',
        email: 'test@example.com',
        firstName: 'John',
        lastName: 'Doe',
        preferredLanguage: 'tr',
        role: 'TOURIST',
        expPoints: 1000,
        level: 2,
      );

      when(
        () => mockRepository.getProfile(),
      ).thenAnswer((_) async => userResponse);

      final container = ProviderContainer(
        overrides: [userRepositoryProvider.overrideWithValue(mockRepository)],
      );
      addTearDown(container.dispose);

      // Initial load
      await container.read(profileProvider.future);

      // Refresh
      await container.read(profileProvider.notifier).refresh();

      final state = container.read(profileProvider);
      expect(state.hasValue, isTrue);
      expect(state.value?.level, equals(2));
      verify(() => mockRepository.getProfile()).called(2);
    });

    test('updateProfile changes profile state', () async {
      final initialUser = UserResponse(
        id: '123',
        email: 'test@example.com',
        firstName: 'John',
        lastName: 'Doe',
        preferredLanguage: 'tr',
        role: 'TOURIST',
        expPoints: 500,
        level: 1,
      );

      final updatedUser = UserResponse(
        id: '123',
        email: 'test@example.com',
        firstName: 'Jane',
        lastName: 'Smith',
        preferredLanguage: 'en',
        role: 'TOURIST',
        expPoints: 500,
        level: 1,
      );

      when(
        () => mockRepository.getProfile(),
      ).thenAnswer((_) async => initialUser);

      when(
        () => mockRepository.updateProfile(any()),
      ).thenAnswer((_) async => updatedUser);

      final container = ProviderContainer(
        overrides: [userRepositoryProvider.overrideWithValue(mockRepository)],
      );
      addTearDown(container.dispose);

      // Wait for initial load
      await container.read(profileProvider.future);

      // Update profile
      await container
          .read(profileProvider.notifier)
          .updateProfile(
            firstName: 'Jane',
            lastName: 'Smith',
            preferredLanguage: 'en',
          );

      final state = container.read(profileProvider);
      expect(state.hasValue, isTrue);
      expect(state.value?.firstName, equals('Jane'));
      expect(state.value?.lastName, equals('Smith'));
    });

    test('handles error during refresh', () async {
      when(
        () => mockRepository.getProfile(),
      ).thenThrow(NetworkException('Connection failed'));

      final container = ProviderContainer(
        overrides: [userRepositoryProvider.overrideWithValue(mockRepository)],
      );
      addTearDown(container.dispose);

      expect(
        () => container.read(profileProvider.future),
        throwsA(isA<NetworkException>()),
      );
    });
  });
}
