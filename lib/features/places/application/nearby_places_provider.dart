import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/features/places/application/location_provider.dart';
import 'package:mobile/features/places/data/dto/place_response.dart';
import 'package:mobile/features/places/data/places_repository.dart';

const nearbyPlacesDefaultRadiusMeters = 15000;
const nearbyPlacesDefaultLimit = 50;

typedef NearbyPlacesQuery = ({
  double latitude,
  double longitude,
  int radius,
  int limit,
  String? category,
});

NearbyPlacesQuery nearbyPlacesQuery({
  required double latitude,
  required double longitude,
  int radius = nearbyPlacesDefaultRadiusMeters,
  int limit = nearbyPlacesDefaultLimit,
  String? category,
}) {
  return (
    latitude: latitude,
    longitude: longitude,
    radius: radius,
    limit: limit,
    category: category,
  );
}

class NearbyPlacesNotifier
    extends
        AutoDisposeFamilyAsyncNotifier<List<PlaceResponse>, NearbyPlacesQuery> {
  PlacesRepository? _repository;
  NearbyPlacesQuery? _query;

  @override
  FutureOr<List<PlaceResponse>> build(NearbyPlacesQuery arg) {
    _repository ??= ref.watch(placesRepositoryProvider);
    _query = arg;
    ref.keepAlive();
    return _loadPlaces(arg);
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _loadPlaces(_query!));
  }

  Future<List<PlaceResponse>> _loadPlaces(NearbyPlacesQuery query) {
    return _repository!.getNearby(
      latitude: query.latitude,
      longitude: query.longitude,
      radius: query.radius,
      limit: query.limit,
      category: query.category,
    );
  }
}

final nearbyPlacesProvider = AsyncNotifierProvider.autoDispose
    .family<NearbyPlacesNotifier, List<PlaceResponse>, NearbyPlacesQuery>(
      NearbyPlacesNotifier.new,
    );

/// Refreshes live GPS coordinates and invalidates the active query position.
Future<void> refreshCurrentLocationForQuery(WidgetRef ref) async {
  await ref.read(currentLocationProvider.notifier).refreshLocation();
  if (!ref.context.mounted) return;
  ref.invalidate(queryPositionProvider);
}

/// Refreshes live GPS coordinates and reloads nearby places for [query].
Future<void> refreshLocationAndNearbyPlaces(
  WidgetRef ref,
  NearbyPlacesQuery query,
) async {
  await refreshCurrentLocationForQuery(ref);
  if (!ref.context.mounted) return;
  ref.invalidate(nearbyPlacesProvider(query));
}
