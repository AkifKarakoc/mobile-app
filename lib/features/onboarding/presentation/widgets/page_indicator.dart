import 'package:flutter/material.dart';
import 'package:mobile/app/theme/app_spacing.dart';

/// Page indicator widget — displays 3 dots representing current page
///
/// Active dot (current page) is colored with primary color;
/// inactive dots are gray.
class PageIndicator extends StatelessWidget {
  /// Total number of pages
  final int totalPages;

  /// Current page index (0-based)
  final int currentPage;

  /// Indicator color (active dot)
  final Color? activeColor;

  /// Inactive dot color
  final Color? inactiveColor;

  /// Dot size
  final double dotSize;

  /// Spacing between dots
  final double spacing;

  const PageIndicator({
    super.key,
    required this.totalPages,
    required this.currentPage,
    this.activeColor,
    this.inactiveColor,
    this.dotSize = 8,
    this.spacing = AppSpacing.md,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final active = activeColor ?? theme.colorScheme.primary;
    final inactive = inactiveColor ?? theme.colorScheme.outline;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalPages, (index) {
        final isActive = index == currentPage;
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: spacing / 2),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: dotSize,
            height: dotSize,
            decoration: BoxDecoration(
              color: isActive ? active : inactive,
              borderRadius: BorderRadius.circular(dotSize / 2),
            ),
          ),
        );
      }),
    );
  }
}
