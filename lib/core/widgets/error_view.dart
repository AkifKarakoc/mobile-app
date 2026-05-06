import 'package:flutter/material.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../app/theme/app_typography.dart';

/// Error state display widget
///
/// Shows an error icon, message, and optional retry button.
/// Used to display errors from API calls or async operations.
class ErrorView extends StatelessWidget {
  /// Error message to display
  final String message;

  /// Optional callback for retry action
  final VoidCallback? onRetry;

  /// Optional retry button label
  final String retryLabel;

  /// Custom error icon
  final IconData icon;

  /// Icon color
  final Color? iconColor;

  /// Icon size
  final double iconSize;

  const ErrorView({
    super.key,
    required this.message,
    this.onRetry,
    this.retryLabel = 'common.retry',
    this.icon = Icons.error_outline,
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
              // Error icon
              Icon(
                icon,
                size: iconSize,
                color: iconColor ?? Theme.of(context).colorScheme.error,
              ),
              const SizedBox(height: AppSpacing.lg),

              // Error message
              Text(
                message,
                style: AppTypography.bodyMedium,
                textAlign: TextAlign.center,
              ),

              // Retry button
              if (onRetry != null) ...[
                const SizedBox(height: AppSpacing.lg),
                ElevatedButton(onPressed: onRetry, child: Text(retryLabel)),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
