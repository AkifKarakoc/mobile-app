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
import 'package:percent_indicator/circular_percent_indicator.dart';

class UserQuestsScreen extends ConsumerStatefulWidget {
  const UserQuestsScreen({super.key});

  @override
  ConsumerState<UserQuestsScreen> createState() => _UserQuestsScreenState();
}

class _UserQuestsScreenState extends ConsumerState<UserQuestsScreen>
    with SingleTickerProviderStateMixin {
  String _filter = 'IN_PROGRESS';

  @override
  Widget build(BuildContext context) {
    final userQuestsAsync = ref.watch(userQuestsProvider);
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
        title: Text('user_quests.title'.tr(), style: AppTypography.titleLarge),
        centerTitle: false,
      ),
      body: userQuestsAsync.when(
        data: (quests) => Column(
          children: [
            _buildFilterChips(context),
            const SizedBox(height: AppSpacing.sm),
            Expanded(child: _buildContent(context, quests)),
          ],
        ),
        loading: () => const Center(child: AppLoadingIndicator()),
        error: (error, _) => ErrorView(
          message: error.toString(),
          onRetry: () => ref.invalidate(userQuestsProvider),
          retryLabel: 'common.retry'.tr(),
        ),
      ),
    );
  }

  Widget _buildFilterChips(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final filters = [
      ('user_quests.in_progress'.tr(), 'IN_PROGRESS'),
      ('user_quests.completed'.tr(), 'COMPLETED'),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: SegmentedButton<String>(
        segments: filters
            .map(
              (f) => ButtonSegment<String>(
                value: f.$2,
                label: Text(f.$1),
                icon: Icon(
                  f.$2 == 'IN_PROGRESS'
                      ? Icons.play_circle_outline
                      : Icons.check_circle_outline,
                ),
              ),
            )
            .toList(),
        selected: {_filter},
        onSelectionChanged: (selected) {
          setState(() => _filter = selected.first);
        },
        style: SegmentedButton.styleFrom(
          backgroundColor: colorScheme.surfaceContainerLow,
          selectedBackgroundColor: colorScheme.primaryContainer,
          selectedForegroundColor: colorScheme.onPrimaryContainer,
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, List<UserQuestResponse> quests) {
    final filtered = quests.where((q) => q.status == _filter).toList();

    if (filtered.isEmpty) {
      return EmptyState(
        icon: _filter == 'IN_PROGRESS'
            ? Icons.play_circle_outline
            : Icons.emoji_events_outlined,
        title: _filter == 'IN_PROGRESS'
            ? 'user_quests.no_quests'.tr()
            : 'user_quests.no_completed_quests'.tr(),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(AppSpacing.md),
      itemCount: filtered.length,
      separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.md),
      itemBuilder: (context, index) => _UserQuestCard(quest: filtered[index]),
    );
  }
}

class _UserQuestCard extends StatelessWidget {
  final UserQuestResponse quest;

  const _UserQuestCard({required this.quest});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final progress = quest.totalSteps > 0
        ? quest.completedSteps / quest.totalSteps
        : 0.0;
    final isCompleted = quest.status == 'COMPLETED';

    return InkWell(
      onTap: () => context.push(AppRoutes.questDetailPath(quest.questId)),
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
            _buildHeader(context, isCompleted),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircularPercentIndicator(
                        radius: 32,
                        lineWidth: 6,
                        percent: progress,
                        center: Text(
                          '${(progress * 100).toInt()}%',
                          style: AppTypography.labelMedium.copyWith(
                            color: isCompleted
                                ? colorScheme.tertiary
                                : colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        progressColor: isCompleted
                            ? colorScheme.tertiary
                            : colorScheme.primary,
                        backgroundColor: colorScheme.primary.withValues(
                          alpha: 0.15,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              quest.questTitle,
                              style: AppTypography.titleMedium,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: AppSpacing.xs),
                            Text(
                              quest.questDescription,
                              style: AppTypography.bodySmall.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Row(
                    children: [
                      _InfoChip(
                        icon: Icons.flag_outlined,
                        label:
                            '${quest.completedSteps}/${quest.totalSteps} ${'quests.steps'.tr()}',
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      _InfoChip(
                        icon: Icons.stars_outlined,
                        label: '${quest.totalSteps * 50} XP',
                        color: colorScheme.tertiary,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isCompleted) {
    final colorScheme = Theme.of(context).colorScheme;
    final gradientColors = isCompleted
        ? [
            colorScheme.tertiary.withValues(alpha: 0.8),
            colorScheme.tertiaryContainer.withValues(alpha: 0.6),
          ]
        : [
            colorScheme.primary.withValues(alpha: 0.8),
            colorScheme.primaryContainer.withValues(alpha: 0.6),
          ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradientColors,
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppSpacing.radiusLg),
          topRight: Radius.circular(AppSpacing.radiusLg),
        ),
      ),
      child: Row(
        children: [
          Icon(
            isCompleted ? Icons.emoji_events : Icons.explore_outlined,
            color: colorScheme.onPrimaryContainer,
            size: 24,
          ),
          const SizedBox(width: AppSpacing.sm),
          Text(
            isCompleted ? 'user_quests.completed'.tr() : 'user_quests.in_progress'.tr(),
            style: AppTypography.labelLarge.copyWith(
              color: colorScheme.onPrimaryContainer,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
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
