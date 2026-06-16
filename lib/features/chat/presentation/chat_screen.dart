import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/app/theme/app_spacing.dart';
import 'package:mobile/app/theme/app_typography.dart';
import 'package:mobile/core/network/api_exception.dart';
import 'package:mobile/core/utils/dialog_helper.dart';
import 'package:mobile/core/widgets/shimmer_placeholder.dart';
import 'package:mobile/features/chat/application/chat_messages_provider.dart';
import 'package:mobile/features/chat/data/dto/chat_response.dart';
import 'package:mobile/features/chat/presentation/widgets/message_bubble.dart';
import 'package:mobile/features/chat/presentation/widgets/typing_indicator.dart';

class ChatScreen extends ConsumerStatefulWidget {
  final String sessionId;

  const ChatScreen({required this.sessionId, super.key});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  Future<void> _sendMessage() async {
    final content = _controller.text.trim();
    if (content.isEmpty) return;

    _controller.clear();
    _scrollToBottom();

    try {
      await ref
          .read(chatMessagesProvider(widget.sessionId).notifier)
          .sendMessage(content);
    } catch (error) {
      if (!mounted) return;

      _controller.text = content;
      _controller.selection = TextSelection.fromPosition(
        TextPosition(offset: _controller.text.length),
      );

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(_messageForSendError(error))));
    }

    if (mounted) {
      _scrollToBottom();
    }
  }

  String _messageForSendError(Object error) {
    if (error is NetworkException) {
      return 'common.error_network'.tr();
    }
    return 'common.error_generic'.tr();
  }

  Future<void> _deleteSession() async {
    final confirmed = await showAnimatedDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('chat.delete_session'.tr()),
        content: Text('chat.delete_confirm'.tr()),
        actions: [
          TextButton(
            onPressed: () => context.pop(false),
            child: Text('common.cancel'.tr()),
          ),
          TextButton(
            onPressed: () => context.pop(true),
            child: Text('common.delete'.tr()),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      await ref
          .read(chatMessagesProvider(widget.sessionId).notifier)
          .deleteSession();
      if (mounted) {
        context.pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final messagesAsync = ref.watch(chatMessagesProvider(widget.sessionId));
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: Navigator.canPop(context)
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => context.pop(),
              )
            : null,
        title: Text('chat.title'.tr(), style: AppTypography.titleLarge),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: _deleteSession,
            tooltip: 'chat.delete_session'.tr(),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: messagesAsync.when(
              data: (messages) => _buildMessageList(messages),
              loading: () => _buildChatShimmer(),
              error: (error, _) => Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 48,
                      color: colorScheme.error,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Text('common.error_generic'.tr()),
                    const SizedBox(height: AppSpacing.md),
                    FilledButton.icon(
                      onPressed: () => ref.invalidate(
                        chatMessagesProvider(widget.sessionId),
                      ),
                      icon: const Icon(Icons.refresh, size: 18),
                      label: Text('common.retry'.tr()),
                    ),
                  ],
                ),
              ),
            ),
          ),
          _buildInputArea(),
        ],
      ),
    );
  }

  Widget _buildMessageList(List<ChatResponse> messages) {
    if (messages.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.chat_bubble_outline,
              size: 64,
              color: Theme.of(context).colorScheme.outlineVariant,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'chat.empty_title'.tr(),
              style: AppTypography.titleMedium.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'chat.empty_description'.tr(),
              style: AppTypography.bodySmall.copyWith(
                color: Theme.of(context).colorScheme.outlineVariant,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      controller: _scrollController,
      padding: const EdgeInsets.only(top: AppSpacing.sm, bottom: AppSpacing.xs),
      itemCount: messages.length,
      separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.xs),
      itemBuilder: (context, index) {
        final message = messages[index];
        if (message.role == ChatMessagesNotifier.typingRole) {
          return const TypingIndicator();
        }
        return MessageBubble(message: message, isUser: message.role == 'user');
      },
    );
  }

  Widget _buildChatShimmer() {
    return ListView.separated(
      padding: const EdgeInsets.only(top: AppSpacing.sm, bottom: AppSpacing.xs),
      itemCount: 5,
      separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.sm),
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.only(
          left: index % 2 == 0 ? AppSpacing.md : 60.0,
          right: index % 2 == 0 ? 60.0 : AppSpacing.md,
        ),
        child: ShimmerPlaceholder(
          height: 40 + (index % 3) * 15,
          borderRadius: AppSpacing.radiusMd,
        ),
      ),
    );
  }

  Widget _buildInputArea() {
    final messagesAsync = ref.watch(chatMessagesProvider(widget.sessionId));
    final isSending = messagesAsync.isLoading || _isWaitingForAssistant();
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        border: Border(
          top: BorderSide(
            color: colorScheme.outlineVariant.withValues(alpha: 0.5),
          ),
        ),
      ),
      child: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Container(
                constraints: const BoxConstraints(maxHeight: 120),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.xs,
                ),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
                ),
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: 'chat.type_message'.tr(),
                    hintStyle: AppTypography.bodyMedium.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                  maxLines: 4,
                  minLines: 1,
                  enabled: !isSending,
                  textInputAction: TextInputAction.send,
                  onSubmitted: (_) => _sendMessage(),
                  style: AppTypography.bodyMedium,
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            SizedBox(
              height: 48,
              width: 48,
              child: FilledButton(
                onPressed: _controller.text.trim().isNotEmpty && !isSending
                    ? _sendMessage
                    : null,
                style: FilledButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: EdgeInsets.zero,
                ),
                child: isSending
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.send, size: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _isWaitingForAssistant() {
    final messages = ref.watch(chatMessagesProvider(widget.sessionId)).value;
    return messages?.any(
          (message) => message.role == ChatMessagesNotifier.typingRole,
        ) ??
        false;
  }
}
