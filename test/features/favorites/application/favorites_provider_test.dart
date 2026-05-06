import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mobile/core/network/api_exception.dart';
import 'package:mobile/features/favorites/application/favorites_provider.dart';
import 'package:mobile/features/favorites/data/dto/favorite_response.dart';
import 'package:mobile/features/favorites/data/favorites_repository.dart';

class MockFavoritesRepository extends Mock implements FavoritesRepository {}

void main() {
  group('FavoritesProvider', () {
    late MockFavoritesRepository repository;

    setUp(() {
      repository = MockFavoritesRepository();
    });

    ProviderContainer createContainer() {
      final container = ProviderContainer(
        overrides: [favoritesRepositoryProvider.overrideWithValue(repository)],
      );
      addTearDown(container.dispose);
      return container;
    }

    test('loads favorites on initial build', () async {
      final favorites = [_favorite(id: 'fav1', placeId: 'place1')];
      when(() => repository.getFavorites()).thenAnswer((_) async => favorites);

      final container = createContainer();

      final result = await container.read(favoritesProvider.future);

      expect(result, favorites);
      verify(() => repository.getFavorites()).called(1);
    });

    test('favoriteStatusProvider maps place id to favorite id', () async {
      when(
        () => repository.getFavorites(),
      ).thenAnswer((_) async => [_favorite(id: 'fav1', placeId: 'place1')]);

      final container = createContainer();
      await container.read(favoritesProvider.future);

      final favorited = container.read(favoriteStatusProvider('place1'));
      final notFavorited = container.read(favoriteStatusProvider('place2'));

      expect(favorited.value?.isFavorited, isTrue);
      expect(favorited.value?.favoriteId, 'fav1');
      expect(notFavorited.value?.isFavorited, isFalse);
      expect(notFavorited.value?.favoriteId, isNull);
    });

    test('toggleFavorite adds favorite when currently not favorited', () async {
      final addedFavorite = _favorite(id: 'fav2', placeId: 'place2');
      when(() => repository.getFavorites()).thenAnswer((_) async => []);
      when(
        () => repository.addFavorite('place2'),
      ).thenAnswer((_) async => addedFavorite);

      final container = createContainer();
      await container.read(favoritesProvider.future);

      await container
          .read(favoritesProvider.notifier)
          .toggleFavorite('place2', currentlyFavorited: false);

      final state = container.read(favoritesProvider);
      expect(state.value, [addedFavorite]);
      verify(() => repository.addFavorite('place2')).called(1);
      verifyNever(() => repository.removeFavorite(any()));
    });

    test(
      'toggleFavorite removes by favorite id when currently favorited',
      () async {
        final favorite = _favorite(id: 'fav1', placeId: 'place1');
        when(
          () => repository.getFavorites(),
        ).thenAnswer((_) async => [favorite]);
        when(() => repository.removeFavorite('fav1')).thenAnswer((_) async {});

        final container = createContainer();
        await container.read(favoritesProvider.future);

        await container
            .read(favoritesProvider.notifier)
            .toggleFavorite(
              'place1',
              currentlyFavorited: true,
              favoriteId: 'fav1',
            );

        final state = container.read(favoritesProvider);
        expect(state.value, isEmpty);
        verify(() => repository.removeFavorite('fav1')).called(1);
        verifyNever(() => repository.removeFavorite('place1'));
      },
    );

    test('removeFavorite rethrows error and stores AsyncError', () async {
      final favorite = _favorite(id: 'fav1', placeId: 'place1');
      when(() => repository.getFavorites()).thenAnswer((_) async => [favorite]);
      when(
        () => repository.removeFavorite('fav1'),
      ).thenThrow(const ApiException.notFound('Not found'));

      final container = createContainer();
      await container.read(favoritesProvider.future);

      expect(
        () => container.read(favoritesProvider.notifier).removeFavorite('fav1'),
        throwsA(isA<NotFoundException>()),
      );

      final state = container.read(favoritesProvider);
      expect(state.hasError, isTrue);
      expect(state.error, isA<NotFoundException>());
    });
  });
}

FavoriteResponse _favorite({required String id, required String placeId}) {
  return FavoriteResponse(
    id: id,
    placeId: placeId,
    savedAt: DateTime(2026, 5, 5, 12),
  );
}
