import 'package:flutter/material.dart';
import 'package:mobile/app/theme/app_spacing.dart';
import 'package:mobile/app/theme/app_typography.dart';
import 'package:mobile/features/chat/data/dto/chat_response.dart';

class MessageBubble extends StatelessWidget {
  final ChatResponse message;
  final bool isUser;

  const MessageBubble({
    required this.message,
    required this.isUser,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final time = _formatTime(message.sentAt);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isUser) ...[
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
              ),
              child: Icon(
                Icons.smart_toy_outlined,
                size: 16,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
          ],
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.75,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              decoration: BoxDecoration(
                color: isUser
                    ? theme.colorScheme.primary
                    : theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(AppSpacing.radiusMd),
                  topRight: const Radius.circular(AppSpacing.radiusMd),
                  bottomLeft: Radius.circular(
                    isUser ? AppSpacing.radiusMd : AppSpacing.radiusSm,
                  ),
                  bottomRight: Radius.circular(
                    isUser ? AppSpacing.radiusSm : AppSpacing.radiusMd,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SelectableText(
                    message.content,
                    style: AppTypography.bodyMedium.copyWith(
                      color: isUser
                          ? Colors.white
                          : theme.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      time,
                      style: AppTypography.labelSmall.copyWith(
                        color: isUser
                            ? Colors.white.withValues(alpha: 0.7)
                            : theme.colorScheme.outlineVariant,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isUser) const SizedBox(width: AppSpacing.xs),
        ],
      ),
    );
  }

  String _formatTime(String sentAt) {
    try {
      final dateTime = DateTime.parse(sentAt);
      final hour = dateTime.hour.toString().padLeft(2, '0');
      final minute = dateTime.minute.toString().padLeft(2, '0');
      return '$hour:$minute';
    } catch (_) {
      return '';
    }
  }
}
