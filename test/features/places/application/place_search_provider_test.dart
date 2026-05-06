import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mobile/features/places/application/place_search_provider.dart';
import 'package:mobile/features/places/data/dto/place_response.dart';
import 'package:mobile/features/places/data/places_repository.dart';
import 'package:mobile/features/places/data/recent_searches_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockPlacesRepository extends Mock implements PlacesRepository {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('RecentSearchesStorage', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    test(
      'keeps max five recent queries and moves duplicates to front',
      () async {
        final prefs = await SharedPreferences.getInstance();
        final storage = RecentSearchesStorage(prefs);

        await storage.saveQuery('clock');
        await storage.saveQuery('museum');
        await storage.saveQuery('park');
        await storage.saveQuery('beach');
        await storage.saveQuery('agora');
        await storage.saveQuery('Museum');

        expect(await storage.getRecentSearches(), [
          'Museum',
          'agora',
          'beach',
          'park',
          'clock',
        ]);
      },
    );

    test('clear removes all recent queries', () async {
      final prefs = await SharedPreferences.getInstance();
      final storage = RecentSearchesStorage(prefs);

      await storage.saveQuery('clock');
      await storage.clear();

      expect(await storage.getRecentSearches(), isEmpty);
    });
  });

  group('PlaceSearchNotifier', () {
    late MockPlacesRepository repository;

    setUp(() {
      SharedPreferences.setMockInitialValues({});
      repository = MockPlacesRepository();
    });

    ProviderContainer createContainer() {
      final container = ProviderContainer(
        overrides: [
          placesRepositoryProvider.overrideWithValue(repository),
          placeSearchProvider.overrideWith(
            () => PlaceSearchNotifier(
              debounceDuration: const Duration(milliseconds: 20),
            ),
          ),
        ],
      );
      final subscription = container.listen(
        placeSearchProvider,
        (previous, next) {},
        fireImmediately: true,
      );
      addTearDown(subscription.close);
      addTearDown(container.dispose);
      return container;
    }

    test('does not call repository for short queries', () async {
      final container = createContainer();

      container.read(placeSearchProvider.notifier).updateQuery('a');
      await Future<void>.delayed(const Duration(milliseconds: 40));

      verifyNever(() => repository.search(any()));
      expect(container.read(placeSearchProvider).results.value, isEmpty);
    });

    test(
      'debounces search and only calls repository with latest query',
      () async {
        const places = [
          PlaceResponse(
            id: 'place-1',
            name: 'Agora Open Air Museum',
            category: 'MUSEUM',
          ),
        ];
        when(() => repository.search('ago')).thenAnswer((_) async => places);

        final container = createContainer();
        final notifier = container.read(placeSearchProvider.notifier);

        notifier.updateQuery('ag');
        notifier.updateQuery('ago');
        await Future<void>.delayed(const Duration(milliseconds: 60));

        expect(container.read(placeSearchProvider).results.value, places);
        verify(() => repository.search('ago')).called(1);
        verifyNever(() => repository.search('ag'));
      },
    );
  });
}
