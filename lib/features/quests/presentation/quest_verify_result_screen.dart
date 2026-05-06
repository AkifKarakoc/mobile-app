import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/app/theme/app_spacing.dart';
import 'package:mobile/app/theme/app_typography.dart';
import 'package:mobile/core/widgets/app_button.dart';
import 'package:mobile/features/quests/data/dto/verify_step_response.dart';

class QuestVerifyResultScreen extends StatelessWidget {
  final VerifyStepResponse result;

  const QuestVerifyResultScreen({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildIcon(context),
              const SizedBox(height: AppSpacing.lg),
              _buildTitle(context),
              const SizedBox(height: AppSpacing.sm),
              _buildMessage(context),
              if (result.status == 'APPROVED' && result.expEarned > 0) ...[
                const SizedBox(height: AppSpacing.md),
                _buildExpBadge(context),
              ],
              const SizedBox(height: AppSpacing.xxl),
              _buildActionButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(BuildContext context) {
    return switch (result.status) {
      'APPROVED' => Container(
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.tertiary.withValues(alpha: 0.12),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.check_circle,
            size: 80,
            color: Theme.of(context).colorScheme.tertiary,
          ),
        ),
      'PENDING_REVIEW' || 'PENDING' => Container(
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.12),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.hourglass_top,
            size: 80,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      'REJECTED' => Container(
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.error.withValues(alpha: 0.12),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.cancel_outlined,
            size: 80,
            color: Theme.of(context).colorScheme.error,
          ),
        ),
      _ => const SizedBox.shrink(),
    };
  }

  Widget _buildTitle(BuildContext context) {
    final title = switch (result.status) {
      'APPROVED' => 'quest_verify.approved_title'.tr(),
      'PENDING_REVIEW' || 'PENDING' => 'quest_verify.pending_title'.tr(),
      'REJECTED' => 'quest_verify.rejected_title'.tr(),
      _ => 'quest_verify.title'.tr(),
    };

    return Text(
      title,
      style: AppTypography.headlineMedium,
      textAlign: TextAlign.center,
    );
  }

  Widget _buildMessage(BuildContext context) {
    final message = switch (result.status) {
      'APPROVED' => 'quest_verify.approved_message'.tr(),
      'PENDING_REVIEW' || 'PENDING' => 'quest_verify.pending_message'.tr(),
      'REJECTED' => 'quest_verify.rejected_message'.tr(),
      _ => '',
    };

    return Text(
      message,
      style: AppTypography.bodyLarge.copyWith(
        color: Theme.of(context).colorScheme.outlineVariant,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildExpBadge(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.stars,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: AppSpacing.xs),
          Text(
            '${'quest_verify.exp_earned'.tr()}: ${result.expEarned} XP',
            style: AppTypography.titleMedium.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(BuildContext context) {
    return switch (result.status) {
      'APPROVED' => AppButton.primary(
          label: 'quest_verify.continue'.tr(),
          onPressed: () => context.pop(),
          fullWidth: true,
        ),
      'PENDING_REVIEW' || 'PENDING' => AppButton.primary(
          label: 'quest_verify.ok'.tr(),
          onPressed: () => context.pop(),
          fullWidth: true,
        ),
      'REJECTED' => AppButton.primary(
          label: 'quest_verify.retry'.tr(),
          onPressed: () => context.pop(),
          fullWidth: true,
        ),
      _ => AppButton.primary(
          label: 'quest_verify.ok'.tr(),
          onPressed: () => context.pop(),
          fullWidth: true,
        ),
    };
  }
}
