import 'package:flutter/material.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../app/theme/app_typography.dart';

class ErrorView extends StatefulWidget {
  final String message;
  final VoidCallback? onRetry;
  final String retryLabel;
  final IconData icon;
  final Duration animationDuration;

  const ErrorView({
    super.key,
    required this.message,
    this.onRetry,
    this.retryLabel = 'common.retry',
    this.icon = Icons.error_outline,
    this.animationDuration = const Duration(milliseconds: 400),
  });

  @override
  State<ErrorView> createState() => _ErrorViewState();
}

class _ErrorViewState extends State<ErrorView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.xl,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildIcon(colorScheme),
              const SizedBox(height: AppSpacing.lg),
              _buildMessage(colorScheme),
              if (widget.onRetry != null) ...[
                const SizedBox(height: AppSpacing.lg),
                _buildRetryButton(),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(ColorScheme colorScheme) {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Icon(widget.icon, size: 80, color: colorScheme.error),
      ),
    );
  }

  Widget _buildMessage(ColorScheme colorScheme) {
    return Text(
      widget.message,
      style: AppTypography.bodyLarge.copyWith(color: colorScheme.onSurface),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildRetryButton() {
    return FilledButton.tonal(
      onPressed: widget.onRetry,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.refresh, size: 18),
          const SizedBox(width: AppSpacing.xs),
          Text(widget.retryLabel),
        ],
      ),
    );
  }
}
