import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/app/theme/app_spacing.dart';
import 'package:mobile/core/widgets/animated_card.dart';
import 'package:mobile/core/widgets/empty_state.dart';
import 'package:mobile/core/widgets/error_view.dart';
import 'package:mobile/core/widgets/shimmer_placeholder.dart';
import 'package:mobile/features/notifications/application/notifications_provider.dart';
import 'package:mobile/features/notifications/data/dto/notification_response.dart';

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationsAsync = ref.watch(notificationsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('notifications.title'.tr()),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: 'notifications.mark_all_read'.tr(),
            icon: const Icon(Icons.done_all),
            onPressed: () {
              ref.read(notificationsProvider.notifier).markAllAsRead();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: notificationsAsync.when(
          loading: () => _buildShimmerList(context),
          error: (error, stackTrace) => ErrorView(
            message: 'common.error_generic'.tr(),
            retryLabel: 'common.retry'.tr(),
            onRetry: () {
              ref.read(notificationsProvider.notifier).refresh();
            },
          ),
          data: (notifications) {
            if (notifications.isEmpty) {
              return EmptyState(
                icon: Icons.notifications_none_outlined,
                title: 'notifications.empty_title'.tr(),
                description: 'notifications.empty_description'.tr(),
              );
            }

            return ListView.separated(
              padding: const EdgeInsets.only(
                top: AppSpacing.sm,
                bottom: AppSpacing.md,
              ),
              itemCount: notifications.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return AnimatedCard(
                  delayMs: index < 10 ? index * 50 : 0,
                  child: _NotificationTile(
                    notification: notification,
                    onTap: () {
                      if (!notification.isRead) {
                        ref
                            .read(notificationsProvider.notifier)
                            .markAsRead(notification.id);
                      }
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  static Widget _buildShimmerList(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(top: AppSpacing.sm, bottom: AppSpacing.md),
      itemCount: 5,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) => const ListTileShimmer(),
    );
  }
}

class _NotificationTile extends StatelessWidget {
  final NotificationResponse notification;
  final VoidCallback onTap;

  const _NotificationTile({required this.notification, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isUnread = !notification.isRead;

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: isUnread
            ? theme.colorScheme.primaryContainer
            : theme.colorScheme.surfaceContainerHighest,
        child: Icon(
          _iconForType(notification.type),
          color: isUnread
              ? theme.colorScheme.onPrimaryContainer
              : theme.colorScheme.onSurfaceVariant,
          size: 20,
        ),
      ),
      title: Text(
        notification.title,
        style: theme.textTheme.bodyLarge?.copyWith(
          fontWeight: isUnread ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          Text(notification.body),
          const SizedBox(height: 4),
          Text(
            _formatDate(notification.createdAt),
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.outline,
            ),
          ),
        ],
      ),
      trailing: isUnread
          ? Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: theme.colorScheme.primary,
              ),
            )
          : null,
      onTap: onTap,
    );
  }

  IconData _iconForType(String type) {
    return switch (type.toLowerCase()) {
      'quest' => Icons.flag_outlined,
      'route' => Icons.route_outlined,
      'badge' => Icons.emoji_events_outlined,
      'system' => Icons.info_outline,
      _ => Icons.notifications_outlined,
    };
  }

  String _formatDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      final now = DateTime.now();
      final diff = now.difference(date);

      if (diff.inMinutes < 1) return 'notifications.just_now'.tr();
      if (diff.inHours < 1)
        return 'notifications.minutes_ago'.tr(
          namedArgs: {'count': diff.inMinutes.toString()},
        );
      if (diff.inDays < 1)
        return 'notifications.hours_ago'.tr(
          namedArgs: {'count': diff.inHours.toString()},
        );
      if (diff.inDays < 7)
        return 'notifications.days_ago'.tr(
          namedArgs: {'count': diff.inDays.toString()},
        );

      return DateFormat('dd.MM.yyyy').format(date);
    } catch (_) {
      return dateStr;
    }
  }
}
