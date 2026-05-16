import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mobile/core/network/api_exception.dart';
import 'package:mobile/features/user/data/dto/user_response.dart';
import 'package:mobile/features/user/data/dto/favorite_response.dart';
import 'package:mobile/features/user/data/dto/update_user_request.dart';
import 'package:mobile/features/user/data/user_api.dart';
import 'package:mobile/features/user/data/user_repository.dart';

// Mock classes
class MockUserApi extends Mock implements UserApi {}

class MockFile extends Mock implements File {}

void main() {
  setUpAll(() {
    registerFallbackValue(UpdateUserRequest());
    registerFallbackValue(<String, dynamic>{});
    registerFallbackValue(
      MultipartFile.fromString('fallback', filename: 'fallback.txt'),
    );
  });

  group('UserRepository', () {
    late UserRepository repository;
    late MockUserApi mockApi;

    setUp(() {
      mockApi = MockUserApi();
      repository = UserRepository(mockApi);
    });

    group('getProfile', () {
      test('returns UserResponse on successful API call', () async {
        final userResponse = UserResponse(
          id: '123',
          email: 'test@example.com',
          firstName: 'John',
          lastName: 'Doe',
          phoneNumber: '5551234567',
          profilePhotoUrl: null,
          preferredLanguage: 'tr',
          birthDate: DateTime(1990, 5, 15),
          role: 'TOURIST',
          expPoints: 1000,
          level: 2,
        );

        when(() => mockApi.getProfile()).thenAnswer((_) async => userResponse);

        final result = await repository.getProfile();

        expect(result, equals(userResponse));
        verify(() => mockApi.getProfile()).called(1);
      });

      test('throws ApiException on network error', () async {
        final dioException = DioException(
          requestOptions: RequestOptions(path: '/users/me'),
          type: DioExceptionType.connectionTimeout,
          message: 'Connection timeout',
        );

        when(() => mockApi.getProfile()).thenThrow(dioException);

        expect(() => repository.getProfile(), throwsA(isA<ApiException>()));
      });

      test('throws ApiException on 401 unauthorized', () async {
        final dioException = DioException(
          requestOptions: RequestOptions(path: '/users/me'),
          type: DioExceptionType.badResponse,
          response: Response(
            requestOptions: RequestOptions(path: '/users/me'),
            statusCode: 401,
          ),
        );

        when(() => mockApi.getProfile()).thenThrow(dioException);

        expect(
          () => repository.getProfile(),
          throwsA(isA<UnauthorizedException>()),
        );
      });
    });

    group('updateProfile', () {
      test('returns updated UserResponse', () async {
        final updateRequest = UpdateUserRequest(
          firstName: 'Jane',
          lastName: 'Smith',
        );

        final updatedUser = UserResponse(
          id: '123',
          email: 'test@example.com',
          firstName: 'Jane',
          lastName: 'Smith',
          phoneNumber: '5551234567',
          profilePhotoUrl: null,
          preferredLanguage: 'tr',
          birthDate: DateTime(1990, 5, 15),
          role: 'TOURIST',
          expPoints: 1000,
          level: 2,
        );

        when(
          () => mockApi.updateProfile(any()),
        ).thenAnswer((_) async => updatedUser);

        final result = await repository.updateProfile(updateRequest);

        expect(result.firstName, equals('Jane'));
        expect(result.lastName, equals('Smith'));
        verify(() => mockApi.updateProfile(any())).called(1);
      });

      test('throws ApiException on validation error', () async {
        final updateRequest = UpdateUserRequest(firstName: '');
        final dioException = DioException(
          requestOptions: RequestOptions(path: '/users/me'),
          type: DioExceptionType.badResponse,
          response: Response(
            requestOptions: RequestOptions(path: '/users/me'),
            statusCode: 422,
            data: {
              'errors': {'firstName': 'First name is required'},
            },
          ),
        );

        when(() => mockApi.updateProfile(any())).thenThrow(dioException);

        expect(
          () => repository.updateProfile(updateRequest),
          throwsA(isA<ValidationException>()),
        );
      });
    });

    group('getFavorites', () {
      test('returns list of FavoriteResponse', () async {
        final favorites = [
          FavoriteResponse(
            id: 'fav1',
            placeId: 'place1',
            savedAt: DateTime.now(),
          ),
          FavoriteResponse(
            id: 'fav2',
            placeId: 'place2',
            savedAt: DateTime.now(),
          ),
        ];

        when(() => mockApi.getFavorites()).thenAnswer((_) async => favorites);

        final result = await repository.getFavorites();

        expect(result, hasLength(2));
        expect(result.first.id, equals('fav1'));
        verify(() => mockApi.getFavorites()).called(1);
      });

      test('returns empty list when no favorites', () async {
        when(() => mockApi.getFavorites()).thenAnswer((_) async => []);

        final result = await repository.getFavorites();

        expect(result, isEmpty);
      });
    });

    group('removeFavorite', () {
      test('successfully removes favorite', () async {
        when(
          () => mockApi.removeFavorite('fav1'),
        ).thenAnswer((_) async => Future.value());

        await repository.removeFavorite('fav1');

        verify(() => mockApi.removeFavorite('fav1')).called(1);
      });

      test('throws ApiException on removal failure', () async {
        final dioException = DioException(
          requestOptions: RequestOptions(path: '/users/me/favorites/fav1'),
          type: DioExceptionType.badResponse,
          response: Response(
            requestOptions: RequestOptions(path: '/users/me/favorites/fav1'),
            statusCode: 404,
          ),
        );

        when(() => mockApi.removeFavorite('fav1')).thenThrow(dioException);

        expect(
          () => repository.removeFavorite('fav1'),
          throwsA(isA<NotFoundException>()),
        );
      });
    });
  });
}
