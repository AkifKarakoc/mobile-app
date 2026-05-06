import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart' as permissions;

sealed class LocationState {
  const LocationState();
}

class LocationReady extends LocationState {
  const LocationReady(this.position);

  final Position position;
}

class LocationServiceDisabled extends LocationState {
  const LocationServiceDisabled();
}

class LocationPermissionDenied extends LocationState {
  const LocationPermissionDenied();
}

class LocationPermissionPermanentlyDenied extends LocationState {
  const LocationPermissionPermanentlyDenied();
}

abstract class LocationClient {
  Future<bool> isLocationServiceEnabled();

  Future<LocationPermission> checkPermission();

  Future<LocationPermission> requestPermission();

  Future<Position> getCurrentPosition();

  Future<bool> openAppSettings();

  Future<bool> openLocationSettings();
}

class GeolocatorLocationClient implements LocationClient {
  const GeolocatorLocationClient();

  @override
  Future<bool> isLocationServiceEnabled() {
    return Geolocator.isLocationServiceEnabled();
  }

  @override
  Future<LocationPermission> checkPermission() {
    return Geolocator.checkPermission();
  }

  @override
  Future<LocationPermission> requestPermission() {
    return Geolocator.requestPermission();
  }

  @override
  Future<Position> getCurrentPosition() {
    return Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    );
  }

  @override
  Future<bool> openAppSettings() {
    return permissions.openAppSettings();
  }

  @override
  Future<bool> openLocationSettings() {
    return Geolocator.openLocationSettings();
  }
}

final locationClientProvider = Provider<LocationClient>((ref) {
  return const GeolocatorLocationClient();
});

class LocationNotifier extends AutoDisposeAsyncNotifier<LocationState> {
  late final LocationClient _client;

  @override
  FutureOr<LocationState> build() {
    _client = ref.watch(locationClientProvider);
    return _resolveLocation(requestIfDenied: true);
  }

  Future<void> refreshLocation() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => _resolveLocation(requestIfDenied: false),
    );
  }

  Future<void> requestCurrentLocation() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => _resolveLocation(requestIfDenied: true),
    );
  }

  Future<bool> openAppSettings() {
    return _client.openAppSettings();
  }

  Future<bool> openLocationSettings() {
    return _client.openLocationSettings();
  }

  Future<LocationState> _resolveLocation({
    required bool requestIfDenied,
  }) async {
    final serviceEnabled = await _client.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return const LocationServiceDisabled();
    }

    var permission = await _client.checkPermission();
    if (permission == LocationPermission.denied && requestIfDenied) {
      permission = await _client.requestPermission();
    }

    return switch (permission) {
      LocationPermission.denied => const LocationPermissionDenied(),
      LocationPermission.deniedForever =>
        const LocationPermissionPermanentlyDenied(),
      LocationPermission.unableToDetermine => const LocationPermissionDenied(),
      LocationPermission.whileInUse || LocationPermission.always =>
        LocationReady(await _client.getCurrentPosition()),
    };
  }
}

final currentLocationProvider =
    AsyncNotifierProvider.autoDispose<LocationNotifier, LocationState>(
      LocationNotifier.new,
    );
