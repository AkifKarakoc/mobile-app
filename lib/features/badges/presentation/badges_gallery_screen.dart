import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/app/theme/app_spacing.dart';
import 'package:mobile/app/theme/app_typography.dart';
import 'package:mobile/core/widgets/empty_state.dart';
import 'package:mobile/core/widgets/error_view.dart';
import 'package:mobile/core/widgets/loading_indicator.dart';
import 'package:mobile/features/badges/application/badges_provider.dart';
import 'package:mobile/features/badges/data/dto/badge_response.dart';

class BadgesGalleryScreen extends ConsumerStatefulWidget {
  const BadgesGalleryScreen({super.key});

  @override
  ConsumerState<BadgesGalleryScreen> createState() =>
      _BadgesGalleryScreenState();
}

class _BadgesGalleryScreenState extends ConsumerState<BadgesGalleryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Navigator.canPop(context)
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop(),
              )
            : null,
        title: Text('badges.gallery_title').tr(),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'badges.all_badges'.tr()),
            Tab(text: 'badges.my_badges'.tr()),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          const _AllBadgesTab(),
          const _MyBadgesTab(),
        ],
      ),
    );
  }
}

class _AllBadgesTab extends ConsumerWidget {
  const _AllBadgesTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final badgesAsync = ref.watch(allBadgesProvider);

    return badgesAsync.when(
      loading: () => const Center(child: AppLoadingIndicator()),
      error: (e, _) => ErrorView(
        message: e.toString(),
        onRetry: () => ref.invalidate(allBadgesProvider),
      ),
      data: (badges) {
        if (badges.isEmpty) {
          return EmptyState(
            icon: Icons.emoji_events_outlined,
            title: 'badges.empty_message'.tr(),
          );
        }

        return GridView.builder(
          padding: const EdgeInsets.all(AppSpacing.md),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: AppSpacing.md,
            crossAxisSpacing: AppSpacing.md,
            childAspectRatio: 0.85,
          ),
          itemCount: badges.length,
          itemBuilder: (context, index) {
            final badge = badges[index];
            return _BadgeCard(badge: badge, earned: badge.earnedByUser);
          },
        );
      },
    );
  }
}

class _MyBadgesTab extends ConsumerWidget {
  const _MyBadgesTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myBadgesAsync = ref.watch(myBadgesProvider);

    return myBadgesAsync.when(
      loading: () => const Center(child: AppLoadingIndicator()),
      error: (e, _) => ErrorView(
        message: e.toString(),
        onRetry: () => ref.invalidate(myBadgesProvider),
      ),
      data: (myBadges) {
        if (myBadges.isEmpty) {
          return EmptyState(
            icon: Icons.emoji_events_outlined,
            title: 'badges.empty_message'.tr(),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(AppSpacing.md),
          itemCount: myBadges.length,
          itemBuilder: (context, index) {
            final badge = myBadges[index];
            return _UserBadgeCard(userBadge: badge);
          },
        );
      },
    );
  }
}

class _BadgeCard extends StatelessWidget {
  final BadgeResponse badge;
  final bool earned;

  const _BadgeCard({required this.badge, required this.earned});

  @override
  Widget build(BuildContext context) {
    final iconColor = _parseColor(badge.iconColor);

    return Opacity(
      opacity: earned ? 1.0 : 0.5,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.emoji_events,
                size: 48,
                color: iconColor,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                badge.name,
                style: AppTypography.titleSmall,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                badge.description,
                style: AppTypography.bodySmall.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: AppSpacing.sm),
              if (badge.tier != null)
                _TierBadge(tier: badge.tier!)
              else if (!earned)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: AppSpacing.xs,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                  ),
                  child: Text(
                    'badges.locked'.tr(),
                    style: AppTypography.labelSmall.copyWith(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Color _parseColor(String hexColor) {
    final cleaned = hexColor.replaceFirst('#', '');
    return Color(int.parse('0xFF$cleaned'));
  }
}

class _TierBadge extends StatelessWidget {
  final String tier;

  const _TierBadge({required this.tier});

  @override
  Widget build(BuildContext context) {
    final (label, color) = _tierInfo(tier);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
      ),
      child: Text(
        label,
        style: AppTypography.labelSmall.copyWith(
          color: Colors.white,
        ),
      ),
    );
  }

  (String, Color) _tierInfo(String tier) {
    return switch (tier) {
      'BRONZE' => ('badges.tier_bronze'.tr(), const Color(0xFFCD7F32)),
      'SILVER' => ('badges.tier_silver'.tr(), const Color(0xFFC0C0C0)),
      'GOLD' => ('badges.tier_gold'.tr(), const Color(0xFFFFD700)),
      _ => (tier, Colors.grey),
    };
  }
}

class _UserBadgeCard extends StatelessWidget {
  final UserBadgeResponse userBadge;

  const _UserBadgeCard({required this.userBadge});

  @override
  Widget build(BuildContext context) {
    final iconColor = _parseColor(userBadge.badgeIconColor);
    final formattedDate = _formatDate(userBadge.earnedAt);

    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Row(
          children: [
            Icon(
              Icons.emoji_events,
              size: 40,
              color: iconColor,
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userBadge.badgeName,
                    style: AppTypography.titleSmall,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    userBadge.badgeDescription,
                    style: AppTypography.bodySmall.copyWith(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    '${'badges.earned_at'.tr()}: $formattedDate',
                    style: AppTypography.bodySmall.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _parseColor(String hexColor) {
    final cleaned = hexColor.replaceFirst('#', '');
    return Color(int.parse('0xFF$cleaned'));
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year;
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');
    return '$day.$month.$year $hour:$minute';
  }
}
