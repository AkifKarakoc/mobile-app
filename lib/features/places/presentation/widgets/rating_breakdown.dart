import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mobile/app/theme/app_spacing.dart';
import 'package:mobile/app/theme/app_typography.dart';

class RatingBreakdown extends StatelessWidget {
  const RatingBreakdown({
    super.key,
    required this.avgRating,
    required this.reviewCount,
    required this.distribution,
  });

  final double avgRating;
  final int reviewCount;
  final Map<int, int> distribution;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final maxCount = distribution.values.isEmpty
        ? 1
        : distribution.values.reduce((a, b) => a > b ? a : b);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Text(
                  avgRating.toStringAsFixed(1),
                  style: AppTypography.displayMedium.copyWith(
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                RatingBarIndicator(
                  rating: avgRating,
                  itemBuilder: (_, __) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  itemCount: 5,
                  itemSize: 20,
                  unratedColor: colorScheme.outlineVariant,
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  '$reviewCount ${_reviewsLabel(context)}',
                  style: AppTypography.bodySmall.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            flex: 3,
            child: Column(
              children: [
                for (int i = 5; i >= 1; i--)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      children: [
                        Text(
                          '$i',
                          style: AppTypography.labelSmall.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        Icon(
                          Icons.star,
                          size: 12,
                          color: colorScheme.tertiary,
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(2),
                            child: LinearProgressIndicator(
                              value: maxCount > 0
                                  ? (distribution[i] ?? 0) / maxCount
                                  : 0,
                              minHeight: 6,
                              backgroundColor:
                                  colorScheme.outlineVariant.withValues(alpha: 0.2),
                              valueColor: AlwaysStoppedAnimation<Color>(
                                colorScheme.tertiary,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        SizedBox(
                          width: 24,
                          child: Text(
                            '${distribution[i] ?? 0}',
                            style: AppTypography.labelSmall.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static String _reviewsLabel(BuildContext context) {
    final lang = context.locale.languageCode;
    return switch (lang) {
      'tr' => 'değerlendirme',
      'de' => 'Bewertungen',
      _ => 'reviews',
    };
  }
}
