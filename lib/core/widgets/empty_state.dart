import 'package:flutter/material.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../app/theme/app_typography.dart';

/// Empty state display widget
///
/// Shows an icon, title, optional description, and optional action button
/// when a list, grid, or section has no content.
class EmptyState extends StatelessWidget {
  /// Icon to display (IconData or custom Widget)
  final dynamic icon;

  /// Title text
  final String title;

  /// Optional description text below title
  final String? description;

  /// Optional action button label
  final String? actionLabel;

  /// Callback when action button is pressed
  final VoidCallback? onAction;

  /// Icon color
  final Color? iconColor;

  /// Icon size (only used if icon is IconData)
  final double iconSize;

  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    this.description,
    this.actionLabel,
    this.onAction,
    this.iconColor,
    this.iconSize = 80,
  });

  @override
  Widget build(BuildContext context) {
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
              // Icon
              if (icon is IconData)
                Icon(
                  icon as IconData,
                  size: iconSize,
                  color:
                      iconColor ?? Theme.of(context).colorScheme.outlineVariant,
                )
              else if (icon is Widget)
                SizedBox(
                  width: iconSize,
                  height: iconSize,
                  child: icon as Widget,
                ),
              const SizedBox(height: AppSpacing.lg),

              // Title
              Text(
                title,
                style: AppTypography.headlineMedium,
                textAlign: TextAlign.center,
              ),

              // Description
              if (description != null) ...[
                const SizedBox(height: AppSpacing.sm),
                Text(
                  description!,
                  style: AppTypography.bodyMedium.copyWith(
                    color: Theme.of(context).colorScheme.outlineVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],

              // Action button
              if (actionLabel != null && onAction != null) ...[
                const SizedBox(height: AppSpacing.lg),
                ElevatedButton(onPressed: onAction, child: Text(actionLabel!)),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
