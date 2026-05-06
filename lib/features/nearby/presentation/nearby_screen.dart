import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/app/router/routes.dart';
import 'package:mobile/app/theme/app_spacing.dart';
import 'package:mobile/app/theme/app_typography.dart';
import 'package:mobile/core/widgets/app_loading_indicator.dart';
import 'package:mobile/core/widgets/empty_state.dart';
import 'package:mobile/core/widgets/error_view.dart';
import 'package:mobile/features/places/application/location_provider.dart';
import 'package:mobile/features/places/application/nearby_places_provider.dart';
import 'package:mobile/features/places/presentation/widgets/place_search_result_tile.dart';

final selectedCategoryProvider = StateProvider<String?>((ref) => null);

class NearbyScreen extends ConsumerWidget {
  const NearbyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationAsync = ref.watch(currentLocationProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('nearby.title'.tr()),
        actions: [
          IconButton(
            tooltip: 'places.map.search_action'.tr(),
            onPressed: () => context.push(AppRoutes.placeSearch),
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: locationAsync.when(
        loading: () => const AppLoadingIndicator(),
        error: (error, stackTrace) => ErrorView(
          message: 'common.error_generic'.tr(),
          retryLabel: 'common.retry'.tr(),
          onRetry: () =>
              ref.read(currentLocationProvider.notifier).requestCurrentLocation(),
        ),
        data: (locationState) => switch (locationState) {
          LocationReady(:final position) => _NearbyBody(position: position),
          LocationServiceDisabled() => EmptyState(
            icon: Icons.location_off_outlined,
            title: 'places.map.location_service_disabled_title'.tr(),
            description:
                'places.map.location_service_disabled_description'.tr(),
            actionLabel: 'places.map.open_location_settings'.tr(),
            onAction: () =>
                ref.read(currentLocationProvider.notifier).openLocationSettings(),
          ),
          LocationPermissionDenied() => EmptyState(
            icon: Icons.location_disabled_outlined,
            title: 'places.map.permission_denied_title'.tr(),
            description: 'places.map.permission_denied_description'.tr(),
            actionLabel: 'places.map.request_permission'.tr(),
            onAction: () =>
                ref.read(currentLocationProvider.notifier).requestCurrentLocation(),
          ),
          LocationPermissionPermanentlyDenied() => EmptyState(
            icon: Icons.location_disabled_outlined,
            title: 'places.map.permission_permanently_denied_title'.tr(),
            description:
                'places.map.permission_permanently_denied_description'.tr(),
            actionLabel: 'places.map.open_app_settings'.tr(),
            onAction: () =>
                ref.read(currentLocationProvider.notifier).openAppSettings(),
          ),
        },
      ),
    );
  }
}

class _NearbyBody extends ConsumerWidget {
  const _NearbyBody({required this.position});

  final Position position;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = ref.watch(selectedCategoryProvider);

    final query = nearbyPlacesQuery(
      latitude: position.latitude,
      longitude: position.longitude,
      category: selectedCategory,
    );
    final placesAsync = ref.watch(nearbyPlacesProvider(query));

    return Column(
      children: [
        _CategoryFilterBar(selectedCategory: selectedCategory),
        _ViewMapButton(),
        const SizedBox(height: AppSpacing.sm),
        Expanded(
          child: placesAsync.when(
            loading: () => const AppLoadingIndicator(),
            error: (error, stackTrace) => ErrorView(
              message: 'common.error_generic'.tr(),
              retryLabel: 'common.retry'.tr(),
              onRetry: () =>
                  ref.read(nearbyPlacesProvider(query).notifier).refresh(),
            ),
            data: (places) {
              if (places.isEmpty) {
                return EmptyState(
                  icon: Icons.travel_explore_outlined,
                  title: 'nearby.no_places'.tr(),
                  description: 'places.map.empty_description'.tr(),
                  actionLabel: 'common.retry'.tr(),
                  onAction: () =>
                      ref.read(nearbyPlacesProvider(query).notifier).refresh(),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                ),
                itemCount: places.length,
                itemBuilder: (context, index) {
                  final place = places[index];
                  return PlaceSearchResultTile(
                    place: place,
                    onTap: () =>
                        context.push(AppRoutes.placeDetailPath(place.id)),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class _CategoryFilterBar extends ConsumerWidget {
  const _CategoryFilterBar({required this.selectedCategory});

  final String? selectedCategory;

  static const _categories = [
    (value: null, trKey: 'nearby.all', icon: Icons.apps),
    (value: 'museum', trKey: 'nearby.museum', icon: Icons.museum),
    (value: 'restaurant', trKey: 'nearby.restaurant', icon: Icons.restaurant),
    (value: 'religious', trKey: 'nearby.mosque', icon: Icons.mosque),
    (value: 'park', trKey: 'nearby.park', icon: Icons.park),
    (value: 'landmark', trKey: 'nearby.monument', icon: Icons.location_city),
    (value: 'beach', trKey: 'nearby.beach', icon: Icons.beach_access),
    (value: 'cafe', trKey: 'nearby.cafe', icon: Icons.local_cafe),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 48,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        itemCount: _categories.length,
        separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.sm),
        itemBuilder: (context, index) {
          final cat = _categories[index];
          final isSelected = selectedCategory == cat.value;

          return FilterChip(
            selected: isSelected,
            label: Text(cat.trKey.tr()),
            avatar: Icon(cat.icon, size: AppSpacing.iconSmall),
            onSelected: (_) {
              ref.read(selectedCategoryProvider.notifier).state = cat.value;
            },
          );
        },
      ),
    );
  }
}

class _ViewMapButton extends StatelessWidget {
  const _ViewMapButton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: OutlinedButton.icon(
        onPressed: () => context.push(AppRoutes.nearbyMap),
        icon: const Icon(Icons.map_outlined, size: AppSpacing.iconSmall),
        label: Text('nearby.view_map'.tr(), style: AppTypography.labelLarge),
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(double.infinity, 44),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          ),
        ),
      ),
    );
  }
}
