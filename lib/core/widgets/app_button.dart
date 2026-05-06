import 'package:flutter/material.dart';
import '../../../app/theme/app_colors.dart';
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
/// and disabled state. Complies with AppTheme spacing and typography.
class AppButton extends StatelessWidget {
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
  }) : this(
         key: key,
         label: label,
         variant: AppButtonVariant.primary,
         onPressed: onPressed,
         isLoading: isLoading,
         icon: icon,
         iconSize: iconSize,
         fullWidth: fullWidth,
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
  }) : this(
         key: key,
         label: label,
         variant: AppButtonVariant.secondary,
         onPressed: onPressed,
         isLoading: isLoading,
         icon: icon,
         iconSize: iconSize,
         fullWidth: fullWidth,
       );

  /// Text button convenience constructor
  const AppButton.text({
    Key? key,
    required String label,
    VoidCallback? onPressed,
    IconData? icon,
    double iconSize = AppSpacing.iconMedium,
    Color? textColor,
  }) : this(
         key: key,
         label: label,
         variant: AppButtonVariant.text,
         onPressed: onPressed,
         icon: icon,
         iconSize: iconSize,
         textColor: textColor,
       );

  @override
  Widget build(BuildContext context) {
    return _buildButton(context);
  }

  Widget _buildButton(BuildContext context) {
    final theme = Theme.of(context);
    final isDisabled = onPressed == null || isLoading;

    // Determine colors based on variant
    final (bgColor, fgColor) = _getColors(theme);

    // Build button content
    final buttonChild = _buildButtonContent();

    // Handle different button types
    switch (variant) {
      case AppButtonVariant.primary:
        return ElevatedButton(
          onPressed: isDisabled ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor ?? bgColor,
            foregroundColor: textColor ?? fgColor,
            disabledBackgroundColor: bgColor.withValues(alpha: 0.38),
            disabledForegroundColor: fgColor.withValues(alpha: 0.38),
            padding:
                padding ??
                const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.md,
                ),
            minimumSize:
                minimumSize ??
                (fullWidth ? const Size(double.infinity, 48) : null),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            ),
          ),
          child: buttonChild,
        );

      case AppButtonVariant.secondary:
        return OutlinedButton(
          onPressed: isDisabled ? null : onPressed,
          style: OutlinedButton.styleFrom(
            foregroundColor: textColor ?? bgColor,
            disabledForegroundColor: bgColor.withValues(alpha: 0.38),
            side: BorderSide(color: bgColor, width: 1.5),
            padding:
                padding ??
                const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.md,
                ),
            minimumSize:
                minimumSize ??
                (fullWidth ? const Size(double.infinity, 48) : null),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            ),
          ),
          child: buttonChild,
        );

      case AppButtonVariant.text:
        return TextButton(
          onPressed: isDisabled ? null : onPressed,
          style: TextButton.styleFrom(
            foregroundColor: textColor ?? bgColor,
            disabledForegroundColor: bgColor.withValues(alpha: 0.38),
            padding:
                padding ??
                const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
            minimumSize:
                minimumSize ??
                (fullWidth ? const Size(double.infinity, 48) : null),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            ),
          ),
          child: buttonChild,
        );
    }
  }

  Widget _buildButtonContent() {
    if (child != null) return child!;

    if (isLoading) {
      final spinnerColor = variant == AppButtonVariant.primary
          ? Colors.white
          : AppColors.primaryLight;

      return SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(spinnerColor),
        ),
      );
    }

    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: iconSize),
          const SizedBox(width: AppSpacing.sm),
          Flexible(
            child: Text(
              label,
              style: AppTypography.labelLarge,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      );
    }

    return Text(label, style: AppTypography.labelLarge);
  }

  (Color, Color) _getColors(ThemeData theme) {
    return switch (variant) {
      AppButtonVariant.primary => (theme.colorScheme.primary, Colors.white),
      AppButtonVariant.secondary => (theme.colorScheme.secondary, Colors.white),
      AppButtonVariant.text => (
        theme.colorScheme.primary,
        theme.colorScheme.primary,
      ),
    };
  }
}
