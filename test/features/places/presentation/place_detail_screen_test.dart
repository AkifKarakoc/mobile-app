import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mobile/features/favorites/data/dto/favorite_response.dart';
import 'package:mobile/features/favorites/data/favorites_repository.dart';
import 'package:mobile/features/places/data/dto/place_detail_response.dart';
import 'package:mobile/features/places/data/places_repository.dart';
import 'package:mobile/features/places/presentation/place_detail_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../test_helpers/pump_app.dart';

class MockPlacesRepository extends Mock implements PlacesRepository {}

class MockFavoritesRepository extends Mock implements FavoritesRepository {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockPlacesRepository placesRepository;
  late MockFavoritesRepository favoritesRepository;

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });

  setUp(() {
    placesRepository = MockPlacesRepository();
    favoritesRepository = MockFavoritesRepository();
    when(() => favoritesRepository.getFavorites()).thenAnswer((_) async => []);
  });

  List<Override> overrides() {
    return [
      placesRepositoryProvider.overrideWithValue(placesRepository),
      favoritesRepositoryProvider.overrideWithValue(favoritesRepository),
    ];
  }

  group('PlaceDetailScreen', () {
    testWidgets('displays loading indicator while loading', (tester) async {
      final completer = Completer<PlaceDetailResponse>();
      when(
        () => placesRepository.getById('place1'),
      ).thenAnswer((_) => completer.future);

      await pumpAppWidget(
        tester,
        child: const PlaceDetailScreen(placeId: 'place1'),
        overrides: overrides(),
        settle: false,
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      completer.complete(_placeDetail());
      await tester.pump();
    });

    testWidgets('displays place detail when data loads', (tester) async {
      when(
        () => placesRepository.getById('place1'),
      ).thenAnswer((_) async => _placeDetail());

      await pumpAppWidget(
        tester,
        child: const PlaceDetailScreen(placeId: 'place1'),
        overrides: overrides(),
      );

      expect(find.text('İzmir Clock Tower'), findsWidgets);
      expect(
        find.text('Historic clock tower', skipOffstage: false),
        findsOneWidget,
      );
      expect(find.byIcon(Icons.directions_outlined), findsOneWidget);
      expect(find.byIcon(Icons.favorite_border), findsOneWidget);
    });

    testWidgets('displays error view when provider fails', (tester) async {
      when(
        () => placesRepository.getById('place1'),
      ).thenThrow(Exception('network'));

      await pumpAppWidget(
        tester,
        child: const PlaceDetailScreen(placeId: 'place1'),
        overrides: overrides(),
      );

      expect(find.byIcon(Icons.error_outline), findsOneWidget);
    });

    testWidgets('renders favorite button as selected when favorited', (
      tester,
    ) async {
      when(
        () => placesRepository.getById('place1'),
      ).thenAnswer((_) async => _placeDetail(isFavorited: true));
      when(() => favoritesRepository.getFavorites()).thenAnswer(
        (_) async => [
          FavoriteResponse(
            id: 'fav1',
            placeId: 'place1',
            savedAt: DateTime(2026, 5, 5, 12),
          ),
        ],
      );

      await pumpAppWidget(
        tester,
        child: const PlaceDetailScreen(placeId: 'place1'),
        overrides: overrides(),
      );

      expect(find.byIcon(Icons.favorite), findsOneWidget);
    });
  });
}

PlaceDetailResponse _placeDetail({bool isFavorited = false}) {
  return PlaceDetailResponse(
    id: 'place1',
    name: 'Clock Tower',
    nameTr: 'İzmir Clock Tower',
    nameEn: 'Izmir Clock Tower',
    category: 'landmark',
    latitude: 38.4189,
    longitude: 27.1287,
    description: 'Historic clock tower',
    address: 'Konak Square',
    phone: '+90 232 000 00 00',
    website: 'https://example.com',
    openingHours: '09:00 - 18:00',
    avgRating: 4.8,
    reviewCount: 24,
    isFavorited: isFavorited,
    popularityScore: 9,
    keywords: const ['history', 'konak'],
  );
}
