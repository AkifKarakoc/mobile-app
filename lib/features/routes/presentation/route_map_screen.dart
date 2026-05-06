import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile/app/router/routes.dart';
import 'package:mobile/core/widgets/app_loading_indicator.dart';
import 'package:mobile/core/widgets/error_view.dart';
import 'package:mobile/features/routes/application/routes_provider.dart';

class RouteMapScreen extends ConsumerWidget {
  final String routeId;

  const RouteMapScreen({super.key, required this.routeId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routeState = ref.watch(routeDetailProvider(routeId));

    return Scaffold(
      appBar: AppBar(
        title: Text('routes.map_title'.tr()),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: routeState.when(
        data: (route) {
          final placesWithCoords = route.places.where(
            (p) => p.latitude != null && p.longitude != null,
          ).toList();

          final targetLat = placesWithCoords.isNotEmpty
              ? placesWithCoords.first.latitude!
              : route.centerLatitude;
          final targetLng = placesWithCoords.isNotEmpty
              ? placesWithCoords.first.longitude!
              : route.centerLongitude;

          final markers = <Marker>{};

          for (final place in placesWithCoords) {
            final latLng = LatLng(place.latitude!, place.longitude!);

            markers.add(
              Marker(
                markerId: MarkerId(place.placeId),
                position: latLng,
                infoWindow: InfoWindow(
                  title: place.placeName ?? '${'routes.stop_order'.tr()} ${place.stopOrder}',
                  snippet: place.notes,
                ),
                onTap: () => context.push(AppRoutes.placeDetailPath(place.placeId)),
              ),
            );
          }

          return GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(targetLat, targetLng),
              zoom: 13,
            ),
            markers: markers,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            zoomControlsEnabled: false,
            mapToolbarEnabled: false,
          );
        },
        loading: () => const AppLoadingIndicator(),
        error: (error, stack) => ErrorView(
          message: error.toString(),
          onRetry: () => ref.invalidate(routeDetailProvider(routeId)),
          retryLabel: 'common.retry'.tr(),
        ),
      ),
    );
  }
}
