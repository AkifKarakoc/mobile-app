import 'package:flutter/material.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../app/theme/app_typography.dart';

class EmptyState extends StatefulWidget {
  final Widget? illustration;
  final IconData? icon;
  final String title;
  final String? description;
  final String? actionLabel;
  final VoidCallback? onAction;
  final Duration animationDuration;

  const EmptyState({
    super.key,
    this.illustration,
    this.icon,
    required this.title,
    this.description,
    this.actionLabel,
    this.onAction,
    this.animationDuration = const Duration(milliseconds: 400),
  });

  @override
  State<EmptyState> createState() => _EmptyStateState();
}

class _EmptyStateState extends State<EmptyState>
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

    return Semantics(
      label: widget.title,
      child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.xl,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildVisual(colorScheme),
                const SizedBox(height: AppSpacing.lg),
                _buildTitle(colorScheme),
                if (widget.description != null) ...[
                  const SizedBox(height: AppSpacing.sm),
                  _buildDescription(colorScheme),
                ],
                if (widget.actionLabel != null && widget.onAction != null) ...[
                  const SizedBox(height: AppSpacing.lg),
                  _buildActionButton(),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildVisual(ColorScheme colorScheme) {
    final iconWidget = widget.icon != null
        ? Icon(
            widget.icon,
            size: widget.illustration != null ? 48 : 80,
            color: colorScheme.outlineVariant,
          )
        : null;

    final visual = widget.illustration ?? iconWidget;

    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(opacity: _fadeAnimation, child: visual),
    );
  }

  Widget _buildTitle(ColorScheme colorScheme) {
    return Text(
      widget.title,
      style: AppTypography.headlineSmall.copyWith(color: colorScheme.onSurface),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildDescription(ColorScheme colorScheme) {
    return Text(
      widget.description!,
      style: AppTypography.bodyMedium.copyWith(color: colorScheme.outline),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildActionButton() {
    return FilledButton.tonal(
      onPressed: widget.onAction,
      child: Text(widget.actionLabel!),
    );
  }
}
