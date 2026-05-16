import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/app/theme/app_spacing.dart';
import 'package:mobile/app/theme/app_typography.dart';
import 'package:mobile/core/utils/dialog_helper.dart';
import 'package:mobile/core/widgets/tap_feedback.dart';
import 'package:mobile/features/todos/data/dto/todo_response.dart';

class TodoTile extends StatelessWidget {
  final TodoResponse todo;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  const TodoTile({
    super.key,
    required this.todo,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Dismissible(
      key: Key(todo.id),
      direction: DismissDirection.horizontal,
      background: _DismissBackground(
        alignment: Alignment.centerLeft,
        icon: Icons.check_circle_outline,
        color: colorScheme.tertiary,
        label: 'todos.swipe_complete'.tr(),
      ),
      secondaryBackground: _DismissBackground(
        alignment: Alignment.centerRight,
        icon: Icons.delete_outline,
        color: colorScheme.error,
        label: 'todos.swipe_delete'.tr(),
      ),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          onToggle();
          return false;
        }
        return _confirmDelete(context);
      },
      onDismissed: (_) => onDelete(),
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs,
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.sm),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TapFeedback(
                onTap: onToggle,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.elasticOut,
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: todo.isCompleted
                        ? colorScheme.tertiaryContainer
                        : colorScheme.surfaceContainerHighest,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: todo.isCompleted
                          ? Colors.transparent
                          : colorScheme.outlineVariant,
                      width: 1.5,
                    ),
                  ),
                  child: todo.isCompleted
                      ? Icon(
                          Icons.check,
                          size: 18,
                          color: colorScheme.onTertiaryContainer,
                        )
                      : null,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      todo.note,
                      style: AppTypography.bodyMedium.copyWith(
                        decoration: todo.isCompleted
                            ? TextDecoration.lineThrough
                            : null,
                        color: todo.isCompleted
                            ? colorScheme.outlineVariant
                            : colorScheme.onSurface,
                      ),
                    ),
                    if (todo.placeId != null) ...[
                      const SizedBox(height: AppSpacing.xs),
                      TapFeedback(
                        onTap: () => context.push(
                          '/home/explore/place/${todo.placeId}',
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.xs,
                            vertical: AppSpacing.xs,
                          ),
                          decoration: BoxDecoration(
                            color: colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(
                              AppSpacing.radiusSm,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                size: 14,
                                color: colorScheme.onPrimaryContainer,
                              ),
                              const SizedBox(width: AppSpacing.xs),
                              Text(
                                'todos.place_link'.tr(),
                                style: AppTypography.labelSmall.copyWith(
                                  color: colorScheme.onPrimaryContainer,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.delete_outline,
                  color: colorScheme.outlineVariant,
                ),
                onPressed: () => _confirmDelete(context).then((confirmed) {
                  if (confirmed == true) onDelete();
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool?> _confirmDelete(BuildContext context) {
    return showAnimatedDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('todos.delete_confirm'.tr()),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text('common.cancel'.tr()),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text('todos.delete'.tr()),
          ),
        ],
      ),
    );
  }
}

class _DismissBackground extends StatelessWidget {
  const _DismissBackground({
    required this.alignment,
    required this.icon,
    required this.color,
    required this.label,
  });

  final Alignment alignment;
  final IconData icon;
  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: AppSpacing.sm),
          Text(
            label,
            style: AppTypography.labelMedium.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
