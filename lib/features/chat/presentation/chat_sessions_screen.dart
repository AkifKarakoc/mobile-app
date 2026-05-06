import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/app/router/routes.dart';
import 'package:mobile/app/theme/app_spacing.dart';
import 'package:mobile/core/widgets/app_loading_indicator.dart';
import 'package:mobile/core/widgets/empty_state.dart';
import 'package:mobile/core/widgets/error_view.dart';
import 'package:mobile/features/chat/application/chat_provider.dart';
import 'package:mobile/features/chat/presentation/widgets/chat_session_tile.dart';

class ChatSessionsScreen extends ConsumerWidget {
  const ChatSessionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionsState = ref.watch(chatSessionsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('chat.sessions_title'.tr()),
        centerTitle: true,
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
          loading: () => AppLoadingIndicator(semanticsLabel: 'common.loading'.tr()),
          error: (error, stackTrace) => ErrorView(
            message: 'common.error_generic'.tr(),
            retryLabel: 'common.retry'.tr(),
            onRetry: () {
              ref.read(chatSessionsProvider.notifier).refresh();
            },
          ),
          data: (sessions) {
            if (sessions.isEmpty) {
              return _EmptySessionsView(onCreateSession: () {
                unawaited(_createNewSession(context, ref));
              });
            }

            return ListView.builder(
              padding: const EdgeInsets.only(top: AppSpacing.sm, bottom: AppSpacing.md),
              itemCount: sessions.length,
              itemBuilder: (context, index) {
                final session = sessions[index];
                return ChatSessionTile(
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

  void _showDeleteConfirmation(BuildContext context, WidgetRef ref, String sessionId) {
    showDialog<void>(
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
              await ref.read(chatSessionsProvider.notifier).deleteSession(sessionId);
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('chat.deleted'.tr())),
                );
              }
            },
            child: Text('common.delete'.tr()),
          ),
        ],
      ),
    );
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
