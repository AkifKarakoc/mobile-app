import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mobile/core/network/api_exception.dart';
import 'package:mobile/features/routes/data/dto/route_response.dart';
import 'package:mobile/features/routes/data/routes_api.dart';
import 'package:mobile/features/routes/data/routes_repository.dart';

class MockRoutesApi extends Mock implements RoutesApi {}

void main() {
  late MockRoutesApi mockApi;
  late RoutesRepository repository;

  setUpAll(() {
    registerFallbackValue(RequestOptions(path: '/routes'));
  });

  setUp(() {
    mockApi = MockRoutesApi();
    repository = RoutesRepositoryImpl(mockApi);
  });

  group('getAll', () {
    test('returns routes on successful API call', () async {
      final routes = [
        RouteResponse(
          id: 'a1b2c3d4-e5f6-7890-abcd-ef1234567890',
          name: 'Historic Izmir Tour',
          description: 'Explore the historic sites of Izmir',
          createdAt: DateTime(2026, 5, 1),
          centerLatitude: 38.4192,
          centerLongitude: 27.1287,
          radiusMeters: 5000,
          estimatedMinutes: 120,
          expReward: 150,
          thumbnailUrl: 'https://example.com/route.jpg',
          totalStops: 5,
          places: [],
        ),
      ];

      when(
        () => mockApi.getAll(
          latitude: any(named: 'latitude'),
          longitude: any(named: 'longitude'),
        ),
      ).thenAnswer((_) async => routes);

      final result = await repository.getAll(
        latitude: 38.4192,
        longitude: 27.1287,
      );

      expect(result, equals(routes));
      expect(result.single.name, equals('Historic Izmir Tour'));
      verify(
        () => mockApi.getAll(
          latitude: 38.4192,
          longitude: 27.1287,
        ),
      ).called(1);
    });

    test('throws NetworkException on connection timeout', () async {
      final dioException = DioException(
        requestOptions: RequestOptions(path: '/routes'),
        type: DioExceptionType.connectionTimeout,
        message: 'Connection timeout',
      );

      when(
        () => mockApi.getAll(
          latitude: any(named: 'latitude'),
          longitude: any(named: 'longitude'),
        ),
      ).thenThrow(dioException);

      expect(
        () => repository.getAll(latitude: 38.4192, longitude: 27.1287),
        throwsA(isA<NetworkException>()),
      );
    });
  });

  group('getById', () {
    test('returns route detail on successful API call', () async {
      final route = RouteResponse(
        id: 'a1b2c3d4-e5f6-7890-abcd-ef1234567890',
        name: 'Historic Izmir Tour',
        description: 'Explore the historic sites of Izmir',
        createdAt: DateTime(2026, 5, 1),
        centerLatitude: 38.4192,
        centerLongitude: 27.1287,
        radiusMeters: 5000,
        estimatedMinutes: 120,
        expReward: 150,
        thumbnailUrl: 'https://example.com/route.jpg',
        totalStops: 5,
        places: [
          RoutePlaceResponse(
            id: 'rp1',
            placeId: 'p1',
            stopOrder: 1,
            estimatedMinutes: 30,
            notes: 'Start here',
          ),
          RoutePlaceResponse(
            id: 'rp2',
            placeId: 'p2',
            stopOrder: 2,
            estimatedMinutes: 45,
          ),
        ],
      );

      when(() => mockApi.getById(route.id)).thenAnswer((_) async => route);

      final result = await repository.getById(route.id);

      expect(result, equals(route));
      expect(result.places.length, equals(2));
      expect(result.places.first.notes, equals('Start here'));
      verify(() => mockApi.getById(route.id)).called(1);
    });

    test('throws NotFoundException on 404 response', () async {
      final dioException = DioException(
        requestOptions: RequestOptions(path: '/routes/nonexistent'),
        response: Response(
          requestOptions: RequestOptions(path: '/routes/nonexistent'),
          statusCode: 404,
        ),
        type: DioExceptionType.badResponse,
      );

      when(() => mockApi.getById('nonexistent')).thenThrow(dioException);

      expect(
        () => repository.getById('nonexistent'),
        throwsA(isA<NotFoundException>()),
      );
    });

    test('throws NetworkException on connection error', () async {
      final dioException = DioException(
        requestOptions: RequestOptions(path: '/routes/some-id'),
        type: DioExceptionType.connectionError,
        message: 'Connection error',
      );

      when(() => mockApi.getById('some-id')).thenThrow(dioException);

      expect(
        () => repository.getById('some-id'),
        throwsA(isA<NetworkException>()),
      );
    });
  });
}
