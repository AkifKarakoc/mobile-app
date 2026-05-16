import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile/app/theme/app_spacing.dart';
import 'package:mobile/app/theme/app_typography.dart';
import 'package:mobile/features/places/data/dto/place_response.dart';

class PlaceSearchResultTile extends StatelessWidget {
  const PlaceSearchResultTile({
    required this.place,
    required this.onTap,
    required this.heroTag,
    super.key,
  });

  final PlaceResponse place;
  final VoidCallback onTap;
  final String heroTag;

  static const _categoryKeys = <String, String>{
    'LANDMARK': 'places.categories.landmark',
    'MUSEUM': 'places.categories.museum',
    'RESTAURANT': 'places.categories.restaurant',
    'CAFE': 'places.categories.cafe',
    'PARK': 'places.categories.park',
    'BEACH': 'places.categories.beach',
    'HISTORICAL': 'places.categories.historical',
    'NATURE': 'places.categories.nature',
    'SHOPPING': 'places.categories.shopping',
    'RELIGIOUS': 'places.categories.religious',
    'ENTERTAINMENT': 'places.categories.entertainment',
    'OTHER': 'places.categories.other',
  };

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          border: Border.all(
            color: colorScheme.outlineVariant.withValues(alpha: 0.5),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: heroTag,
              child: Material(
                type: MaterialType.transparency,
                child: ClipRRect(
                  borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(AppSpacing.radiusLg),
                  ),
                  child: _buildImage(context),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _placeName(context),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.titleSmall,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    _buildCategoryChip(context),
                    const SizedBox(height: AppSpacing.sm),
                    Wrap(
                      spacing: AppSpacing.md,
                      runSpacing: AppSpacing.xs,
                      children: [
                        _Metric(
                          icon: Icons.star_rounded,
                          label: _ratingLabel(place.avgRating),
                        ),
                        if (place.distance != null)
                          _Metric(
                            icon: Icons.near_me_outlined,
                            label: _distanceLabel(place.distance!),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: AppSpacing.sm,
                top: AppSpacing.md,
              ),
              child: Icon(
                Icons.chevron_right,
                color: colorScheme.outlineVariant,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    if (place.photoUrl == null || place.photoUrl!.isEmpty) {
      return Container(
        width: 80,
        height: 80,
        color: colorScheme.primaryContainer.withValues(alpha: 0.3),
        child: Icon(
          Icons.place_outlined,
          color: colorScheme.primary,
          size: 28,
        ),
      );
    }

    return Image.network(
      place.photoUrl!,
      width: 80,
      height: 80,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => Container(
        width: 80,
        height: 80,
        color: colorScheme.primaryContainer.withValues(alpha: 0.3),
        child: Icon(
          Icons.place_outlined,
          color: colorScheme.primary,
          size: 28,
        ),
      ),
    );
  }

  Widget _buildCategoryChip(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: colorScheme.secondary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
      ),
      child: Text(
        _categoryLabel(place.category),
        style: AppTypography.labelSmall.copyWith(
          color: colorScheme.secondary,
        ),
      ),
    );
  }

  String _placeName(BuildContext context) {
    final languageCode = context.locale.languageCode;
    final localizedName = switch (languageCode) {
      'tr' => place.nameTr,
      'en' => place.nameEn,
      _ => place.nameEn ?? place.nameTr,
    };

    return localizedName ?? place.name ?? 'places.search.unknown_place'.tr();
  }

  String _categoryLabel(String? category) {
    if (category == null || category.trim().isEmpty) {
      return 'places.search.unknown_category'.tr();
    }

    final key = _categoryKeys[category.trim().toUpperCase()];
    if (key == null) {
      return category;
    }

    return key.tr();
  }

  String _ratingLabel(double? rating) {
    if (rating == null) {
      return 'places.search.no_rating'.tr();
    }

    return 'places.search.rating_label'.tr(
      namedArgs: {'rating': rating.toStringAsFixed(1)},
    );
  }

  String _distanceLabel(double distance) {
    if (distance < 1000) {
      return 'places.search.distance_m'.tr(
        namedArgs: {'distance': distance.round().toString()},
      );
    }

    return 'places.search.distance_km'.tr(
      namedArgs: {'distance': (distance / 1000).toStringAsFixed(1)},
    );
  }
}

class _Metric extends StatelessWidget {
  const _Metric({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: AppSpacing.iconSmall,
          color: colorScheme.primary,
        ),
        const SizedBox(width: AppSpacing.xs),
        Text(label, style: AppTypography.labelSmall),
      ],
    );
  }
}
