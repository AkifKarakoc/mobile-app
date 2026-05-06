import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile/app/theme/app_spacing.dart';
import 'package:mobile/app/theme/app_typography.dart';
import 'package:mobile/features/places/data/dto/place_response.dart';
import 'package:mobile/features/places/presentation/widgets/place_summary_card.dart';

class PlaceMarkerSheet extends StatelessWidget {
  const PlaceMarkerSheet({
    super.key,
    required this.place,
    required this.onClose,
    required this.onDetailPressed,
  });

  final PlaceResponse place;
  final VoidCallback onClose;
  final VoidCallback onDetailPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      top: false,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.md,
          AppSpacing.sm,
          AppSpacing.md,
          AppSpacing.md,
        ),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(AppSpacing.radiusLg),
          ),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.shadow.withValues(alpha: 0.16),
              blurRadius: 16,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: theme.colorScheme.outlineVariant,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusCircle),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'places.map.selected_place_title'.tr(),
                    style: AppTypography.titleSmall.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
                IconButton(
                  tooltip: 'common.cancel'.tr(),
                  onPressed: onClose,
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            PlaceSummaryCard(place: place, onDetailPressed: onDetailPressed),
          ],
        ),
      ),
    );
  }
}
