import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/app/router/routes.dart';
import 'package:mobile/app/theme/app_spacing.dart';
import 'package:mobile/app/theme/app_typography.dart';
import 'package:mobile/core/widgets/error_view.dart';
import 'package:mobile/core/widgets/loading_indicator.dart';
import 'package:mobile/features/quests/application/quests_provider.dart';
import 'package:mobile/features/quests/application/user_quests_provider.dart';
import 'package:mobile/features/quests/data/dto/quest_detail_response.dart';

class QuestDetailScreen extends ConsumerWidget {
  final String questId;

  const QuestDetailScreen({super.key, required this.questId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final questAsync = ref.watch(questDetailProvider(questId));

    return Scaffold(
      appBar: AppBar(
        title: Text('quests.detail_title'.tr()),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
      ),
      body: questAsync.when(
        data: (quest) => _buildContent(context, quest, ref),
        loading: () => const AppLoadingIndicator(),
        error: (error, _) => ErrorView(
          message: error.toString(),
          onRetry: () => ref.invalidate(questDetailProvider(questId)),
          retryLabel: 'common.retry'.tr(),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    QuestDetailResponse quest,
    WidgetRef ref,
  ) {
    final canStart = quest.userStatus == null || quest.userStatus == 'NOT_STARTED';

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (quest.thumbnailUrl != null) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              child: Image.network(
                quest.thumbnailUrl!,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    _placeholderImage(context),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
          ],
          Text(
            quest.title,
            style: AppTypography.headlineMedium,
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 16,
                color: Theme.of(context).colorScheme.outlineVariant,
              ),
              const SizedBox(width: AppSpacing.xs),
              Text(
                '${'quests.region'.tr()}: ${quest.region}',
                style: AppTypography.bodyMedium.copyWith(
                  color: Theme.of(context).colorScheme.outlineVariant,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Icon(
                Icons.stars,
                size: 16,
                color: Theme.of(context).colorScheme.outlineVariant,
              ),
              const SizedBox(width: AppSpacing.xs),
              Text(
                '${'quests.reward'.tr()}: ${quest.expReward} XP',
                style: AppTypography.bodyMedium.copyWith(
                  color: Theme.of(context).colorScheme.outlineVariant,
                ),
              ),
            ],
          ),
          if (quest.userStatus != null) ...[
            const SizedBox(height: AppSpacing.sm),
            _StatusBadge(status: quest.userStatus!),
          ],
          if (canStart) ...[
            const SizedBox(height: AppSpacing.md),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () => _startQuest(context, ref),
                icon: const Icon(Icons.play_arrow),
                label: Text('user_quests.start_quest'.tr()),
              ),
            ),
          ],
          const SizedBox(height: AppSpacing.md),
          Text(
            quest.description,
            style: AppTypography.bodyMedium,
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'quests.steps_title'.tr(),
            style: AppTypography.titleLarge,
          ),
          const SizedBox(height: AppSpacing.sm),
          ...quest.steps.map((step) => _StepTile(step: step)),
        ],
      ),
    );
  }

  Future<void> _startQuest(BuildContext context, WidgetRef ref) async {
    final notifier = ref.read(startQuestProvider(questId).notifier);
    await notifier.start();
    if (context.mounted) {
      ref.invalidate(questDetailProvider(questId));
    }
  }

  Widget _placeholderImage(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      ),
      child: Icon(
        Icons.emoji_events_outlined,
        color: Theme.of(context).colorScheme.outlineVariant,
        size: 48,
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String status;

  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    final (label, color) = _statusConfig(context);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
      ),
      child: Text(
        label,
        style: AppTypography.labelSmall.copyWith(color: color),
      ),
    );
  }

  (String, Color) _statusConfig(BuildContext context) {
    return switch (status) {
      'NOT_STARTED' => (
          'quests.not_started'.tr(),
          Theme.of(context).colorScheme.outlineVariant,
        ),
      'IN_PROGRESS' => (
          'quests.in_progress'.tr(),
          Theme.of(context).colorScheme.primary,
        ),
      'COMPLETED' => (
          'quests.completed'.tr(),
          Theme.of(context).colorScheme.tertiary,
        ),
      _ => (
          'quests.not_started'.tr(),
          Theme.of(context).colorScheme.outlineVariant,
        ),
    };
  }
}

class _StepTile extends StatelessWidget {
  final StepResponse step;

  const _StepTile({required this.step});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: InkWell(
        onTap: () => context.push(AppRoutes.placeDetailPath(step.placeId)),
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: step.isCompleted
                      ? Theme.of(context).colorScheme.tertiary.withValues(alpha: 0.12)
                      : Theme.of(context).colorScheme.surfaceContainerHighest,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: step.isCompleted
                      ? Icon(
                          Icons.check,
                          size: 16,
                          color: Theme.of(context).colorScheme.tertiary,
                        )
                      : Text(
                          '${step.stepOrder}',
                          style: AppTypography.labelMedium.copyWith(
                            color: Theme.of(context).colorScheme.outlineVariant,
                          ),
                        ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      step.hint,
                      style: AppTypography.bodyMedium,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Row(
                      children: [
                        if (step.requiresPhoto) ...[
                          Icon(
                            Icons.camera_alt_outlined,
                            size: 14,
                            color: Theme.of(context).colorScheme.outlineVariant,
                          ),
                          const SizedBox(width: AppSpacing.xs),
                          Text(
                            'quests.requires_photo'.tr(),
                            style: AppTypography.bodySmall.copyWith(
                              color: Theme.of(context).colorScheme.outlineVariant,
                            ),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                        ],
                        Icon(
                          step.isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
                          size: 14,
                          color: step.isCompleted
                              ? Theme.of(context).colorScheme.tertiary
                              : Theme.of(context).colorScheme.outlineVariant,
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        Text(
                          step.isCompleted
                              ? 'quests.completed'.tr()
                              : 'quests.not_completed'.tr(),
                          style: AppTypography.bodySmall.copyWith(
                            color: step.isCompleted
                                ? Theme.of(context).colorScheme.tertiary
                                : Theme.of(context).colorScheme.outlineVariant,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: Theme.of(context).colorScheme.outlineVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
