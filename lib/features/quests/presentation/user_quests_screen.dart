import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/app/router/routes.dart';
import 'package:mobile/app/theme/app_spacing.dart';
import 'package:mobile/app/theme/app_typography.dart';
import 'package:mobile/core/widgets/empty_state.dart';
import 'package:mobile/core/widgets/error_view.dart';
import 'package:mobile/core/widgets/loading_indicator.dart';
import 'package:mobile/features/quests/application/user_quests_provider.dart';
import 'package:mobile/features/quests/data/dto/user_quest_response.dart';

class UserQuestsScreen extends ConsumerWidget {
  const UserQuestsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userQuestsAsync = ref.watch(userQuestsProvider);

    return Scaffold(
      appBar: AppBar(
        leading: Navigator.canPop(context)
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => context.pop(),
              )
            : null,
        title: Text('user_quests.title'.tr()),
      ),
      body: userQuestsAsync.when(
        data: (quests) => _buildContent(context, quests),
        loading: () => const AppLoadingIndicator(),
        error: (error, _) => ErrorView(
          message: error.toString(),
          onRetry: () => ref.invalidate(userQuestsProvider),
          retryLabel: 'common.retry'.tr(),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, List<UserQuestResponse> quests) {
    if (quests.isEmpty) {
      return EmptyState(
        icon: Icons.emoji_events_outlined,
        title: 'user_quests.no_quests'.tr(),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      itemCount: quests.length,
      itemBuilder: (context, index) {
        final quest = quests[index];
        return _UserQuestCard(quest: quest);
      },
    );
  }
}

class _UserQuestCard extends StatelessWidget {
  final UserQuestResponse quest;

  const _UserQuestCard({required this.quest});

  @override
  Widget build(BuildContext context) {
    final progress = quest.totalSteps > 0
        ? quest.completedSteps / quest.totalSteps
        : 0.0;

    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      child: InkWell(
        onTap: () => context.push(AppRoutes.questDetailPath(quest.questId)),
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (quest.questThumbnailUrl != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                  child: Image.network(
                    quest.questThumbnailUrl!,
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
                      quest.questTitle,
                      style: AppTypography.titleMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      quest.questDescription,
                      style: AppTypography.bodySmall.copyWith(
                        color: Theme.of(context).colorScheme.outlineVariant,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    _StatusBadge(status: quest.status),
                    const SizedBox(height: AppSpacing.xs),
                    Row(
                      children: [
                        Text(
                          'user_quests.progress'.tr(),
                          style: AppTypography.bodySmall.copyWith(
                            color: Theme.of(context).colorScheme.outlineVariant,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        Text(
                          '${quest.completedSteps}/${quest.totalSteps}',
                          style: AppTypography.bodySmall.copyWith(
                            color: Theme.of(context).colorScheme.outlineVariant,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    LinearProgressIndicator(
                      value: progress,
                      minHeight: 4,
                      borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                    ),
                  ],
                ),
              ),
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
      'IN_PROGRESS' => (
          'user_quests.in_progress'.tr(),
          Theme.of(context).colorScheme.primary,
        ),
      'COMPLETED' => (
          'user_quests.completed'.tr(),
          Theme.of(context).colorScheme.tertiary,
        ),
      _ => (
          'user_quests.in_progress'.tr(),
          Theme.of(context).colorScheme.outlineVariant,
        ),
    };
  }
}
