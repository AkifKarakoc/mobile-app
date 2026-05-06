import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mobile/core/network/api_exception.dart';
import 'package:mobile/features/places/data/dto/place_detail_response.dart';
import 'package:mobile/features/places/data/dto/place_response.dart';
import 'package:mobile/features/places/data/places_api.dart';
import 'package:mobile/features/places/data/places_repository.dart';

class MockPlacesApi extends Mock implements PlacesApi {}

void main() {
  group('PlacesRepository', () {
    late MockPlacesApi mockApi;
    late PlacesRepository repository;

    setUp(() {
      mockApi = MockPlacesApi();
      repository = PlacesRepositoryImpl(mockApi);
    });

    group('getNearby', () {
      test('returns nearby places on successful API call', () async {
        const places = [
          PlaceResponse(
            id: '8ad7b6fa-5d7d-4a90-8474-a778dbce2157',
            name: 'Izmir Clock Tower',
            nameTr: 'Izmir Saat Kulesi',
            nameEn: 'Izmir Clock Tower',
            category: 'LANDMARK',
            latitude: 38.4192,
            longitude: 27.1287,
            address: 'Konak, Izmir',
            photoUrl: 'https://example.com/clock-tower.jpg',
            avgRating: 4.7,
            reviewCount: 42,
            distance: 125.4,
            isFavorited: true,
          ),
        ];

        when(
          () => mockApi.getNearby(
            latitude: any(named: 'latitude'),
            longitude: any(named: 'longitude'),
            radius: any(named: 'radius'),
            limit: any(named: 'limit'),
          ),
        ).thenAnswer((_) async => places);

        final result = await repository.getNearby(
          latitude: 38.4192,
          longitude: 27.1287,
          radius: 1000,
          limit: 20,
        );

        expect(result, equals(places));
        expect(result.single.isFavorited, isTrue);
        verify(
          () => mockApi.getNearby(
            latitude: 38.4192,
            longitude: 27.1287,
            radius: 1000,
            limit: 20,
          ),
        ).called(1);
      });

      test('throws UnauthorizedException on 401 response', () async {
        final dioException = DioException(
          requestOptions: RequestOptions(path: '/places/nearby'),
          response: Response(
            requestOptions: RequestOptions(path: '/places/nearby'),
            statusCode: 401,
          ),
          type: DioExceptionType.badResponse,
        );

        when(
          () => mockApi.getNearby(
            latitude: any(named: 'latitude'),
            longitude: any(named: 'longitude'),
            radius: any(named: 'radius'),
            limit: any(named: 'limit'),
          ),
        ).thenThrow(dioException);

        expect(
          () => repository.getNearby(latitude: 38.4192, longitude: 27.1287),
          throwsA(isA<UnauthorizedException>()),
        );
      });

      test('throws NetworkException on connection timeout', () async {
        final dioException = DioException(
          requestOptions: RequestOptions(path: '/places/nearby'),
          type: DioExceptionType.connectionTimeout,
          message: 'Connection timeout',
        );

        when(
          () => mockApi.getNearby(
            latitude: any(named: 'latitude'),
            longitude: any(named: 'longitude'),
            radius: any(named: 'radius'),
            limit: any(named: 'limit'),
          ),
        ).thenThrow(dioException);

        expect(
          () => repository.getNearby(latitude: 38.4192, longitude: 27.1287),
          throwsA(isA<NetworkException>()),
        );
      });
    });

    group('getById', () {
      test('returns place detail on successful API call', () async {
        const detail = PlaceDetailResponse(
          id: '8ad7b6fa-5d7d-4a90-8474-a778dbce2157',
          name: 'Izmir Clock Tower',
          nameTr: 'Izmir Saat Kulesi',
          nameEn: 'Izmir Clock Tower',
          category: 'LANDMARK',
          latitude: 38.4192,
          longitude: 27.1287,
          description: 'Historic clock tower in Konak Square.',
          address: 'Konak, Izmir',
          phone: '+902321234567',
          website: 'https://example.com',
          openingHours: '09:00-18:00',
          photoUrl: 'https://example.com/clock-tower.jpg',
          avgRating: 4.7,
          reviewCount: 42,
          isFavorited: true,
          popularityScore: 95,
          keywords: ['konak', 'landmark'],
        );

        when(() => mockApi.getById(detail.id)).thenAnswer((_) async => detail);

        final result = await repository.getById(detail.id);

        expect(result, equals(detail));
        expect(result.keywords, contains('konak'));
        verify(() => mockApi.getById(detail.id)).called(1);
      });
    });

    group('search', () {
      test('returns places matching query on successful API call', () async {
        const places = [
          PlaceResponse(
            id: 'f222e5a2-55a7-460d-a9c6-1f1860cb27df',
            name: 'Agora Open Air Museum',
            category: 'MUSEUM',
          ),
        ];

        when(() => mockApi.search('agora')).thenAnswer((_) async => places);

        final result = await repository.search('agora');

        expect(result, equals(places));
        verify(() => mockApi.search('agora')).called(1);
      });
    });
  });
}
