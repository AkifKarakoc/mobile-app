import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile/app/theme/app_spacing.dart';
import 'package:mobile/app/theme/app_typography.dart';
import 'package:mobile/core/widgets/tap_feedback.dart';
import 'package:mobile/features/places/data/dto/place_detail_response.dart';
import 'package:mobile/features/places/presentation/widgets/rating_breakdown.dart';
import 'package:url_launcher/url_launcher.dart';

class PlaceInfoTab extends StatelessWidget {
  const PlaceInfoTab({super.key, required this.place});

  final PlaceDetailResponse place;

  @override
  Widget build(BuildContext context) {
    final description = place.description?.trim();
    final keywords = place.keywords?.where((item) => item.trim().isNotEmpty);
    final distribution = place.ratingDistribution;

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        if (description != null && description.isNotEmpty) ...[
          _SectionCard(
            icon: Icons.info_outline,
            title: 'place_detail.description'.tr(),
            child: Text(description, style: AppTypography.bodyMedium),
          ),
          const SizedBox(height: AppSpacing.md),
        ],
        if (distribution != null && distribution.isNotEmpty) ...[
          RatingBreakdown(
            avgRating: place.avgRating ?? 0,
            reviewCount: place.reviewCount ?? 0,
            distribution: distribution,
          ),
          const SizedBox(height: AppSpacing.md),
        ],
        _InfoGrid(place: place),
        if (keywords != null && keywords.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.md),
          Text(
            'place_detail.keywords'.tr(),
            style: AppTypography.titleMedium,
          ),
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
}

class _InfoGrid extends StatelessWidget {
  const _InfoGrid({required this.place});

  final PlaceDetailResponse place;

  @override
  Widget build(BuildContext context) {
    final tiles = <_InfoItem>[];

    if (place.category != null && place.category!.trim().isNotEmpty) {
      tiles.add(_InfoItem(
        icon: Icons.category_outlined,
        label: 'place_detail.category'.tr(),
        value: place.category!,
      ));
    }
    if (place.address != null && place.address!.trim().isNotEmpty) {
      tiles.add(_InfoItem(
        icon: Icons.location_on_outlined,
        label: 'place_detail.address'.tr(),
        value: place.address!,
      ));
    }
    if (place.openingHours != null && place.openingHours!.trim().isNotEmpty) {
      tiles.add(_InfoItem(
        icon: Icons.schedule_outlined,
        label: 'place_detail.opening_hours'.tr(),
        value: place.openingHours!,
      ));
    }
    if (place.phone != null && place.phone!.trim().isNotEmpty) {
      tiles.add(_InfoItem(
        icon: Icons.phone_outlined,
        label: 'place_detail.phone'.tr(),
        value: place.phone!,
        onTap: () => _launchUrl('tel:${place.phone}'),
      ));
    }
    if (place.website != null && place.website!.trim().isNotEmpty) {
      tiles.add(_InfoItem(
        icon: Icons.language_outlined,
        label: 'place_detail.website'.tr(),
        value: place.website!,
        onTap: () => _launchUrl(place.website!),
      ));
    }

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: AppSpacing.sm,
      crossAxisSpacing: AppSpacing.sm,
      childAspectRatio: 2.2,
      children: [
        for (final tile in tiles) _InfoTile(item: tile),
      ],
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}

class _InfoItem {
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback? onTap;

  const _InfoItem({
    required this.icon,
    required this.label,
    required this.value,
    this.onTap,
  });
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({required this.item});

  final _InfoItem item;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final child = Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(item.icon, size: 18, color: colorScheme.primary),
              const SizedBox(width: AppSpacing.xs),
              Expanded(
                child: Text(
                  item.label,
                  style: AppTypography.labelSmall.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            item.value,
            style: AppTypography.bodySmall.copyWith(
              color: colorScheme.onSurface,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );

    if (item.onTap != null) {
      return TapFeedback(onTap: item.onTap!, child: child);
    }
    return child;
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.icon,
    required this.title,
    required this.child,
  });

  final IconData icon;
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: colorScheme.primary),
              const SizedBox(width: AppSpacing.sm),
              Text(title, style: AppTypography.titleSmall),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          child,
        ],
      ),
    );
  }
}
