import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobile/features/places/application/location_provider.dart';
import 'package:mobile/features/places/data/dto/place_detail_response.dart';
import 'package:mobile/features/places/data/dto/place_response.dart';
import 'package:mobile/features/places/data/places_repository.dart';
import 'package:mobile/features/places/presentation/nearby_map_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../test_helpers/pump_app.dart';

class TestLocationNotifier extends LocationNotifier {
  TestLocationNotifier(this.locationBuilder);

  final FutureOr<LocationState> Function() locationBuilder;

  @override
  FutureOr<LocationState> build() => locationBuilder();

  @override
  Future<void> requestCurrentLocation() async {
    state = AsyncData(await locationBuilder());
  }

  @override
  Future<void> refreshLocation() async {
    state = AsyncData(await locationBuilder());
  }

  @override
  Future<bool> openAppSettings() async => true;

  @override
  Future<bool> openLocationSettings() async => true;
}

class FakePlacesRepository implements PlacesRepository {
  FakePlacesRepository({required this.nearbyPlaces});

  final List<PlaceResponse> nearbyPlaces;

  @override
  Future<List<PlaceResponse>> getNearby({
    required double latitude,
    required double longitude,
    int? radius,
    int? limit,
    String? category,
  }) async {
    return nearbyPlaces;
  }

  @override
  Future<PlaceDetailResponse> getById(String id) {
    throw UnimplementedError();
  }

  @override
  Future<List<PlaceResponse>> search(String query) {
    throw UnimplementedError();
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });

  group('NearbyMapScreen', () {
    testWidgets('shows permission denied state', (tester) async {
      await pumpAppWidget(
        tester,
        child: const NearbyMapScreen(),
        overrides: [
          currentLocationProvider.overrideWith(
            () => TestLocationNotifier(() => const LocationPermissionDenied()),
          ),
        ],
      );

      expect(find.byType(NearbyMapScreen), findsOneWidget);
      expect(find.byIcon(Icons.location_disabled_outlined), findsOneWidget);
      expect(find.text('places.map.permission_denied_title'), findsOneWidget);
    });

    testWidgets('shows location service disabled state', (tester) async {
      await pumpAppWidget(
        tester,
        child: const NearbyMapScreen(),
        overrides: [
          currentLocationProvider.overrideWith(
            () => TestLocationNotifier(() => const LocationServiceDisabled()),
          ),
        ],
      );

      expect(find.byIcon(Icons.location_off_outlined), findsOneWidget);
      expect(
        find.text('places.map.location_service_disabled_title'),
        findsOneWidget,
      );
    });

    testWidgets('shows empty state when there are no mapped places', (
      tester,
    ) async {
      await pumpAppWidget(
        tester,
        child: const NearbyMapScreen(),
        overrides: [
          currentLocationProvider.overrideWith(
            () => TestLocationNotifier(() => LocationReady(_testPosition())),
          ),
          placesRepositoryProvider.overrideWithValue(
            FakePlacesRepository(nearbyPlaces: const []),
          ),
        ],
      );

      expect(find.byIcon(Icons.travel_explore_outlined), findsOneWidget);
      expect(find.text('places.map.empty_title'), findsOneWidget);
    });

    testWidgets('can render data state without mounting platform map', (
      tester,
    ) async {
      const place = PlaceResponse(
        id: '8ad7b6fa-5d7d-4a90-8474-a778dbce2157',
        nameTr: 'Izmir Saat Kulesi',
        nameEn: 'Izmir Clock Tower',
        category: 'LANDMARK',
        latitude: 38.4192,
        longitude: 27.1287,
        avgRating: 4.7,
        distance: 125,
      );

      await pumpAppWidget(
        tester,
        child: const NearbyMapScreen(),
        overrides: [
          nearbyMapGoogleMapEnabledProvider.overrideWithValue(false),
          currentLocationProvider.overrideWith(
            () => TestLocationNotifier(() => LocationReady(_testPosition())),
          ),
          placesRepositoryProvider.overrideWithValue(
            FakePlacesRepository(nearbyPlaces: const [place]),
          ),
        ],
      );

      expect(find.byKey(const Key('nearby-map-placeholder')), findsOneWidget);
      expect(find.text('places.map.places_count'), findsOneWidget);
    });
  });
}

Position _testPosition() {
  return Position(
    latitude: 38.4192,
    longitude: 27.1287,
    timestamp: DateTime(2026, 5, 5),
    accuracy: 1,
    altitude: 0,
    altitudeAccuracy: 0,
    heading: 0,
    headingAccuracy: 0,
    speed: 0,
    speedAccuracy: 0,
  );
}
