import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/app/theme/app_spacing.dart';
import 'package:mobile/core/widgets/app_button.dart';
import 'package:mobile/core/widgets/app_text_field.dart';
import 'package:mobile/features/chat/application/chat_messages_provider.dart';
import 'package:mobile/features/chat/data/dto/chat_response.dart';
import 'package:mobile/features/chat/presentation/widgets/message_bubble.dart';

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

    await ref
        .read(chatMessagesProvider(widget.sessionId).notifier)
        .sendMessage(content);

    if (mounted) {
      _scrollToBottom();
    }
  }

  Future<void> _deleteSession() async {
    final confirmed = await showDialog<bool>(
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

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: Navigator.canPop(context)
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => context.pop(),
              )
            : null,
        title: Text('chat.title'.tr()),
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
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('common.error_generic'.tr()),
                    const SizedBox(height: AppSpacing.md),
                    AppButton.text(
                      label: 'common.retry'.tr(),
                      onPressed: () =>
                          ref.invalidate(chatMessagesProvider(widget.sessionId)),
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
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.only(top: AppSpacing.sm, bottom: AppSpacing.xs),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index];
        return MessageBubble(
          message: message,
          isUser: message.role == 'user',
        );
      },
    );
  }

  Widget _buildInputArea() {
    final messagesAsync = ref.watch(chatMessagesProvider(widget.sessionId));
    final isSending = messagesAsync.isLoading;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: AppTextField(
                controller: _controller,
                hint: 'chat.type_message'.tr(),
                maxLines: 4,
                minLines: 1,
                enabled: !isSending,
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => _sendMessage(),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            SizedBox(
              height: 48,
              child: AppButton.primary(
                label: '',
                icon: Icons.send,
                onPressed:
                    _controller.text.trim().isNotEmpty && !isSending
                        ? _sendMessage
                        : null,
                isLoading: isSending,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
