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
import 'package:mobile/features/quests/application/quests_provider.dart';
import 'package:mobile/features/quests/data/dto/quest_response.dart';

class QuestsListScreen extends ConsumerWidget {
  const QuestsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final questsAsync = ref.watch(questsProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        leading: Navigator.canPop(context)
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => context.pop(),
              )
            : null,
        title: Text('quests.list_title'.tr(), style: AppTypography.titleLarge),
        centerTitle: false,
        actions: [
          TextButton.icon(
            onPressed: () => context.push(AppRoutes.userQuests),
            icon: const Icon(Icons.list_alt, size: 18),
            label: Text('quests.my_quests'.tr()),
            style: TextButton.styleFrom(
              foregroundColor: colorScheme.primary,
            ),
          ),
        ],
      ),
      body: questsAsync.when(
        data: (quests) => _buildContent(context, quests),
        loading: () => const Center(child: AppLoadingIndicator()),
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

    return ListView.separated(
      padding: const EdgeInsets.all(AppSpacing.md),
      itemCount: quests.length,
      separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.md),
      itemBuilder: (context, index) {
        final quest = quests[index];
        return _QuestTile(quest: quest, heroTag: 'quest-thumb-${quest.id}');
      },
    );
  }
}

class _QuestTile extends StatelessWidget {
  final QuestResponse quest;
  final String heroTag;

  const _QuestTile({required this.quest, required this.heroTag});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final status = quest.userStatus;
    final isInProgress = status == 'IN_PROGRESS';

    return InkWell(
      onTap: () => context.push(AppRoutes.questDetailPath(quest.id)),
      borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          border: Border.all(
            color: colorScheme.outlineVariant.withValues(alpha: 0.5),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImageSection(context),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          quest.title,
                          style: AppTypography.titleMedium,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      _StatusBadge(status: status),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    quest.description,
                    style: AppTypography.bodySmall.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Row(
                    children: [
                      _InfoChip(
                        icon: Icons.location_on_outlined,
                        label: quest.region,
                        color: colorScheme.secondary,
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      _InfoChip(
                        icon: Icons.flag_outlined,
                        label: '${quest.totalSteps} ${'quests.steps'.tr()}',
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      _InfoChip(
                        icon: Icons.stars_outlined,
                        label: '${quest.expReward} XP',
                        color: colorScheme.tertiary,
                      ),
                    ],
                  ),
                  if (isInProgress) ...[
                    const SizedBox(height: AppSpacing.md),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: () =>
                            context.push(AppRoutes.questDetailPath(quest.id)),
                        icon: const Icon(Icons.play_arrow, size: 20),
                        label: Text('user_quests.in_progress'.tr()),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSection(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    if (quest.thumbnailUrl == null) {
      return _buildPlaceholderHeader(context);
    }

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(AppSpacing.radiusLg),
        topRight: Radius.circular(AppSpacing.radiusLg),
      ),
      child: Stack(
        children: [
          Hero(
            tag: heroTag,
            child: Material(
              type: MaterialType.transparency,
              child: Image.network(
                quest.thumbnailUrl!,
                height: 140,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    _buildPlaceholderHeader(context),
              ),
            ),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    colorScheme.surfaceContainerLow.withValues(alpha: 0.8),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholderHeader(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colorScheme.primaryContainer.withValues(alpha: 0.6),
            colorScheme.secondaryContainer.withValues(alpha: 0.4),
          ],
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppSpacing.radiusLg),
          topRight: Radius.circular(AppSpacing.radiusLg),
        ),
      ),
      child: Center(
        child: Icon(
          Icons.emoji_events_outlined,
          color: colorScheme.primary,
          size: 40,
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String? status;

  const _StatusBadge({this.status});

  @override
  Widget build(BuildContext context) {
    final (label, color, icon) = _statusConfig(context);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: AppSpacing.xs),
          Text(
            label,
            style: AppTypography.labelSmall.copyWith(color: color),
          ),
        ],
      ),
    );
  }

  (String, Color, IconData) _statusConfig(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return switch (status) {
      'NOT_STARTED' => (
          'quests.not_started'.tr(),
          colorScheme.outline,
          Icons.circle_outlined,
        ),
      'IN_PROGRESS' => (
          'quests.in_progress'.tr(),
          colorScheme.primary,
          Icons.play_arrow,
        ),
      'COMPLETED' => (
          'quests.completed'.tr(),
          colorScheme.tertiary,
          Icons.check_circle,
        ),
      _ => (
          'quests.not_started'.tr(),
          colorScheme.outline,
          Icons.circle_outlined,
        ),
    };
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? color;

  const _InfoChip({
    required this.icon,
    required this.label,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final chipColor = color ?? colorScheme.primary;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: chipColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: chipColor),
          const SizedBox(width: AppSpacing.xs),
          Text(
            label,
            style: AppTypography.labelSmall.copyWith(color: chipColor),
          ),
        ],
      ),
    );
  }
}
