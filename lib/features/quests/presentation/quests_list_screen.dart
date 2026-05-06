import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/app/theme/app_spacing.dart';
import 'package:mobile/app/theme/app_typography.dart';
import 'package:mobile/core/widgets/empty_state.dart';
import 'package:mobile/core/widgets/error_view.dart';
import 'package:mobile/core/widgets/loading_indicator.dart';
import 'package:mobile/features/quests/application/quests_provider.dart';
import 'package:mobile/features/quests/data/dto/quest_response.dart';

class QuestsListScreen extends ConsumerWidget {
  const QuestsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final questsAsync = ref.watch(questsProvider);

    return Scaffold(
      appBar: AppBar(
        leading: Navigator.canPop(context)
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => context.pop(),
              )
            : null,
        title: Text('quests.list_title'.tr()),
        actions: [
          TextButton.icon(
            onPressed: () => context.push('/home/profile/quests'),
            icon: const Icon(Icons.list_alt, size: 18),
            label: Text('quests.my_quests'.tr()),
          ),
        ],
      ),
      body: questsAsync.when(
        data: (quests) => _buildContent(context, quests),
        loading: () => const AppLoadingIndicator(),
        error: (error, _) => ErrorView(
          message: error.toString(),
          onRetry: () => ref.invalidate(questsProvider),
          retryLabel: 'common.retry'.tr(),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, List<QuestResponse> quests) {
    if (quests.isEmpty) {
      return EmptyState(
        icon: Icons.emoji_events_outlined,
        title: 'quests.empty_message'.tr(),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      itemCount: quests.length,
      itemBuilder: (context, index) {
        final quest = quests[index];
        return _QuestTile(quest: quest);
      },
    );
  }
}

class _QuestTile extends StatelessWidget {
  final QuestResponse quest;

  const _QuestTile({required this.quest});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      child: InkWell(
        onTap: () => context.go('/quests/${quest.id}'),
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (quest.thumbnailUrl != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                  child: Image.network(
                    quest.thumbnailUrl!,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        _placeholderThumbnail(context),
                  ),
                )
              else
                _placeholderThumbnail(context),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      quest.title,
                      style: AppTypography.titleMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      quest.description,
                      style: AppTypography.bodySmall.copyWith(
                        color: Theme.of(context).colorScheme.outlineVariant,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Wrap(
                      spacing: AppSpacing.sm,
                      runSpacing: AppSpacing.xs,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              size: 14,
                              color: Theme.of(context).colorScheme.outlineVariant,
                            ),
                            const SizedBox(width: AppSpacing.xs),
                            Text(
                              quest.region,
                              style: AppTypography.bodySmall.copyWith(
                                color: Theme.of(context).colorScheme.outlineVariant,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.flag,
                              size: 14,
                              color: Theme.of(context).colorScheme.outlineVariant,
                            ),
                            const SizedBox(width: AppSpacing.xs),
                            Text(
                              '${quest.totalSteps} ${'quests.steps'.tr()}',
                              style: AppTypography.bodySmall.copyWith(
                                color: Theme.of(context).colorScheme.outlineVariant,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.stars,
                              size: 14,
                              color: Theme.of(context).colorScheme.outlineVariant,
                            ),
                            const SizedBox(width: AppSpacing.xs),
                            Text(
                              '${quest.expReward} ${'quests.xp_reward'.tr()}',
                              style: AppTypography.bodySmall.copyWith(
                                color: Theme.of(context).colorScheme.outlineVariant,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              _StatusBadge(status: quest.userStatus),
            ],
          ),
        ),
      ),
    );
  }

  Widget _placeholderThumbnail(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
      ),
      child: Icon(
        Icons.emoji_events_outlined,
        color: Theme.of(context).colorScheme.outlineVariant,
        size: 28,
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String? status;

  const _StatusBadge({this.status});

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
