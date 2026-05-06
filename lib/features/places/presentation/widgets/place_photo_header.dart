import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile/app/theme/app_spacing.dart';
import 'package:mobile/app/theme/app_typography.dart';
import 'package:mobile/features/places/data/dto/place_detail_response.dart';
import 'package:mobile/features/places/presentation/widgets/favorite_toggle_button.dart';

class PlacePhotoHeader extends StatelessWidget {
  const PlacePhotoHeader({
    super.key,
    required this.place,
    required this.title,
    required this.onDirectionsPressed,
  });

  final PlaceDetailResponse place;
  final String title;
  final VoidCallback onDirectionsPressed;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final photoUrl = place.photoUrl;

    return SliverToBoxAdapter(
      child: Stack(
        children: [
          AspectRatio(
            aspectRatio: 16 / 10,
            child: photoUrl == null || photoUrl.isEmpty
                ? DecoratedBox(
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerHighest,
                    ),
                    child: Icon(
                      Icons.photo_camera_outlined,
                      size: 64,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  )
                : Image.network(
                    photoUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, _, _) => DecoratedBox(
                      decoration: BoxDecoration(
                        color: colorScheme.surfaceContainerHighest,
                      ),
                      child: Icon(
                        Icons.broken_image_outlined,
                        size: 64,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
          ),
          PositionedDirectional(
            start: AppSpacing.md,
            end: AppSpacing.md,
            bottom: AppSpacing.md,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: colorScheme.surface.withValues(alpha: 0.92),
                borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
              ),
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: AppTypography.headlineSmall.copyWith(
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Wrap(
                      spacing: AppSpacing.sm,
                      runSpacing: AppSpacing.sm,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        if (place.category != null &&
                            place.category!.trim().isNotEmpty)
                          _InfoPill(
                            icon: Icons.category_outlined,
                            label: place.category!,
                          ),
                        if (place.avgRating != null)
                          _InfoPill(
                            icon: Icons.star_rounded,
                            label: place.avgRating!.toStringAsFixed(1),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          PositionedDirectional(
            top: AppSpacing.md,
            end: AppSpacing.md,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: colorScheme.surface.withValues(alpha: 0.92),
                shape: BoxShape.circle,
              ),
              child: FavoriteToggleButton(placeId: place.id),
            ),
          ),
          PositionedDirectional(
            top: AppSpacing.md,
            start: AppSpacing.md,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: colorScheme.surface.withValues(alpha: 0.92),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                tooltip: 'place_detail.directions'.tr(),
                onPressed: onDirectionsPressed,
                icon: const Icon(Icons.directions_outlined),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoPill extends StatelessWidget {
  const _InfoPill({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: AppSpacing.iconSmall),
            const SizedBox(width: AppSpacing.xs),
            Text(label, style: AppTypography.labelMedium),
          ],
        ),
      ),
    );
  }
}
