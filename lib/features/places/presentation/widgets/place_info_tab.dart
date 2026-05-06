import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile/app/theme/app_spacing.dart';
import 'package:mobile/app/theme/app_typography.dart';
import 'package:mobile/features/places/data/dto/place_detail_response.dart';

class PlaceInfoTab extends StatelessWidget {
  const PlaceInfoTab({super.key, required this.place});

  final PlaceDetailResponse place;

  @override
  Widget build(BuildContext context) {
    final description = place.description?.trim();
    final keywords = place.keywords?.where((item) => item.trim().isNotEmpty);

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        if (description != null && description.isNotEmpty) ...[
          Text(description, style: AppTypography.bodyLarge),
          const SizedBox(height: AppSpacing.lg),
        ],
        _DetailTile(
          icon: Icons.category_outlined,
          label: 'place_detail.category'.tr(),
          value: _textOrFallback(place.category),
        ),
        _DetailTile(
          icon: Icons.location_on_outlined,
          label: 'place_detail.address'.tr(),
          value: _textOrFallback(place.address),
        ),
        _DetailTile(
          icon: Icons.schedule_outlined,
          label: 'place_detail.opening_hours'.tr(),
          value: _textOrFallback(place.openingHours),
        ),
        _DetailTile(
          icon: Icons.phone_outlined,
          label: 'place_detail.phone'.tr(),
          value: _textOrFallback(place.phone),
        ),
        _DetailTile(
          icon: Icons.language_outlined,
          label: 'place_detail.website'.tr(),
          value: _textOrFallback(place.website),
        ),
        _DetailTile(
          icon: Icons.star_rounded,
          label: 'place_detail.rating'.tr(),
          value: place.avgRating == null
              ? 'common.not_available'.tr()
              : 'place_detail.rating_value'.tr(
                  namedArgs: {
                    'rating': place.avgRating!.toStringAsFixed(1),
                    'count': (place.reviewCount ?? 0).toString(),
                  },
                ),
        ),
        _DetailTile(
          icon: Icons.trending_up_outlined,
          label: 'place_detail.popularity'.tr(),
          value: place.popularityScore == null
              ? 'common.not_available'.tr()
              : 'place_detail.popularity_value'.tr(
                  namedArgs: {'score': place.popularityScore.toString()},
                ),
        ),
        if (keywords != null && keywords.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.lg),
          Text('place_detail.keywords'.tr(), style: AppTypography.titleMedium),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              for (final keyword in keywords)
                Chip(
                  label: Text(keyword),
                  visualDensity: VisualDensity.compact,
                ),
            ],
          ),
        ],
      ],
    );
  }

  String _textOrFallback(String? value) {
    final trimmed = value?.trim();
    if (trimmed == null || trimmed.isEmpty) {
      return 'common.not_available'.tr();
    }
    return trimmed;
  }
}

class _DetailTile extends StatelessWidget {
  const _DetailTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: colorScheme.primary),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTypography.labelMedium.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(value, style: AppTypography.bodyMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
