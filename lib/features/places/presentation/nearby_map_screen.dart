import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobile/app/router/routes.dart';
import 'package:mobile/app/theme/app_spacing.dart';
import 'package:mobile/core/widgets/app_loading_indicator.dart';
import 'package:mobile/core/widgets/empty_state.dart';
import 'package:mobile/core/widgets/error_view.dart';
import 'package:mobile/features/places/application/location_provider.dart';
import 'package:mobile/features/places/application/nearby_places_provider.dart';
import 'package:mobile/features/places/data/dto/place_response.dart';
import 'package:mobile/features/places/presentation/widgets/place_marker_sheet.dart';

final nearbyMapGoogleMapEnabledProvider = Provider<bool>((ref) => true);

class NearbyMapScreen extends ConsumerStatefulWidget {
  const NearbyMapScreen({super.key});

  @override
  ConsumerState<NearbyMapScreen> createState() => _NearbyMapScreenState();
}

class _NearbyMapScreenState extends ConsumerState<NearbyMapScreen> {
  GoogleMapController? _mapController;
  PlaceResponse? _selectedPlace;

  @override
  Widget build(BuildContext context) {
    final locationAsync = ref.watch(currentLocationProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('places.map.title'.tr()),
        actions: [
          IconButton(
            tooltip: 'places.map.search_action'.tr(),
            onPressed: () => context.push(AppRoutes.placeSearch),
            icon: const Icon(Icons.search),
          ),
          IconButton(
            tooltip: 'places.map.recenter_action'.tr(),
            onPressed: _handleRecenter,
            icon: const Icon(Icons.my_location),
          ),
        ],
      ),
      body: locationAsync.when(
        loading: () => const AppLoadingIndicator(),
        error: (error, stackTrace) => ErrorView(
          message: 'common.error_generic'.tr(),
          retryLabel: 'common.retry'.tr(),
          onRetry: _requestCurrentLocation,
        ),
        data: (locationState) => switch (locationState) {
          LocationReady(:final position) => _NearbyPlacesContent(
            position: position,
            selectedPlace: _selectedPlace,
            onMapCreated: (controller) => _mapController = controller,
            onMarkerSelected: _selectPlace,
            onSheetClose: () => setState(() => _selectedPlace = null),
            onDetailPressed: _openPlaceDetail,
          ),
          LocationServiceDisabled() => EmptyState(
            icon: Icons.location_off_outlined,
            title: 'places.map.location_service_disabled_title'.tr(),
            description: 'places.map.location_service_disabled_description'
                .tr(),
            actionLabel: 'places.map.open_location_settings'.tr(),
            onAction: _openLocationSettings,
          ),
          LocationPermissionDenied() => EmptyState(
            icon: Icons.location_disabled_outlined,
            title: 'places.map.permission_denied_title'.tr(),
            description: 'places.map.permission_denied_description'.tr(),
            actionLabel: 'places.map.request_permission'.tr(),
            onAction: _requestCurrentLocation,
          ),
          LocationPermissionPermanentlyDenied() => EmptyState(
            icon: Icons.location_disabled_outlined,
            title: 'places.map.permission_permanently_denied_title'.tr(),
            description: 'places.map.permission_permanently_denied_description'
                .tr(),
            actionLabel: 'places.map.open_app_settings'.tr(),
            onAction: _openAppSettings,
          ),
        },
      ),
    );
  }

  Future<void> _handleRecenter() async {
    await ref.read(currentLocationProvider.notifier).refreshLocation();
    final locationState = ref.read(currentLocationProvider).valueOrNull;
    if (locationState is LocationReady) {
      _animateToPosition(locationState.position);
    }
  }

  Future<void> _requestCurrentLocation() {
    return ref.read(currentLocationProvider.notifier).requestCurrentLocation();
  }

  Future<void> _openAppSettings() async {
    await ref.read(currentLocationProvider.notifier).openAppSettings();
  }

  Future<void> _openLocationSettings() async {
    await ref.read(currentLocationProvider.notifier).openLocationSettings();
    await _requestCurrentLocation();
  }

  void _selectPlace(PlaceResponse place) {
    setState(() => _selectedPlace = place);

    final latitude = place.latitude;
    final longitude = place.longitude;
    if (_mapController != null && latitude != null && longitude != null) {
      unawaited(
        _mapController!.animateCamera(
          CameraUpdate.newLatLng(LatLng(latitude, longitude)),
        ),
      );
    }
  }

  void _animateToPosition(Position position) {
    final controller = _mapController;
    if (controller == null) {
      return;
    }

    unawaited(
      controller.animateCamera(
        CameraUpdate.newLatLng(LatLng(position.latitude, position.longitude)),
      ),
    );
  }

  void _openPlaceDetail(PlaceResponse place) {
    context.push(AppRoutes.placeDetailPath(place.id));
  }
}

class _NearbyPlacesContent extends ConsumerWidget {
  const _NearbyPlacesContent({
    required this.position,
    required this.selectedPlace,
    required this.onMapCreated,
    required this.onMarkerSelected,
    required this.onSheetClose,
    required this.onDetailPressed,
  });

