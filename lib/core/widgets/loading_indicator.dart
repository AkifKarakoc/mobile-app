import 'package:flutter/material.dart';

/// Reusable loading indicator widget
///
/// Displays a centered circular progress indicator. Supports custom colors and sizes.
class AppLoadingIndicator extends StatelessWidget {
  /// Indicator size (width/height)
  final double size;

  /// Stroke width
  final double strokeWidth;

  /// Custom indicator color
  final Color? color;

  /// Background color for the circular track
  final Color? backgroundColor;

  /// Semantic label for accessibility
  final String? semanticsLabel;

  /// Semantic value for accessibility
  final String? semanticsValue;

  const AppLoadingIndicator({
    super.key,
    this.size = 48,
    this.strokeWidth = 4,
    this.color,
    this.backgroundColor,
    this.semanticsLabel,
    this.semanticsValue,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          strokeWidth: strokeWidth,
          valueColor: AlwaysStoppedAnimation<Color>(
            color ?? Theme.of(context).colorScheme.primary,
          ),
          backgroundColor: backgroundColor,
          semanticsLabel: semanticsLabel,
          semanticsValue: semanticsValue,
        ),
      ),
    );
  }
}
