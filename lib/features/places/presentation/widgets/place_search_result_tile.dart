import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile/app/theme/app_spacing.dart';
import 'package:mobile/app/theme/app_typography.dart';
import 'package:mobile/features/places/data/dto/place_response.dart';

class PlaceSearchResultTile extends StatelessWidget {
  const PlaceSearchResultTile({
    required this.place,
    required this.onTap,
    super.key,
  });

  final PlaceResponse place;
  final VoidCallback onTap;

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
    final category = _categoryLabel(place.category);

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      leading: CircleAvatar(
        backgroundColor: colorScheme.primaryContainer,
        foregroundColor: colorScheme.onPrimaryContainer,
        child: const Icon(Icons.place_outlined),
      ),
      title: Text(
        _placeName(context),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: AppTypography.titleMedium,
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: AppSpacing.xs),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              category,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.bodySmall.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
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
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
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
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: AppSpacing.iconSmall,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(width: AppSpacing.xs),
        Text(label, style: AppTypography.labelSmall),
      ],
    );
  }
}
