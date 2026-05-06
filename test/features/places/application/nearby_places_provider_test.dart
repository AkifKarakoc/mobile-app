import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mobile/features/places/application/nearby_places_provider.dart';
import 'package:mobile/features/places/data/dto/place_response.dart';
import 'package:mobile/features/places/data/places_repository.dart';

class MockPlacesRepository extends Mock implements PlacesRepository {}

void main() {
  group('nearbyPlacesProvider', () {
    late MockPlacesRepository repository;
    late ProviderContainer container;

    const places = [
      PlaceResponse(
        id: '8ad7b6fa-5d7d-4a90-8474-a778dbce2157',
        name: 'Izmir Clock Tower',
        nameTr: 'Izmir Saat Kulesi',
        nameEn: 'Izmir Clock Tower',
        category: 'LANDMARK',
        latitude: 38.4192,
        longitude: 27.1287,
        avgRating: 4.7,
        distance: 125.4,
      ),
    ];

    final query = nearbyPlacesQuery(
      latitude: 38.4192,
      longitude: 27.1287,
      radius: 1000,
      limit: 20,
    );

    setUp(() {
      repository = MockPlacesRepository();
      container = ProviderContainer(
        overrides: [placesRepositoryProvider.overrideWithValue(repository)],
      );
    });

    tearDown(() {
      container.dispose();
    });

    test('loads nearby places through repository', () async {
      when(
        () => repository.getNearby(
          latitude: any(named: 'latitude'),
          longitude: any(named: 'longitude'),
          radius: any(named: 'radius'),
          limit: any(named: 'limit'),
        ),
      ).thenAnswer((_) async => places);

      final result = await container.read(nearbyPlacesProvider(query).future);

      expect(result, equals(places));
      verify(
        () => repository.getNearby(
          latitude: 38.4192,
          longitude: 27.1287,
          radius: 1000,
          limit: 20,
        ),
      ).called(1);
    });

    test('exposes repository errors as AsyncError', () async {
      final error = Exception('nearby failed');
      when(
        () => repository.getNearby(
          latitude: any(named: 'latitude'),
          longitude: any(named: 'longitude'),
          radius: any(named: 'radius'),
          limit: any(named: 'limit'),
        ),
      ).thenThrow(error);

      await expectLater(
        container.read(nearbyPlacesProvider(query).future),
        throwsA(same(error)),
      );

      final state = container.read(nearbyPlacesProvider(query));
      expect(state, isA<AsyncError<List<PlaceResponse>>>());
    });

    test('refresh reloads the active query', () async {
      when(
        () => repository.getNearby(
          latitude: any(named: 'latitude'),
          longitude: any(named: 'longitude'),
          radius: any(named: 'radius'),
          limit: any(named: 'limit'),
        ),
      ).thenAnswer((_) async => places);

      await container.read(nearbyPlacesProvider(query).future);
      await container.read(nearbyPlacesProvider(query).notifier).refresh();

      verify(
        () => repository.getNearby(
          latitude: 38.4192,
          longitude: 27.1287,
          radius: 1000,
          limit: 20,
        ),
      ).called(2);
    });
  });
}
