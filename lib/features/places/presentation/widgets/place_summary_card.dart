import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile/app/theme/app_spacing.dart';
import 'package:mobile/app/theme/app_typography.dart';
import 'package:mobile/core/widgets/app_button.dart';
import 'package:mobile/features/places/data/dto/place_response.dart';

class PlaceSummaryCard extends StatelessWidget {
  const PlaceSummaryCard({
    super.key,
    required this.place,
    this.onTap,
    this.onDetailPressed,
  });

  final PlaceResponse place;
  final VoidCallback? onTap;
  final VoidCallback? onDetailPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final subtitleItems = [
      _categoryLabel(place.category),
      if (place.avgRating != null)
        'places.map.rating_label'.tr(
          args: [place.avgRating!.toStringAsFixed(1)],
        ),
      if (place.distance != null) _formatDistance(place.distance!),
    ];

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                    ),
                    child: Icon(
                      Icons.place_outlined,
                      color: theme.colorScheme.onPrimaryContainer,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _displayName(context, place),
                          style: AppTypography.titleMedium,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          subtitleItems.join('  •  '),
                          style: AppTypography.bodySmall.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (onDetailPressed != null) ...[
                const SizedBox(height: AppSpacing.sm),
                Align(
                  alignment: Alignment.centerRight,
                  child: AppButton.text(
                    label: 'places.map.detail_action'.tr(),
                    icon: Icons.chevron_right,
                    onPressed: onDetailPressed,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
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

  String _categoryLabel(String? category) {
    final normalized = category?.trim().toLowerCase();
    final key = switch (normalized) {
      'landmark' => 'places.categories.landmark',
      'museum' => 'places.categories.museum',
      'restaurant' => 'places.categories.restaurant',
      'cafe' => 'places.categories.cafe',
      'park' => 'places.categories.park',
      'beach' => 'places.categories.beach',
      'historical' || 'historic' => 'places.categories.historical',
      'nature' => 'places.categories.nature',
      'shopping' => 'places.categories.shopping',
      'religious' => 'places.categories.religious',
      _ => 'places.categories.other',
    };

    return key.tr();
  }

  String _formatDistance(double meters) {
    if (meters >= 1000) {
      return 'places.map.distance_kilometers'.tr(
        args: [(meters / 1000).toStringAsFixed(1)],
      );
    }

    return 'places.map.distance_meters'.tr(args: [meters.round().toString()]);
  }
}
