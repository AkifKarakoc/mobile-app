import 'package:flutter/material.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../app/theme/app_typography.dart';

/// Reusable text input field widget
///
/// Wraps Material 3 TextFormField with consistent theming. Supports labels, hints,
/// prefix/suffix icons, validation, and various input types.
class AppTextField extends StatelessWidget {
  /// Input field label text
  final String? label;

  /// Placeholder hint text
  final String? hint;

  /// Icon displayed before the input
  final IconData? prefixIcon;

  /// Icon displayed after the input
  final IconData? suffixIcon;

  /// Suffix widget (more flexible than suffixIcon)
  final Widget? suffix;

  /// Text controller
  final TextEditingController? controller;

  /// Form field validator
  final String? Function(String?)? validator;

  /// Keyboard type
  final TextInputType keyboardType;

  /// Input is password/obscured
  final bool obscureText;

  /// Callback on text changed
  final Function(String)? onChanged;

  /// Callback on focus lost
  final Function(String)? onSubmitted;

  /// Optional error message to display
  final String? errorText;

  /// Field is read-only
  final bool readOnly;

  /// Maximum characters allowed
  final int? maxLength;

  /// Maximum lines (null = unlimited for TextField, 1 by default)
  final int? maxLines;

  /// Minimum lines
  final int minLines;

  /// Custom input decoration
  final InputDecoration? decoration;

  /// Enabled state
  final bool enabled;

  /// Focus node
  final FocusNode? focusNode;

  /// Text input action
  final TextInputAction? textInputAction;

  const AppTextField({
    super.key,
    this.label,
    this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.suffix,
    this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.onChanged,
    this.onSubmitted,
    this.errorText,
    this.readOnly = false,
    this.maxLength,
    this.maxLines = 1,
    this.minLines = 1,
    this.decoration,
    this.enabled = true,
    this.focusNode,
    this.textInputAction,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      obscureText: obscureText,
      readOnly: readOnly,
      enabled: enabled,
      maxLength: maxLength,
      maxLines: obscureText ? 1 : maxLines,
      minLines: minLines,
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
      validator: validator,
      decoration:
          decoration ??
          InputDecoration(
            labelText: label,
            hintText: hint,
            prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
            suffixIcon: suffixIcon != null ? Icon(suffixIcon) : suffix,
            errorText: errorText,
            counterText: '',
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.md,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.outline,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.error,
                width: 2,
              ),
            ),
            labelStyle: AppTypography.labelMedium,
            hintStyle: AppTypography.bodyMedium.copyWith(
              color: Theme.of(context).colorScheme.outlineVariant,
            ),
          ),
    );
  }
}
