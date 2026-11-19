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

final clockProvider = Provider<DateTime Function()>((ref) => DateTime.now);

class LocationNotifier extends AutoDisposeAsyncNotifier<LocationState> {
  late final LocationClient _client;
  DateTime Function() _now = DateTime.now;
  Position? _lastKnownPosition;
  DateTime? _lastFetchTime;
  
  // Cache for API queries
  Position? _lastQueryPosition;
  DateTime? _lastQueryTime;
  
  static const _cacheDuration = Duration(seconds: 2);
  static const _queryCacheDistanceMeters = 25.0;
  static const _queryCacheDuration = Duration(minutes: 15);

  @override
  FutureOr<LocationState> build() {
    _client = ref.watch(locationClientProvider);
    _now = ref.watch(clockProvider);
    ref.keepAlive(); // Keep state alive across navigation
    return _resolveLocation(requestIfDenied: true);
  }

  Future<void> refreshLocation() async {
    _clearCache();
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => _resolveLocation(requestIfDenied: false, forceRefresh: true),
    );
  }

  Future<void> requestCurrentLocation() async {
    _clearCache();
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => _resolveLocation(requestIfDenied: true, forceRefresh: true),
    );
  }

  void _clearCache() {
    _lastKnownPosition = null;
    _lastFetchTime = null;
    _lastQueryPosition = null;
    _lastQueryTime = null;
  }

  Future<bool> openAppSettings() {
    return _client.openAppSettings();
  }

  Future<bool> openLocationSettings() {
    return _client.openLocationSettings();
  }

  bool _isCacheValid() {
    if (_lastKnownPosition == null || _lastFetchTime == null) {
      return false;
    }
    return _now().difference(_lastFetchTime!) < _cacheDuration;
  }

  /// Checks if a new API query is needed based on distance and time.
  /// Returns the position to use for the query (either cached or new).
  Future<Position> getQueryPosition() async {
    final resolved = await _resolveLocation(requestIfDenied: true);
    if (resolved is! LocationReady) {
      throw Exception('Location not available');
    }

    final current = resolved.position;
    final now = _now();

    // Reuse stabilized query coordinates only when live GPS moved <= 25m within 15m.
    if (_lastQueryPosition != null && _lastQueryTime != null) {
      final timeDiff = now.difference(_lastQueryTime!);
      if (timeDiff < _queryCacheDuration) {
        final distance = Geolocator.distanceBetween(
          _lastQueryPosition!.latitude,
          _lastQueryPosition!.longitude,
          current.latitude,
          current.longitude,
        );
        if (distance <= _queryCacheDistanceMeters) {
          return _lastQueryPosition!;
        }
      }
    }

    _lastQueryPosition = current;
    _lastQueryTime = now;
    return current;
  }

  Future<LocationState> _resolveLocation({
    required bool requestIfDenied,
    bool forceRefresh = false,
  }) async {
    if (!forceRefresh && _isCacheValid()) {
      return LocationReady(_lastKnownPosition!);
    }

    final serviceEnabled = await _client.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return const LocationServiceDisabled();
    }

    var permission = await _client.checkPermission();
    if (permission == LocationPermission.denied && requestIfDenied) {
      permission = await _client.requestPermission();
    }

    final result = switch (permission) {
      LocationPermission.denied => const LocationPermissionDenied(),
      LocationPermission.deniedForever =>
        const LocationPermissionPermanentlyDenied(),
      LocationPermission.unableToDetermine => const LocationPermissionDenied(),
      LocationPermission.whileInUse || LocationPermission.always =>
        LocationReady(await _client.getCurrentPosition()),
    };

    if (result is LocationReady) {
      _lastKnownPosition = result.position;
      _lastFetchTime = _now();
    }

    return result;
  }
}

final currentLocationProvider =
    AsyncNotifierProvider.autoDispose<LocationNotifier, LocationState>(
      LocationNotifier.new,
    );

/// Provides the position to be used for API queries.
/// It respects the 25m distance and 15min time cache rules.
final queryPositionProvider = FutureProvider.autoDispose<Position>((ref) async {
  final locationState = await ref.watch(currentLocationProvider.future);
  if (locationState is LocationReady) {
    return ref.watch(currentLocationProvider.notifier).getQueryPosition();
  }
  throw Exception('Location not available');
});
