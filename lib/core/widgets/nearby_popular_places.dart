import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/app/router/routes.dart';
import 'package:mobile/app/theme/app_spacing.dart';
import 'package:mobile/app/theme/app_typography.dart';
import 'package:mobile/features/places/application/location_provider.dart';
import 'package:mobile/features/places/application/nearby_places_provider.dart';
import 'package:mobile/features/places/data/dto/place_response.dart';
import 'package:mobile/core/utils/place_display_utils.dart';
import 'package:mobile/core/widgets/shimmer_placeholder.dart';

/// Horizontal scroll of nearby popular places.
///
/// Shows top-rated places near the user's current location.
/// Tapping a place navigates to its detail screen.
class NearbyPopularPlaces extends ConsumerWidget {
  const NearbyPopularPlaces({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationState = ref.watch(currentLocationProvider);

    return locationState.when(
      data: (locationState) {
        if (locationState is! LocationReady) {
          return const SizedBox.shrink();
        }

        final query = nearbyPlacesQuery(
          latitude: locationState.position.latitude,
          longitude: locationState.position.longitude,
          limit: 10,
        );

        final placesAsync = ref.watch(nearbyPlacesProvider(query));

        return placesAsync.when(
          data: (places) {
            if (places.isEmpty) return const SizedBox.shrink();

            final topPlaces = places.where((p) => p.avgRating != null).toList()
              ..sort((a, b) => (b.avgRating ?? 0).compareTo(a.avgRating ?? 0));

            final displayPlaces = topPlaces.take(5).toList();

            if (displayPlaces.isEmpty) return const SizedBox.shrink();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.sm,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'home.popular_nearby'.tr(),
                        style: AppTypography.titleLarge,
                      ),
                      TextButton(
                        onPressed: () => context.push(AppRoutes.nearby),
                        child: Text(
                          'common.see_all'.tr(),
                          style: AppTypography.labelMedium.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 160,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                    ),
                    itemCount: displayPlaces.length,
                    separatorBuilder: (_, __) =>
                        const SizedBox(width: AppSpacing.sm),
                    itemBuilder: (context, index) {
                      return _PlaceCard(
                        place: displayPlaces[index],
                        index: index,
                      );
                    },
                  ),
                ),
              ],
            );
          },
          loading: () => const _LoadingPlaces(),
          error: (_, __) => const SizedBox.shrink(),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }
}

class _PlaceCard extends StatelessWidget {
  final PlaceResponse place;
  final int index;

  const _PlaceCard({required this.place, required this.index});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final placeName = place.name ?? place.nameTr ?? place.nameEn ?? '';

    return GestureDetector(
      onTap: () => context.push(AppRoutes.placeDetailPath(place.id)),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200 + (index * 100)),
        curve: Curves.easeOut,
        width: 130,
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(AppSpacing.radiusMd),
              ),
              child: Hero(
                tag: 'place-image-${place.id}',
                child: Material(
                  type: MaterialType.transparency,
                  child: AspectRatio(
                    aspectRatio: 16 / 10,
                    child: place.photoUrl != null
                        ? Image.network(
                            place.photoUrl!,
                            headers: kNetworkImageHeaders,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) =>
                                _PlaceholderImage(theme),
                          )
                        : _PlaceholderImage(theme),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    placeName,
                    style: AppTypography.labelMedium.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  if (place.avgRating != null)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.star,
                          size: 12,
                          color: theme.colorScheme.secondary,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          place.avgRating!.toStringAsFixed(1),
                          style: AppTypography.labelSmall,
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PlaceholderImage extends StatelessWidget {
  final ThemeData theme;

  const _PlaceholderImage(this.theme);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: theme.colorScheme.surfaceContainer,
      child: Icon(
        Icons.image_outlined,
        color: theme.colorScheme.onSurfaceVariant,
        size: 24,
      ),
    );
  }
}

class _LoadingPlaces extends StatelessWidget {
  const _LoadingPlaces();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        itemCount: 4,
        separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.sm),
        itemBuilder: (_, index) => ShimmerPlaceholder(
          height: 160,
          width: 130,
          shape: ShimmerShape.card,
          delay: Duration(milliseconds: index * 100),
        ),
      ),
    );
  }
}
