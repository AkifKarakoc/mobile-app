import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/app/router/routes.dart';
import 'package:mobile/app/theme/app_spacing.dart';
import 'package:mobile/app/theme/app_typography.dart';
import 'package:mobile/core/utils/dialog_helper.dart';
import 'package:mobile/core/utils/snackbar_helper.dart';
import 'package:mobile/core/widgets/app_loading_indicator.dart';
import 'package:mobile/core/widgets/empty_state.dart';
import 'package:mobile/core/widgets/error_view.dart';
import 'package:mobile/features/chat/application/chat_provider.dart';
import 'package:mobile/features/chat/data/dto/chat_session_response.dart';

class ChatSessionsScreen extends ConsumerWidget {
  const ChatSessionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionsState = ref.watch(chatSessionsProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: Text('chat.sessions_title'.tr(), style: AppTypography.titleLarge),
        centerTitle: false,
        actions: [
          IconButton(
            tooltip: 'chat.new_session'.tr(),
            icon: const Icon(Icons.add),
            onPressed: () {
              unawaited(_createNewSession(context, ref));
            },
          ),
        ],
      ),
      body: SafeArea(
        child: sessionsState.when(
          loading: () =>
              AppLoadingIndicator(semanticsLabel: 'common.loading'.tr()),
          error: (error, stackTrace) => ErrorView(
            message: 'common.error_generic'.tr(),
            retryLabel: 'common.retry'.tr(),
            onRetry: () {
              ref.read(chatSessionsProvider.notifier).refresh();
            },
          ),
          data: (sessions) {
            if (sessions.isEmpty) {
              return _EmptySessionsView(
                onCreateSession: () {
                  unawaited(_createNewSession(context, ref));
                },
              );
            }

            return ListView.separated(
              padding: const EdgeInsets.all(AppSpacing.md),
              itemCount: sessions.length,
              separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
              itemBuilder: (context, index) {
                final session = sessions[index];
                return _ChatSessionCard(
                  session: session,
                  onTap: () {
                    context.push(AppRoutes.chatScreenPath(session.sessionId));
                  },
                  onDelete: () {
                    _showDeleteConfirmation(context, ref, session.sessionId);
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }

  Future<void> _createNewSession(BuildContext context, WidgetRef ref) async {
    await ref.read(chatSessionsProvider.notifier).createSession();
    if (context.mounted) {
      final sessions = ref.read(chatSessionsProvider).value;
      if (sessions != null && sessions.isNotEmpty) {
        context.push(AppRoutes.chatScreenPath(sessions.first.sessionId));
      }
    }
  }

  void _showDeleteConfirmation(
    BuildContext context,
    WidgetRef ref,
    String sessionId,
  ) {
    showAnimatedDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text('chat.delete_confirm'.tr()),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text('common.cancel'.tr()),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(dialogContext).pop();
              await ref
                  .read(chatSessionsProvider.notifier)
                  .deleteSession(sessionId);
              if (context.mounted) {
                showFloatingSnackBar(context, 'chat.deleted'.tr());
              }
            },
            child: Text('common.delete'.tr()),
          ),
        ],
      ),
    );
  }
}

class _ChatSessionCard extends StatelessWidget {
  final ChatSessionResponse session;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const _ChatSessionCard({
    required this.session,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final languageLabel = _languageLabel(session.language);
    final languageIcon = _languageIcon(session.language);
    final timeLabel = _formatTimeAgo(context, session.startedAt);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          border: Border.all(
            color: colorScheme.outlineVariant.withValues(alpha: 0.5),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                ),
                child: Icon(
                  languageIcon,
                  color: colorScheme.primary,
                  size: 24,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      languageLabel,
                      style: AppTypography.titleSmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      timeLabel,
                      style: AppTypography.bodySmall.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.delete_outline,
                  color: colorScheme.error,
                  size: 20,
                ),
                onPressed: onDelete,
                tooltip: 'chat.delete_session'.tr(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _languageLabel(String language) {
    return switch (language.toLowerCase()) {
      'tr' => 'chat.language_tr'.tr(),
      'en' => 'chat.language_en'.tr(),
      'de' => 'chat.language_de'.tr(),
      _ => language.toUpperCase(),
    };
  }

  IconData _languageIcon(String language) {
    return switch (language.toLowerCase()) {
      'tr' => Icons.flag,
      'en' => Icons.language,
      'de' => Icons.public,
      _ => Icons.chat,
    };
  }

  String _formatTimeAgo(BuildContext context, DateTime startedAt) {
    final now = DateTime.now();
    final difference = now.difference(startedAt);

    if (difference.inMinutes < 1) {
      return 'notifications.just_now'.tr();
    }
    if (difference.inMinutes < 60) {
      return 'notifications.minutes_ago'.tr(
        namedArgs: {'count': difference.inMinutes.toString()},
      );
    }
    if (difference.inHours < 24) {
      return 'notifications.hours_ago'.tr(
        namedArgs: {'count': difference.inHours.toString()},
      );
    }
    if (difference.inDays == 1) {
      return 'notifications.days_ago'.tr(namedArgs: {'count': '1'});
    }
    if (difference.inDays < 7) {
      return 'notifications.days_ago'.tr(
        namedArgs: {'count': difference.inDays.toString()},
      );
    }
    return '${startedAt.day.toString().padLeft(2, '0')}.${startedAt.month.toString().padLeft(2, '0')}.${startedAt.year}';
  }
}

class _EmptySessionsView extends StatelessWidget {
  final VoidCallback onCreateSession;

  const _EmptySessionsView({required this.onCreateSession});

  @override
  Widget build(BuildContext context) {
    return EmptyState(
      icon: Icons.chat_bubble_outline,
      title: 'chat.empty_title'.tr(),
      description: 'chat.empty_description'.tr(),
      actionLabel: 'chat.start_chat'.tr(),
      onAction: onCreateSession,
    );
  }
}
