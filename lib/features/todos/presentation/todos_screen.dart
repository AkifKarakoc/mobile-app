import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/app/theme/app_spacing.dart';
import 'package:mobile/app/theme/app_typography.dart';
import 'package:mobile/core/utils/dialog_helper.dart';
import 'package:mobile/core/widgets/animated_card.dart';
import 'package:mobile/core/widgets/app_button.dart';
import 'package:mobile/core/widgets/app_text_field.dart';
import 'package:mobile/core/widgets/empty_state.dart';
import 'package:mobile/core/widgets/error_view.dart';
import 'package:mobile/core/widgets/shimmer_placeholder.dart';
import 'package:mobile/core/widgets/tap_feedback.dart';
import 'package:mobile/features/todos/application/todos_provider.dart';
import 'package:mobile/features/todos/data/dto/todo_response.dart';
import 'package:mobile/features/todos/presentation/widgets/todo_tile.dart';

enum TodoFilter { all, active, completed }

class TodosScreen extends ConsumerStatefulWidget {
  const TodosScreen({super.key});

  @override
  ConsumerState<TodosScreen> createState() => _TodosScreenState();
}

class _TodosScreenState extends ConsumerState<TodosScreen> {
  TodoFilter _filter = TodoFilter.all;

  @override
  Widget build(BuildContext context) {
    final todosAsync = ref.watch(todosProvider);

    return Scaffold(
      appBar: AppBar(
        leading: Navigator.canPop(context)
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop(),
              )
            : null,
        title: Text('todos.title'.tr()),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddDialog(context),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildFilterChips(context),
          Expanded(
            child: todosAsync.when(
              loading: () => _buildShimmerList(),
              error: (error, _) => ErrorView(
                message: error.toString(),
                onRetry: () => ref.read(todosProvider.notifier).loadTodos(),
                retryLabel: 'common.retry'.tr(),
              ),
              data: (todos) => _buildContent(context, todos),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        children: [
          _FilterChip(
            label: 'todos.all'.tr(),
            selected: _filter == TodoFilter.all,
            onTap: () => setState(() => _filter = TodoFilter.all),
          ),
          const SizedBox(width: AppSpacing.xs),
          _FilterChip(
            label: 'todos.active'.tr(),
            selected: _filter == TodoFilter.active,
            onTap: () => setState(() => _filter = TodoFilter.active),
          ),
          const SizedBox(width: AppSpacing.xs),
          _FilterChip(
            label: 'todos.completed'.tr(),
            selected: _filter == TodoFilter.completed,
            onTap: () => setState(() => _filter = TodoFilter.completed),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context, List<TodoResponse> todos) {
    final filtered = _applyFilter(todos);

    if (filtered.isEmpty) {
      return EmptyState(
        icon: Icons.checklist_outlined,
        title: 'todos.empty_title'.tr(),
        description: 'todos.empty_description'.tr(),
        actionLabel: 'todos.add_todo'.tr(),
        onAction: () => _showAddDialog(context),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        final todo = filtered[index];
        return AnimatedCard(
          delayMs: index < 10 ? index * 50 : 0,
          child: TodoTile(
            todo: todo,
            onToggle: () =>
                ref.read(todosProvider.notifier).toggleComplete(todo.id),
            onDelete: () =>
                ref.read(todosProvider.notifier).deleteTodo(todo.id),
          ),
        );
      },
    );
  }

  Widget _buildShimmerList() {
    return ListView.separated(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      itemCount: 5,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, index) => const ListTileShimmer(),
    );
  }

  List<TodoResponse> _applyFilter(List<TodoResponse> todos) {
    return switch (_filter) {
      TodoFilter.all => todos,
      TodoFilter.active => todos.where((t) => !t.isCompleted).toList(),
      TodoFilter.completed => todos.where((t) => t.isCompleted).toList(),
    };
  }

  void _showAddDialog(BuildContext context) {
    final controller = TextEditingController();

    showAnimatedDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('todos.add_todo'.tr()),
        content: AppTextField(
          controller: controller,
          hint: 'todos.hint'.tr(),
          maxLines: 3,
        ),
        actions: [
          AppButton.text(
            label: 'todos.cancel'.tr(),
            onPressed: () => Navigator.of(ctx).pop(),
          ),
          AppButton.primary(
            label: 'todos.add'.tr(),
            onPressed: () {
              final note = controller.text.trim();
              if (note.isNotEmpty) {
                final notifier = ref.read(todosProvider.notifier);
                final messenger = ScaffoldMessenger.of(ctx);
                Navigator.of(ctx).pop();
                notifier.createTodo(note: note).catchError((_) {
                  messenger.showSnackBar(
                    SnackBar(content: Text('todos.error_add'.tr())),
                  );
                });
              }
            },
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return TapFeedback(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
        decoration: BoxDecoration(
          color: selected
              ? colorScheme.primaryContainer
              : colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          border: Border.all(
            color: selected
                ? colorScheme.primary.withValues(alpha: 0.3)
                : Colors.transparent,
          ),
        ),
        child: Text(
          label,
          style: AppTypography.labelMedium.copyWith(
            color: selected
                ? colorScheme.onPrimaryContainer
                : colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}
