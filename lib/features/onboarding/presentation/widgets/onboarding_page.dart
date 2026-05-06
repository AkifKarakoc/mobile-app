import 'package:flutter/material.dart';
import 'package:mobile/app/theme/app_spacing.dart';
import 'package:mobile/app/theme/app_typography.dart';

/// Reusable onboarding page widget
///
/// Displays a single onboarding screen with icon, title, and description
class OnboardingPage extends StatelessWidget {
  /// Material icon to display (e.g., Icons.travel_explore)
  final IconData icon;

  /// Page title (localized string)
  final String title;

  /// Page description (localized string)
  final String description;

  /// Icon color (defaults to primary color)
  final Color? iconColor;

  /// Icon size (defaults to 80)
  final double iconSize;

  const OnboardingPage({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    this.iconColor,
    this.iconSize = 80,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.xxl,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon
          Container(
            width: iconSize + AppSpacing.lg,
            height: iconSize + AppSpacing.lg,
            decoration: BoxDecoration(
              color: (iconColor ?? theme.colorScheme.primary).withValues(
                alpha: 0.1,
              ),
              borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
            ),
            child: Center(
              child: Icon(
                icon,
                size: iconSize,
                color: iconColor ?? theme.colorScheme.primary,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),

          // Title
          Text(
            title,
            textAlign: TextAlign.center,
            style: AppTypography.headlineMedium.copyWith(
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: AppSpacing.md),

          // Description
          Text(
            description,
            textAlign: TextAlign.center,
            style: AppTypography.bodyLarge.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
