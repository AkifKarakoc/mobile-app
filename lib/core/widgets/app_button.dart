import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../app/theme/app_typography.dart';

/// Button variant enum
enum AppButtonVariant {
  /// Primary filled button (turkuaz background)
  primary,

  /// Secondary outlined button (border with secondary color)
  secondary,

  /// Text-only button (no background)
  text,
}

/// Reusable application button widget
///
/// Supports three variants (primary/secondary/text), loading state, optional icon,
/// tap feedback animation, and disabled state. Complies with AppTheme spacing and typography.
class AppButton extends StatefulWidget {
  /// Button variant style
  final AppButtonVariant variant;

  /// Button label text
  final String label;

  /// Callback when button is pressed (null = disabled)
  final VoidCallback? onPressed;

  /// Loading state indicator
  final bool isLoading;

  /// Optional icon to display (left-aligned)
  final IconData? icon;

  /// Icon size (only used if icon is provided)
  final double iconSize;

  /// Button child (if provided, overrides label)
  final Widget? child;

  /// Padding inside button
  final EdgeInsets? padding;

  /// Custom background color (overrides variant)
  final Color? backgroundColor;

  /// Custom text color (overrides variant)
  final Color? textColor;

  /// Full width or not
  final bool fullWidth;

  /// Minimum size for the button
  final Size? minimumSize;

  /// Enable haptic feedback on tap
  final bool enableHaptic;

  const AppButton({
    super.key,
    required this.label,
    this.variant = AppButtonVariant.primary,
    this.onPressed,
    this.isLoading = false,
    this.icon,
    this.iconSize = AppSpacing.iconMedium,
    this.child,
    this.padding,
    this.backgroundColor,
    this.textColor,
    this.fullWidth = false,
    this.minimumSize,
    this.enableHaptic = true,
  });

  /// Primary button convenience constructor
  const AppButton.primary({
    Key? key,
    required String label,
    VoidCallback? onPressed,
    bool isLoading = false,
    IconData? icon,
    double iconSize = AppSpacing.iconMedium,
    bool fullWidth = false,
    bool enableHaptic = true,
  }) : this(
          key: key,
          label: label,
          variant: AppButtonVariant.primary,
          onPressed: onPressed,
          isLoading: isLoading,
          icon: icon,
          iconSize: iconSize,
          fullWidth: fullWidth,
          enableHaptic: enableHaptic,
        );

  /// Secondary button convenience constructor
  const AppButton.secondary({
    Key? key,
    required String label,
    VoidCallback? onPressed,
    bool isLoading = false,
    IconData? icon,
    double iconSize = AppSpacing.iconMedium,
    bool fullWidth = false,
    bool enableHaptic = true,
  }) : this(
          key: key,
          label: label,
          variant: AppButtonVariant.secondary,
          onPressed: onPressed,
          isLoading: isLoading,
          icon: icon,
          iconSize: iconSize,
          fullWidth: fullWidth,
          enableHaptic: enableHaptic,
        );

