import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile/app/theme/app_spacing.dart';
import 'package:mobile/app/theme/app_typography.dart';
import 'package:mobile/features/chat/data/dto/chat_session_response.dart';

class ChatSessionTile extends StatelessWidget {
  final ChatSessionResponse session;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const ChatSessionTile({
    super.key,
    required this.session,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final languageLabel = _languageLabel(session.language);
    final languageIcon = _languageIcon(session.language);
    final timeLabel = _formatTimeAgo(context, session.startedAt);

    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          child: Icon(languageIcon, color: Theme.of(context).colorScheme.onPrimaryContainer),
        ),
        title: Text(
          languageLabel,
          style: AppTypography.titleMedium,
        ),
        subtitle: Text(
          timeLabel,
          style: AppTypography.bodySmall.copyWith(
            color: Theme.of(context).colorScheme.outline,
          ),
        ),
        trailing: IconButton(
          tooltip: 'chat.delete_session'.tr(),
          icon: Icon(
            Icons.delete_outline,
            color: Theme.of(context).colorScheme.error,
          ),
          onPressed: onDelete,
        ),
        onTap: onTap,
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
      return 'chat.today'.tr();
    }
    if (difference.inMinutes < 60) {
      return 'chat.time_ago'.tr(namedArgs: {'time': '${difference.inMinutes} dk'});
    }
    if (difference.inHours < 24) {
      return 'chat.time_ago'.tr(namedArgs: {'time': '${difference.inHours} saat'});
    }
    if (difference.inDays == 1) {
      return 'chat.yesterday'.tr();
    }
    if (difference.inDays < 7) {
      return 'chat.time_ago'.tr(namedArgs: {'time': '${difference.inDays} gün'});
    }
    return '${startedAt.day}.${startedAt.month}.${startedAt.year}';
  }
}
