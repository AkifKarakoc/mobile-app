import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mobile/core/network/api_exception.dart';
import 'package:mobile/features/places/application/place_detail_provider.dart';
import 'package:mobile/features/places/data/dto/place_detail_response.dart';
import 'package:mobile/features/places/data/places_repository.dart';

class MockPlacesRepository extends Mock implements PlacesRepository {}

void main() {
  group('PlaceDetailProvider', () {
    late MockPlacesRepository repository;

    setUp(() {
      repository = MockPlacesRepository();
    });

    ProviderContainer createContainer() {
      final container = ProviderContainer(
        overrides: [placesRepositoryProvider.overrideWithValue(repository)],
      );
      addTearDown(container.dispose);
      return container;
    }

    test('loads place detail by id', () async {
      final place = _placeDetail();
      when(() => repository.getById('place1')).thenAnswer((_) async => place);

      final container = createContainer();

      final result = await container.read(placeDetailProvider('place1').future);

      expect(result, place);
      verify(() => repository.getById('place1')).called(1);
    });

    test('stores AsyncError when repository fails', () async {
      when(
        () => repository.getById('missing'),
      ).thenThrow(const ApiException.notFound('Not found'));

      final container = createContainer();

      await expectLater(
        container.read(placeDetailProvider('missing').future),
        throwsA(isA<NotFoundException>()),
      );

      final state = container.read(placeDetailProvider('missing'));
      expect(state.hasError, isTrue);
      expect(state.error, isA<NotFoundException>());
    });

    test('refresh reloads current place id', () async {
      final initial = _placeDetail(name: 'Initial');
      final refreshed = _placeDetail(name: 'Refreshed');
      when(() => repository.getById('place1')).thenAnswer((_) async => initial);

      final container = createContainer();
      await container.read(placeDetailProvider('place1').future);

      when(
        () => repository.getById('place1'),
      ).thenAnswer((_) async => refreshed);

      await container.read(placeDetailProvider('place1').notifier).refresh();

      expect(container.read(placeDetailProvider('place1')).value, refreshed);
      verify(() => repository.getById('place1')).called(2);
    });
  });
}

PlaceDetailResponse _placeDetail({String name = 'Clock Tower'}) {
  return PlaceDetailResponse(
    id: 'place1',
    name: name,
    nameTr: name,
    nameEn: name,
    category: 'landmark',
    latitude: 38.4192,
    longitude: 27.1287,
    description: 'Historic tower',
    address: 'Konak',
    avgRating: 4.7,
    reviewCount: 12,
    isFavorited: false,
    popularityScore: 9,
    keywords: const ['history', 'konak'],
  );
}
