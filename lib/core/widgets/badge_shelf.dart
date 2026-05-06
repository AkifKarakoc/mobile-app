import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../app/theme/app_typography.dart';

/// Rozet özeti modeli
///
/// Profil sayfasında rozet rafında gösterilmek üzere rozet bilgilerini taşır.
class BadgeSummary {
  /// Rozet benzersiz kimliği
  final String id;

  /// Rozet adı
  final String name;

  /// Rozet ikon rengi (hex string, örn: "#FFD700")
  final String iconColor;

  /// Rozet seviyesi (bronze, silver, gold, platinum) — null ise kazanılmamış
  final String? tier;

  const BadgeSummary({
    required this.id,
    required this.name,
    required this.iconColor,
    this.tier,
  });

  /// Rozetin kazanılıp kazanılmadığı
  bool get isEarned => tier != null;
}

/// Rozet rafı widget'ı
///
/// Profil sayfasında kullanıcının kazandığı rozetleri yatay olarak gösterir.
/// İlk [maxDisplay] kadar rozet gösterilir, fazlası "+N" şeklinde belirtilir.
/// Kazanılmamış rozetler soluk (opacity 0.4) gösterilir.
class BadgeShelf extends StatelessWidget {
  /// Rozet listesi
  final List<BadgeSummary> badges;

  /// Maksimum gösterilecek rozet sayısı
  final int maxDisplay;

  const BadgeShelf({
    super.key,
    required this.badges,
    this.maxDisplay = 5,
  });

  @override
  Widget build(BuildContext context) {
    if (badges.isEmpty) {
      return Center(
        child: Text(
          'common.empty_generic'.tr(),
          style: AppTypography.bodyMedium.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      );
    }

    final displayBadges = badges.take(maxDisplay).toList();
    final remaining = badges.length - maxDisplay;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (int i = 0; i < displayBadges.length; i++) ...[
            _BadgeItem(badge: displayBadges[i]),
            if (i < displayBadges.length - 1 || remaining > 0)
              const SizedBox(width: AppSpacing.sm),
          ],
          if (remaining > 0)
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  'common.more_badges'.tr(args: [remaining.toString()]),
                  style: AppTypography.labelSmall.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _BadgeItem extends StatelessWidget {
  final BadgeSummary badge;

  const _BadgeItem({required this.badge});

  @override
  Widget build(BuildContext context) {
    final color = Color(
      int.parse(badge.iconColor.replaceFirst('#', '0xFF')),
    );

    return Tooltip(
      message: badge.name,
      child: Opacity(
        opacity: badge.isEarned ? 1.0 : 0.4,
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            shape: BoxShape.circle,
            border: Border.all(
              color: color,
              width: 1.5,
            ),
          ),
          child: Icon(
            Icons.emoji_events,
            color: color,
            size: AppSpacing.iconMedium,
          ),
        ),
      ),
    );
  }
}
