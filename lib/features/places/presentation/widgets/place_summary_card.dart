import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile/app/theme/app_spacing.dart';
import 'package:mobile/app/theme/app_typography.dart';
import 'package:mobile/core/utils/place_display_utils.dart';
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
      formatPlaceCategoryLabel(place.category),
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
                  Hero(
                    tag: 'place-image-${place.id}',
                    child: Material(
                      type: MaterialType.transparency,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          AppSpacing.radiusSm,
                        ),
                        child: place.photoUrl != null &&
                                place.photoUrl!.isNotEmpty
                            ? Image.network(
                                place.photoUrl!,
                                headers: kNetworkImageHeaders,
                                width: 44,
                                height: 44,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) =>
                                    _placeholderThumb(theme),
                              )
                            : _placeholderThumb(theme),
                      ),
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

  Widget _placeholderThumb(ThemeData theme) {
    return Container(
      width: 44,
      height: 44,
      color: theme.colorScheme.primaryContainer,
      child: Icon(
        Icons.place_outlined,
        color: theme.colorScheme.onPrimaryContainer,
      ),
    );
  }

  String _formatDistance(double meters) {
    if (meters >= 1000) {
      return 'places.map.distance_kilometers'.tr(
        namedArgs: {'distance': (meters / 1000).toStringAsFixed(1)},
      );
    }

    return 'places.map.distance_meters'.tr(
      namedArgs: {'distance': meters.round().toString()},
    );
  }
}
