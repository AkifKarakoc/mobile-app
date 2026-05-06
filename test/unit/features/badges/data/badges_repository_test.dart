import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mobile/core/network/api_exception.dart';
import 'package:mobile/features/badges/data/badges_api.dart';
import 'package:mobile/features/badges/data/badges_repository.dart';
import 'package:mobile/features/badges/data/dto/badge_response.dart';

class MockBadgesApi extends Mock implements BadgesApi {}

void main() {
  late MockBadgesApi mockApi;
  late BadgesRepository repository;

  setUpAll(() {
    registerFallbackValue(RequestOptions(path: '/badges'));
  });

  setUp(() {
    mockApi = MockBadgesApi();
    repository = BadgesRepositoryImpl(mockApi);
  });

  group('BadgesRepository', () {
    group('getAllBadges', () {
      test('returns all badges on successful API call', () async {
        const badges = [
          BadgeResponse(
            id: 'badge-1',
            name: 'Explorer',
            description: 'Visit 10 places',
            iconName: 'explore',
            iconColor: '#CD7F32',
            tier: 'BRONZE',
            earnedByUser: true,
          ),
          BadgeResponse(
            id: 'badge-2',
            name: 'Historian',
            description: 'Visit 5 museums',
            iconName: 'museum',
            iconColor: '#FFD700',
            tier: 'GOLD',
            earnedByUser: false,
          ),
        ];

        when(() => mockApi.getAllBadges()).thenAnswer((_) async => badges);

        final result = await repository.getAllBadges();

        expect(result, equals(badges));
        expect(result.first.earnedByUser, isTrue);
        expect(result.last.earnedByUser, isFalse);
        verify(() => mockApi.getAllBadges()).called(1);
      });

      test('throws NetworkException on connection timeout', () async {
        final dioException = DioException(
          requestOptions: RequestOptions(path: '/badges'),
          type: DioExceptionType.connectionTimeout,
          message: 'Connection timeout',
        );

        when(() => mockApi.getAllBadges()).thenThrow(dioException);

        expect(
          () => repository.getAllBadges(),
          throwsA(isA<NetworkException>()),
        );
      });

      test('throws UnauthorizedException on 401 response', () async {
        final dioException = DioException(
          requestOptions: RequestOptions(path: '/badges'),
          response: Response(
            requestOptions: RequestOptions(path: '/badges'),
            statusCode: 401,
          ),
          type: DioExceptionType.badResponse,
        );

        when(() => mockApi.getAllBadges()).thenThrow(dioException);

        expect(
          () => repository.getAllBadges(),
          throwsA(isA<UnauthorizedException>()),
        );
      });
    });

    group('getMyBadges', () {
      test('returns user badges on successful API call', () async {
        final myBadges = [
          UserBadgeResponse(
            id: 'ub-1',
            badgeId: 'badge-1',
            badgeName: 'Explorer',
            badgeDescription: 'Visit 10 places',
            badgeIconName: 'explore',
            badgeIconColor: '#CD7F32',
            earnedAt: DateTime(2026, 5, 1, 14, 30),
          ),
        ];

        when(() => mockApi.getMyBadges()).thenAnswer((_) async => myBadges);

        final result = await repository.getMyBadges();

        expect(result, equals(myBadges));
        expect(result.single.badgeName, equals('Explorer'));
        verify(() => mockApi.getMyBadges()).called(1);
      });

      test('throws NetworkException on connection error', () async {
        final dioException = DioException(
          requestOptions: RequestOptions(path: '/users/me/badges'),
          type: DioExceptionType.connectionError,
          message: 'Connection error',
        );

        when(() => mockApi.getMyBadges()).thenThrow(dioException);

        expect(
          () => repository.getMyBadges(),
          throwsA(isA<NetworkException>()),
        );
      });

      test('throws ServerException on 500 response', () async {
        final dioException = DioException(
          requestOptions: RequestOptions(path: '/users/me/badges'),
          response: Response(
            requestOptions: RequestOptions(path: '/users/me/badges'),
            statusCode: 500,
          ),
          type: DioExceptionType.badResponse,
        );

        when(() => mockApi.getMyBadges()).thenThrow(dioException);

        expect(
          () => repository.getMyBadges(),
          throwsA(isA<ServerException>()),
        );
      });
    });
  });
}
