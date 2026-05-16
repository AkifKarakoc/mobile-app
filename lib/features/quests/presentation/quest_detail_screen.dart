import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/app/router/routes.dart';
import 'package:mobile/app/theme/app_spacing.dart';
import 'package:mobile/app/theme/app_typography.dart';
import 'package:mobile/core/widgets/animated_card.dart';
import 'package:mobile/core/widgets/error_view.dart';
import 'package:mobile/core/widgets/shimmer_placeholder.dart';
import 'package:mobile/core/widgets/tap_feedback.dart';
import 'package:mobile/features/quests/application/quests_provider.dart';
import 'package:mobile/features/quests/application/user_quests_provider.dart';
import 'package:mobile/features/quests/data/dto/quest_detail_response.dart';
import 'package:mobile/features/quests/presentation/quest_step_verify_screen.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class QuestDetailScreen extends ConsumerWidget {
  final String questId;
  final String? heroTag;

  const QuestDetailScreen({super.key, required this.questId, this.heroTag});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final questAsync = ref.watch(questDetailProvider(questId));

    return Scaffold(
      body: questAsync.when(
        data: (quest) => _QuestDetailBody(
          quest: quest,
          questId: questId,
          heroTag: heroTag,
          ref: ref,
        ),
        loading: () => const DetailShimmer(),
        error: (error, _) => ErrorView(
          message: error.toString(),
          onRetry: () => ref.invalidate(questDetailProvider(questId)),
          retryLabel: 'common.retry'.tr(),
        ),
      ),
    );
  }
}

class _QuestDetailBody extends StatelessWidget {
  const _QuestDetailBody({
    required this.quest,
    required this.questId,
    required this.heroTag,
    required this.ref,
  });

