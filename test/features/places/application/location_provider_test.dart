import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobile/features/places/application/location_provider.dart';

class _FakeLocationClient implements LocationClient {
  _FakeLocationClient(this.currentPosition);

  Position currentPosition;
  int getCurrentPositionCalls = 0;

  @override
  Future<bool> isLocationServiceEnabled() async => true;

  @override
  Future<LocationPermission> checkPermission() async =>
      LocationPermission.whileInUse;

  @override
  Future<LocationPermission> requestPermission() async =>
      LocationPermission.whileInUse;

  @override
  Future<Position> getCurrentPosition() async {
    getCurrentPositionCalls += 1;
    return currentPosition;
  }

  @override
  Future<bool> openAppSettings() async => true;

  @override
  Future<bool> openLocationSettings() async => true;
}

Position _position(double latitude, double longitude) {
  return Position(
    longitude: longitude,
    latitude: latitude,
    timestamp: DateTime(2026, 11, 19, 15, 0),
    accuracy: 5,
    altitude: 0,
    altitudeAccuracy: 1,
    heading: 0,
    headingAccuracy: 1,
    speed: 0,
    speedAccuracy: 1,
  );
}

void main() {
  group('LocationNotifier', () {
    final mountainView = _position(37.4219983, -122.084);
    final izmir = _position(38.4237, 27.1428);
    final izmirNearbyDrift = _position(38.42375, 27.14285);

    test('refreshLocation bypasses cache and picks up Izmir coordinates', () async {
      final client = _FakeLocationClient(mountainView);
      final container = ProviderContainer(
        overrides: [locationClientProvider.overrideWithValue(client)],
      );
      addTearDown(container.dispose);

      final initial = await container.read(currentLocationProvider.future);
      expect(initial, isA<LocationReady>());
      expect((initial as LocationReady).position.latitude, mountainView.latitude);

      client.currentPosition = izmir;
      await container.read(currentLocationProvider.notifier).refreshLocation();

      final updated = container.read(currentLocationProvider).valueOrNull;
      expect(updated, isA<LocationReady>());
      expect((updated as LocationReady).position.latitude, izmir.latitude);
      expect(updated.position.longitude, izmir.longitude);
      expect(client.getCurrentPositionCalls, 2);
    });

    test('getQueryPosition detects movement > 25m and returns new coordinates', () async {
      var fakeNow = DateTime(2026, 11, 19, 15, 0);
      final client = _FakeLocationClient(mountainView);
      final container = ProviderContainer(
        overrides: [
          locationClientProvider.overrideWithValue(client),
          clockProvider.overrideWithValue(() => fakeNow),
        ],
      );
      addTearDown(container.dispose);

      await container.read(currentLocationProvider.future);
      final notifier = container.read(currentLocationProvider.notifier);
      final first = await notifier.getQueryPosition();
      expect(first.latitude, mountainView.latitude);

      client.currentPosition = izmir;
      fakeNow = fakeNow.add(const Duration(seconds: 5));
      final moved = await notifier.getQueryPosition();
      expect(moved.latitude, izmir.latitude);
      expect(moved.longitude, izmir.longitude);
    });

    test('getQueryPosition reuses stabilized position within 25m and 15m window', () async {
      var fakeNow = DateTime(2026, 11, 19, 15, 0);
      final client = _FakeLocationClient(izmir);
      final container = ProviderContainer(
        overrides: [
          locationClientProvider.overrideWithValue(client),
          clockProvider.overrideWithValue(() => fakeNow),
        ],
      );
      addTearDown(container.dispose);

      final first = await container.read(queryPositionProvider.future);
      expect(first.latitude, izmir.latitude);

      client.currentPosition = izmirNearbyDrift;
      fakeNow = fakeNow.add(const Duration(seconds: 5));
      final second = await container.read(currentLocationProvider.notifier).getQueryPosition();
      expect(second.latitude, izmir.latitude);
      expect(second.longitude, izmir.longitude);
    });
  });
}
