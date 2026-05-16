import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/app/router/routes.dart';
import 'package:mobile/app/theme/app_spacing.dart';
import 'package:mobile/app/theme/app_typography.dart';
import 'package:mobile/core/widgets/tap_feedback.dart';
import 'package:mobile/features/quests/application/user_quests_provider.dart';
import 'package:mobile/features/quests/data/dto/user_quest_response.dart';
import 'package:mobile/features/routes/application/user_routes_provider.dart';
import 'package:mobile/features/routes/data/dto/user_route_response.dart';

/// Active quest/route banner for the home screen.
///
/// Shows the first in-progress quest or route with a progress bar.
/// If no active quest/route exists, shows a CTA to start exploring.
class ActiveQuestBanner extends ConsumerWidget {
  const ActiveQuestBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userQuests = ref.watch(userQuestsProvider);
    final userRoutes = ref.watch(userRoutesProvider);

    return userQuests.when(
      data: (quests) => userRoutes.when(
        data: (routes) {
          final activeQuest = quests
              .where((q) => q.status == 'IN_PROGRESS')
              .firstOrNull;
          final activeRoute = routes
              .where((r) => r.status == 'IN_PROGRESS')
              .firstOrNull;

          if (activeQuest != null) {
            return _ActiveQuestCard(quest: activeQuest);
          }
          if (activeRoute != null) {
            return _ActiveRouteCard(route: activeRoute);
          }

          return _EmptyBanner();
        },
        loading: () => _LoadingBanner(),
        error: (_, __) => const SizedBox.shrink(),
      ),
      loading: () => _LoadingBanner(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }
}

class _ActiveQuestCard extends StatelessWidget {
  final UserQuestResponse quest;

  const _ActiveQuestCard({required this.quest});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final progress = quest.totalSteps > 0
        ? quest.completedSteps / quest.totalSteps
        : 0.0;

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.colorScheme.primary,
            theme.colorScheme.primary.withValues(alpha: 0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.xs),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                ),
                child: const Icon(Icons.flag, color: Colors.white, size: 18),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'home.active_quest'.tr(),
                      style: AppTypography.labelSmall.copyWith(
                        color: Colors.white.withValues(alpha: 0.8),
                      ),
                    ),
                    Text(
                      quest.questTitle,
                      style: AppTypography.titleSmall.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Expanded(
                child: TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: progress),
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeInOut,
                  builder: (context, value, _) => ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: value,
                      minHeight: 6,
                      backgroundColor: Colors.white.withValues(alpha: 0.3),
                      valueColor: const AlwaysStoppedAnimation(Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                '${quest.completedSteps}/${quest.totalSteps}',
                style: AppTypography.labelSmall.copyWith(color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: () => context.push(AppRoutes.userQuests),
              icon: const Icon(
                Icons.arrow_forward,
                size: 16,
                color: Colors.white,
              ),
              label: Text(
                'common.continue'.tr(),
                style: AppTypography.labelMedium.copyWith(color: Colors.white),
              ),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActiveRouteCard extends StatelessWidget {
  final UserRouteResponse route;

  const _ActiveRouteCard({required this.route});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.colorScheme.secondary,
            theme.colorScheme.secondary.withValues(alpha: 0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.secondary.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.xs),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                ),
                child: const Icon(Icons.route, color: Colors.white, size: 18),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'home.active_route'.tr(),
                      style: AppTypography.labelSmall.copyWith(
                        color: Colors.white.withValues(alpha: 0.8),
                      ),
                    ),
                    Text(
                      route.routeName ?? 'home.unknown_route'.tr(),
                      style: AppTypography.titleSmall.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: () => context.push(AppRoutes.userRoutes),
              icon: const Icon(
                Icons.arrow_forward,
                size: 16,
                color: Colors.white,
              ),
              label: Text(
                'common.continue'.tr(),
                style: AppTypography.labelMedium.copyWith(color: Colors.white),
              ),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.3),
        ),
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
            ),
            child: Icon(
              Icons.explore_outlined,
              color: theme.colorScheme.onPrimaryContainer,
              size: 24,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'home.no_active_quest'.tr(),
                  style: AppTypography.titleSmall.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'home.start_exploring'.tr(),
                  style: AppTypography.bodySmall.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          TapFeedback(
            onTap: () => context.push(AppRoutes.questsList),
            child: Container(
              padding: const EdgeInsets.all(AppSpacing.sm),
              child: Icon(
                Icons.arrow_forward,
                color: theme.colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LoadingBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      height: 80,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
      ),
    );
  }
}