  final QuestDetailResponse quest;
  final String questId;
  final String? heroTag;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    final completedSteps = quest.steps.where((s) => s.isCompleted).length;
    final totalSteps = quest.steps.length;
    final progress = totalSteps > 0 ? completedSteps / totalSteps : 0.0;
    final canStart =
        quest.userStatus == null || quest.userStatus == 'NOT_STARTED';

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: 220,
          flexibleSpace: _QuestBanner(
            quest: quest,
            heroTag: heroTag ?? 'quest-thumb-$questId',
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ProgressCard(
                  progress: progress,
                  completed: completedSteps,
                  total: totalSteps,
                ),
                const SizedBox(height: AppSpacing.md),
                if (canStart)
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: () => _startQuest(context, ref),
                      icon: const Icon(Icons.play_arrow),
                      label: Text('user_quests.start_quest'.tr()),
                    ),
                  ),
                const SizedBox(height: AppSpacing.md),
                _ViewMapButton(questId: questId, quest: quest),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  'quests.steps_title'.tr(),
                  style: AppTypography.headlineSmall,
                ),
                const SizedBox(height: AppSpacing.sm),
                ...List.generate(
                  quest.steps.length,
                  (index) => AnimatedCard(
                    delayMs: 100 + (index * 80),
                    child: _QuestStepCard(
                      step: quest.steps[index],
                      questId: questId,
                      index: index,
                      isInProgress: quest.userStatus == 'IN_PROGRESS',
                      gpsThresholdMeters: quest.gpsThresholdMeters,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _startQuest(BuildContext context, WidgetRef ref) async {
    final notifier = ref.read(startQuestProvider(questId).notifier);
    await notifier.start();
    if (context.mounted) {
      ref.invalidate(questDetailProvider(questId));
      ref.invalidate(userQuestsProvider);
    }
  }
}

class _QuestBanner extends StatelessWidget {
  const _QuestBanner({required this.quest, required this.heroTag});

  final QuestDetailResponse quest;
  final String heroTag;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Stack(
      fit: StackFit.expand,
      children: [
        quest.thumbnailUrl != null && quest.thumbnailUrl!.isNotEmpty
            ? Hero(
                tag: heroTag,
                child: Material(
                  type: MaterialType.transparency,
                  child: CachedNetworkImage(
                    imageUrl: quest.thumbnailUrl!,
                    fit: BoxFit.cover,
                    placeholder: (_, __) => Container(
                      color: colorScheme.surfaceContainerHighest,
                    ),
                    errorWidget: (_, __, ___) => Container(
                      color: colorScheme.surfaceContainerHighest,
                      child: Icon(
                        Icons.emoji_events_outlined,
                        size: 64,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ),
              )
            : Container(
                color: colorScheme.surfaceContainerHighest,
                child: Icon(
                  Icons.emoji_events_outlined,
                  size: 64,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                colorScheme.surface.withValues(alpha: 0.3),
                colorScheme.surface.withValues(alpha: 0.9),
              ],
              stops: const [0.4, 0.75, 1.0],
            ),
          ),
        ),
        Positioned(
          top: MediaQuery.paddingOf(context).top + 12,
          right: AppSpacing.md,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: AppSpacing.xs,
            ),
            decoration: BoxDecoration(
              color: colorScheme.tertiaryContainer,
              borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.stars, size: 16, color: colorScheme.onTertiaryContainer),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  '${quest.expReward} XP',
                  style: AppTypography.labelMedium.copyWith(
                    color: colorScheme.onTertiaryContainer,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: AppSpacing.md,
          right: AppSpacing.md,
          bottom: AppSpacing.md,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                quest.title,
                style: AppTypography.headlineSmall.copyWith(
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: 16,
                    color: colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Text(
                    quest.region,
                    style: AppTypography.bodyMedium.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ProgressCard extends StatelessWidget {
  const _ProgressCard({
    required this.progress,
    required this.completed,
    required this.total,
  });

  final double progress;
  final int completed;
  final int total;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      ),
      child: Row(
        children: [
          CircularPercentIndicator(
            radius: 40,
            lineWidth: 8,
            percent: progress,
            center: Text(
              '${(progress * 100).toInt()}%',
              style: AppTypography.titleMedium.copyWith(
                color: colorScheme.primary,
              ),
            ),
            progressColor: colorScheme.primary,
            backgroundColor: colorScheme.outlineVariant.withValues(alpha: 0.2),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'quests.progress_title'.tr(),
                  style: AppTypography.titleSmall,
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'quests.progress_subtitle'.tr(
                    namedArgs: {
                      'completed': '$completed',
                      'total': '$total',
                    },
                  ),
                  style: AppTypography.bodyMedium.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ViewMapButton extends StatelessWidget {
  const _ViewMapButton({required this.questId, required this.quest});

  final String questId;
  final QuestDetailResponse quest;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final hasLocation = quest.steps.any(
      (s) => s.latitude != null && s.longitude != null,
    );

    if (!hasLocation) return const SizedBox.shrink();

    return TapFeedback(
      onTap: () => context.push(AppRoutes.questMapPath(questId)),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        ),
        child: Row(
          children: [
            Icon(Icons.map_outlined, color: colorScheme.onPrimaryContainer),
            const SizedBox(width: AppSpacing.sm),
            Text(
              'quests.view_map'.tr(),
              style: AppTypography.labelLarge.copyWith(
                color: colorScheme.onPrimaryContainer,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: colorScheme.onPrimaryContainer,
            ),
          ],
        ),
      ),
    );
  }
}

class _QuestStepCard extends StatelessWidget {
  const _QuestStepCard({
    required this.step,
    required this.questId,
    required this.index,
    required this.isInProgress,
    required this.gpsThresholdMeters,
  });

  final StepResponse step;
  final String questId;
  final int index;
  final bool isInProgress;
  final int gpsThresholdMeters;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isCompleted = step.isCompleted;
    final isActive = isInProgress && !isCompleted;

    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: isCompleted
                        ? colorScheme.tertiaryContainer
                        : isActive
                            ? colorScheme.primaryContainer
                            : colorScheme.surfaceContainerHighest,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: isCompleted
                        ? Icon(
                            Icons.check,
                            size: 18,
                            color: colorScheme.onTertiaryContainer,
                          )
                        : Text(
                            '${index + 1}',
                            style: AppTypography.labelMedium.copyWith(
                              color: isActive
                                  ? colorScheme.primary
                                  : colorScheme.onSurfaceVariant,
                            ),
                          ),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (step.placeName != null)
                        Text(
                          step.placeName!,
                          style: AppTypography.titleSmall.copyWith(
                            decoration: isCompleted
                                ? TextDecoration.lineThrough
                                : null,
                            color: isCompleted
                                ? colorScheme.outlineVariant
                                : null,
                          ),
                        ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        step.hint ?? 'quests.hint'.tr(),
                        style: AppTypography.bodySmall.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                if (step.requiresPhoto)
                  Padding(
                    padding: const EdgeInsets.only(left: AppSpacing.xs),
                    child: Icon(
                      Icons.camera_alt_outlined,
                      size: 18,
                      color: colorScheme.outlineVariant,
                    ),
                  ),
              ],
            ),
            if (isActive) ...[
              const SizedBox(height: AppSpacing.sm),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () => _navigateToVerify(context),
                  icon: const Icon(Icons.check, size: 16),
                  label: Text('quests.verify_step'.tr()),
                ),
              ),
            ] else if (isCompleted) ...[
              const SizedBox(height: AppSpacing.sm),
              Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    size: 16,
                    color: colorScheme.tertiary,
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Text(
                    'quests.completed'.tr(),
                    style: AppTypography.labelSmall.copyWith(
                      color: colorScheme.tertiary,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _navigateToVerify(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => QuestStepVerifyScreen(
          questId: questId,
          stepId: step.id,
          targetLatitude: step.latitude,
          targetLongitude: step.longitude,
          placeName: step.placeName,
          gpsThresholdMeters: gpsThresholdMeters,
        ),
      ),
    );
  }
}