  /// Text button convenience constructor
  const AppButton.text({
    Key? key,
    required String label,
    VoidCallback? onPressed,
    IconData? icon,
    double iconSize = AppSpacing.iconMedium,
    Color? textColor,
    bool enableHaptic = true,
  }) : this(
          key: key,
          label: label,
          variant: AppButtonVariant.text,
          onPressed: onPressed,
          icon: icon,
          iconSize: iconSize,
          textColor: textColor,
          enableHaptic: enableHaptic,
        );

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _pressController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _pressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.96).animate(
      CurvedAnimation(parent: _pressController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEnabled = widget.onPressed != null && !widget.isLoading;

    return GestureDetector(
      onTapDown: isEnabled ? (_) => _onTapDown() : null,
      onTapUp: isEnabled ? (_) => _pressController.reverse() : null,
      onTapCancel: isEnabled ? () => _pressController.reverse() : null,
      behavior: HitTestBehavior.opaque,
      child: RepaintBoundary(
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: isEnabled ? _scaleAnimation.value : 1.0,
              child: child,
            );
          },
          child: _buildButton(context),
        ),
      ),
    );
  }

  void _onTapDown() {
    _pressController.forward();
    if (widget.enableHaptic) {
      HapticFeedback.lightImpact();
    }
  }

  Widget _buildButton(BuildContext context) {
    final theme = Theme.of(context);
    final isDisabled = widget.onPressed == null || widget.isLoading;

    final (bgColor, fgColor) = _getColors(theme);
    final buttonChild = _buildContent(theme);

    switch (widget.variant) {
      case AppButtonVariant.primary:
        return ElevatedButton(
          onPressed: isDisabled ? null : widget.onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: widget.backgroundColor ?? bgColor,
            foregroundColor: widget.textColor ?? fgColor,
            disabledBackgroundColor: bgColor.withValues(alpha: 0.38),
            disabledForegroundColor: fgColor.withValues(alpha: 0.38),
            elevation: isDisabled ? AppSpacing.elevationNone : null,
            padding:
                widget.padding ??
                const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.md,
                ),
            minimumSize:
                widget.minimumSize ??
                (widget.fullWidth ? const Size(double.infinity, 48) : null),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            ),
          ),
          child: buttonChild,
        );

      case AppButtonVariant.secondary:
        return OutlinedButton(
          onPressed: isDisabled ? null : widget.onPressed,
          style: OutlinedButton.styleFrom(
            foregroundColor: widget.textColor ?? bgColor,
            disabledForegroundColor: bgColor.withValues(alpha: 0.38),
            side: BorderSide(color: bgColor, width: isDisabled ? 1.0 : 1.5),
            elevation: isDisabled ? AppSpacing.elevationNone : null,
            padding:
                widget.padding ??
                const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.md,
                ),
            minimumSize:
                widget.minimumSize ??
                (widget.fullWidth ? const Size(double.infinity, 48) : null),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            ),
          ),
          child: buttonChild,
        );

      case AppButtonVariant.text:
        return TextButton(
          onPressed: isDisabled ? null : widget.onPressed,
          style: TextButton.styleFrom(
            foregroundColor: widget.textColor ?? bgColor,
            disabledForegroundColor: bgColor.withValues(alpha: 0.38),
            padding:
                widget.padding ??
                const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
            minimumSize:
                widget.minimumSize ??
                (widget.fullWidth ? const Size(double.infinity, 48) : null),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            ),
          ),
          child: buttonChild,
        );
    }
  }

  Widget _buildContent(ThemeData theme) {
    if (widget.child != null) return widget.child!;

    final isPrimary = widget.variant == AppButtonVariant.primary;
    final spinnerColor = isPrimary ? Colors.white : theme.colorScheme.primary;
    final textColor =
        widget.textColor ??
        (isPrimary ? Colors.white : theme.colorScheme.primary);

    Widget content;

    if (widget.isLoading) {
      content = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 16,
            width: 16,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(spinnerColor),
            ),
          ),
          if (widget.label.isNotEmpty) ...[
            const SizedBox(width: AppSpacing.sm),
            Text(
              widget.label,
              style: AppTypography.labelLarge.copyWith(color: textColor),
            ),
          ],
        ],
      );
    } else if (widget.icon != null) {
      content = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(widget.icon, size: widget.iconSize),
          const SizedBox(width: AppSpacing.sm),
          Flexible(
            child: Text(
              widget.label,
              style: AppTypography.labelLarge,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      );
    } else {
      content = Text(widget.label, style: AppTypography.labelLarge);
    }

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      child: content,
    );
  }

  (Color, Color) _getColors(ThemeData theme) {
    return switch (widget.variant) {
      AppButtonVariant.primary => (theme.colorScheme.primary, Colors.white),
      AppButtonVariant.secondary => (
        theme.colorScheme.secondary,
        theme.colorScheme.secondary,
      ),
      AppButtonVariant.text => (
        theme.colorScheme.primary,
        theme.colorScheme.primary,
      ),
    };
  }
}