  final Position position;
  final PlaceResponse? selectedPlace;
  final ValueChanged<GoogleMapController> onMapCreated;
  final ValueChanged<PlaceResponse> onMarkerSelected;
  final VoidCallback onSheetClose;
  final ValueChanged<PlaceResponse> onDetailPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Use queryPositionProvider to apply 25m/15min cache logic
    final queryPosAsync = ref.watch(queryPositionProvider);

    return queryPosAsync.when(
      loading: () => const AppLoadingIndicator(),
      error: (error, stackTrace) => ErrorView(
        message: 'common.error_generic'.tr(),
        retryLabel: 'common.retry'.tr(),
        onRetry: () => ref
            .read(currentLocationProvider.notifier)
            .requestCurrentLocation(),
      ),
      data: (queryPos) {
        // Round coordinates to 5 decimal places to stabilize cache keys
        final lat = double.parse(queryPos.latitude.toStringAsFixed(5));
        final lon = double.parse(queryPos.longitude.toStringAsFixed(5));

        final query = nearbyPlacesQuery(
          latitude: lat,
          longitude: lon,
        );
        final placesAsync = ref.watch(nearbyPlacesProvider(query));

        return placesAsync.when(
          loading: () => const AppLoadingIndicator(),
          error: (error, stackTrace) => ErrorView(
            message: 'common.error_generic'.tr(),
            retryLabel: 'common.retry'.tr(),
            onRetry: () => refreshLocationAndNearbyPlaces(ref, query),
          ),
          data: (places) {
            final mappedPlaces = places
                .where((place) => place.latitude != null && place.longitude != null)
                .toList();

            if (mappedPlaces.isEmpty) {
              return EmptyState(
                icon: Icons.travel_explore_outlined,
                title: 'places.map.empty_title'.tr(),
                description: 'places.map.empty_description'.tr(),
                actionLabel: 'common.retry'.tr(),
                onAction: () => refreshLocationAndNearbyPlaces(ref, query),
              );
            }

            return Stack(
              children: [
                _PlacesMap(
                  position: queryPos,
                  places: mappedPlaces,
                  onMapCreated: onMapCreated,
                  onMarkerSelected: onMarkerSelected,
                  onMapTapped: onSheetClose,
                ),
                Positioned(
                  left: AppSpacing.md,
                  right: AppSpacing.md,
                  top: AppSpacing.md,
                  child: _PlacesCountPill(count: mappedPlaces.length),
                ),
                if (selectedPlace != null)
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: PlaceMarkerSheet(
                      place: selectedPlace!,
                      onClose: onSheetClose,
                      onDetailPressed: () => onDetailPressed(selectedPlace!),
                    ),
                  ),
              ],
            );
          },
        );
      },
    );
  }
}

class _PlacesMap extends ConsumerWidget {
  const _PlacesMap({
    required this.position,
    required this.places,
    required this.onMapCreated,
    required this.onMarkerSelected,
    required this.onMapTapped,
  });

  final Position position;
  final List<PlaceResponse> places;
  final ValueChanged<GoogleMapController> onMapCreated;
  final ValueChanged<PlaceResponse> onMarkerSelected;
  final VoidCallback onMapTapped;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapEnabled = ref.watch(nearbyMapGoogleMapEnabledProvider);
    final currentPosition = LatLng(position.latitude, position.longitude);

    if (!mapEnabled) {
      return const _GoogleMapPlaceholder(key: Key('nearby-map-placeholder'));
    }

    return GoogleMap(
      initialCameraPosition: CameraPosition(target: currentPosition, zoom: 13),
      markers: _markers(context),
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      mapToolbarEnabled: false,
      onMapCreated: onMapCreated,
      onTap: (_) => onMapTapped(),
    );
  }

  Set<Marker> _markers(BuildContext context) {
    return places.map((place) {
      return Marker(
        markerId: MarkerId(place.id),
        position: LatLng(place.latitude!, place.longitude!),
        infoWindow: InfoWindow(title: _displayName(context, place)),
        onTap: () => onMarkerSelected(place),
      );
    }).toSet();
  }

  String _displayName(BuildContext context, PlaceResponse place) {
    final languageCode = context.locale.languageCode;
    final localizedName = switch (languageCode) {
      'tr' => place.nameTr ?? place.name ?? place.nameEn,
      'en' || 'de' => place.nameEn ?? place.name ?? place.nameTr,
      _ => place.name ?? place.nameEn ?? place.nameTr,
    };

    final trimmedName = localizedName?.trim();
    if (trimmedName == null || trimmedName.isEmpty) {
      return 'places.map.unknown_place'.tr();
    }

    return trimmedName;
  }
}

class _GoogleMapPlaceholder extends StatelessWidget {
  const _GoogleMapPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: Center(
        child: Icon(
          Icons.map_outlined,
          size: 72,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}

class _PlacesCountPill extends StatelessWidget {
  const _PlacesCountPill({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Align(
      alignment: Alignment.topCenter,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusCircle),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.shadow.withValues(alpha: 0.12),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          child: Text('places.map.places_count'.tr(namedArgs: {'count': count.toString()})),
        ),
      ),
    );
  }
}
