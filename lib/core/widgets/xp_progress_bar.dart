import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../app/theme/app_typography.dart';

/// XP ilerleme çubuğu widget'ı
///
/// Mevcut XP'nin bir sonraki seviye için gereken XP'ye oranını gösterir.
/// Üzerinde "1250 / 2000 XP" formatında label bulunur.
class XPProgressBar extends StatelessWidget {
  /// Mevcut XP miktarı
  final int currentXP;

  /// Bir sonraki seviye için gereken XP miktarı
  final int requiredXP;

  /// İlerleme etiketinin gösterilip gösterilmeyeceği
  final bool showLabel;

  const XPProgressBar({
    super.key,
    required this.currentXP,
    required this.requiredXP,
    this.showLabel = true,
  });

  @override
  Widget build(BuildContext context) {
    final progress = requiredXP > 0 ? currentXP / requiredXP : 0.0;
    final clampedProgress = progress.clamp(0.0, 1.0);
    final primaryColor = Theme.of(context).colorScheme.primary;
    final bgColor = Theme.of(context).colorScheme.surfaceContainerHighest;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          child: LinearProgressIndicator(
            value: clampedProgress,
            minHeight: 8,
            backgroundColor: bgColor,
            valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
            borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          ),
        ),
        if (showLabel) ...[
          const SizedBox(height: AppSpacing.xs),
          Text(
            'common.xp_progress'.tr(namedArgs: {
              'current': currentXP.toString(),
              'required': requiredXP.toString(),
            }),
            style: AppTypography.labelSmall.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );
  }
}
