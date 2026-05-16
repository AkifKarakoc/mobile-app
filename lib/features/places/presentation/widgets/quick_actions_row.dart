import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile/app/theme/app_spacing.dart';
import 'package:mobile/app/theme/app_typography.dart';
import 'package:mobile/core/widgets/tap_feedback.dart';
import 'package:mobile/features/places/data/dto/place_detail_response.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class QuickActionsRow extends StatelessWidget {
  const QuickActionsRow({
    super.key,
    required this.place,
    required this.onDirectionsPressed,
  });

  final PlaceDetailResponse place;
  final VoidCallback onDirectionsPressed;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Row(
        children: [
          _QuickActionItem(
            icon: Icons.directions_outlined,
            label: 'place_detail.directions'.tr(),
            onTap: onDirectionsPressed,
          ),
          const SizedBox(width: AppSpacing.sm),
          _QuickActionItem(
            icon: Icons.share_outlined,
            label: 'place_detail.share'.tr(),
            onTap: () => _sharePlace(context),
          ),
          if (place.website != null && place.website!.trim().isNotEmpty) ...[
            const SizedBox(width: AppSpacing.sm),
            _QuickActionItem(
              icon: Icons.language_outlined,
              label: 'place_detail.website'.tr(),
              onTap: () => _launchUrl(place.website!),
            ),
          ],
          if (place.phone != null && place.phone!.trim().isNotEmpty) ...[
            const SizedBox(width: AppSpacing.sm),
            _QuickActionItem(
              icon: Icons.phone_outlined,
              label: 'place_detail.phone'.tr(),
              onTap: () => _launchUrl('tel:${place.phone}'),
            ),
          ],
        ],
      ),
    );
  }

  void _sharePlace(BuildContext context) {
    final title = place.nameTr ?? place.nameEn ?? place.name ?? '';
    Share.share(title, subject: title);
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}

class _QuickActionItem extends StatelessWidget {
  const _QuickActionItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return TapFeedback(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          border: Border.all(color: colorScheme.outlineVariant.withValues(alpha: 0.3)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: colorScheme.primary),
            const SizedBox(height: AppSpacing.xs),
            Text(
              label,
              style: AppTypography.labelSmall.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
