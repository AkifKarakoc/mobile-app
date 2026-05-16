import 'package:flutter/material.dart';
import '../../../app/theme/app_spacing.dart';

/// Shape variants for [ShimmerPlaceholder].
enum ShimmerShape { rect, circle, roundedRect, textLine, avatar, card, image }

/// Shimmer loading placeholder widget.
///
/// Displays a sweeping linear gradient shimmer effect to indicate loading state.
/// Supports multiple shape variants via [ShimmerShape].
class ShimmerPlaceholder extends StatefulWidget {
  final double height;
  final double? width;
  final double borderRadius;
  final ShimmerShape shape;
  final Duration? delay;

  const ShimmerPlaceholder({
    super.key,
    required this.height,
    this.width,
    this.borderRadius = AppSpacing.radiusMd,
    this.shape = ShimmerShape.rect,
    this.delay,
  });

  @override
  State<ShimmerPlaceholder> createState() => _ShimmerPlaceholderState();
}

class _ShimmerPlaceholderState extends State<ShimmerPlaceholder>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    if (widget.delay != null) {
      _controller.forward().then((_) {
        _controller.repeat();
      });
    } else {
      _controller.repeat();
    }

    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  ShapeBorder _getShape() {
    switch (widget.shape) {
      case ShimmerShape.circle:
      case ShimmerShape.avatar:
        return const CircleBorder();
      case ShimmerShape.rect:
      case ShimmerShape.roundedRect:
      case ShimmerShape.textLine:
      case ShimmerShape.card:
      case ShimmerShape.image:
        return RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
        );
    }
  }

  double _effectiveHeight() {
    switch (widget.shape) {
      case ShimmerShape.avatar:
        return 60;
      case ShimmerShape.card:
        return 120;
      case ShimmerShape.image:
        return 200;
      case ShimmerShape.textLine:
        return 14;
      case ShimmerShape.rect:
      case ShimmerShape.circle:
      case ShimmerShape.roundedRect:
        return widget.height;
    }
  }

  double? _effectiveWidth() {
    switch (widget.shape) {
      case ShimmerShape.avatar:
        return 60;
      case ShimmerShape.textLine:
        return widget.width ?? double.infinity;
      default:
        return widget.width;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final baseColor = theme.colorScheme.surfaceContainerHighest;
    final highlightColor = theme.brightness == Brightness.dark
        ? theme.colorScheme.surfaceContainerLowest
        : theme.colorScheme.surfaceContainerLow;

    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final sweepStart = _animation.value * 2 - 1;
          final sweepEnd = sweepStart + 1;

          return Container(
            height: _effectiveHeight(),
            width: _effectiveWidth(),
            decoration: ShapeDecoration(
              shape: _getShape(),
              gradient: LinearGradient(
                begin: Alignment(sweepStart, 0),
                end: Alignment(sweepEnd, 0),
                colors: [baseColor, highlightColor, baseColor],
                stops: const [0.0, 0.5, 1.0],
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Single place card shimmer: image area + title line + subtitle line.
class PlaceCardShimmer extends StatelessWidget {
  const PlaceCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ShimmerPlaceholder(
          height: 160,
          width: double.infinity,
          shape: ShimmerShape.roundedRect,
          borderRadius: AppSpacing.radiusLg,
        ),
        const SizedBox(height: AppSpacing.sm),
        const ShimmerPlaceholder(
          height: 16,
          width: double.infinity,
          shape: ShimmerShape.textLine,
        ),
        const SizedBox(height: AppSpacing.xs),
        const ShimmerPlaceholder(
          height: 12,
          width: 120,
          shape: ShimmerShape.textLine,
        ),
      ],
    );
  }
}

/// List tile shimmer: avatar + 2 text lines.
class ListTileShimmer extends StatelessWidget {
  const ListTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const ShimmerPlaceholder(
          height: 40,
          width: 40,
          shape: ShimmerShape.circle,
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ShimmerPlaceholder(
                height: 16,
                width: double.infinity,
                shape: ShimmerShape.textLine,
              ),
              const SizedBox(height: AppSpacing.xs),
              const ShimmerPlaceholder(
                height: 12,
                width: 140,
                shape: ShimmerShape.textLine,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Place detail page shimmer: large image + title + description + tabs.
class DetailShimmer extends StatelessWidget {
  const DetailShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ShimmerPlaceholder(
            height: 250,
            width: double.infinity,
            shape: ShimmerShape.image,
          ),
          const SizedBox(height: AppSpacing.md),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ShimmerPlaceholder(
                  height: 24,
                  width: 200,
                  shape: ShimmerShape.textLine,
                ),
                const SizedBox(height: AppSpacing.sm),
                const ShimmerPlaceholder(
                  height: 14,
                  width: double.infinity,
                  shape: ShimmerShape.textLine,
                ),
                const SizedBox(height: AppSpacing.xs),
                const ShimmerPlaceholder(
                  height: 14,
                  width: double.infinity,
                  shape: ShimmerShape.textLine,
                ),
                const SizedBox(height: AppSpacing.xs),
                const ShimmerPlaceholder(
                  height: 14,
                  width: 180,
                  shape: ShimmerShape.textLine,
                ),
                const SizedBox(height: AppSpacing.lg),
                _buildTabBarShimmer(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBarShimmer() {
    return SizedBox(
      height: 40,
      child: Row(
        children: List.generate(
          4,
          (i) => Padding(
            padding: EdgeInsets.only(right: i < 3 ? AppSpacing.sm : 0),
            child: const ShimmerPlaceholder(
              height: 36,
              width: 80,
              shape: ShimmerShape.roundedRect,
              borderRadius: AppSpacing.radiusLg,
            ),
          ),
        ),
      ),
    );
  }
}

/// Pre-built shimmer layout for home screen.
class HomeShimmer extends StatelessWidget {
  const HomeShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeroHeader(),
          const SizedBox(height: AppSpacing.lg),
          _buildGridCards(),
          const SizedBox(height: AppSpacing.lg),
          _buildFullWidthCards(),
        ],
      ),
    );
  }

  Widget _buildHeroHeader() {
    return Stack(
      children: [
        const ShimmerPlaceholder(
          height: 140,
          width: double.infinity,
          shape: ShimmerShape.roundedRect,
          borderRadius: AppSpacing.radiusLg,
        ),
        Positioned(
          left: AppSpacing.md,
          bottom: AppSpacing.md,
          child: Row(
            children: [
              const ShimmerPlaceholder(
                height: 40,
                width: 40,
                shape: ShimmerShape.circle,
              ),
              const SizedBox(width: AppSpacing.sm),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ShimmerPlaceholder(
                    height: 18,
                    width: 140,
                    shape: ShimmerShape.textLine,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  const ShimmerPlaceholder(
                    height: 12,
                    width: 100,
                    shape: ShimmerShape.textLine,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGridCards() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _buildGridCard()),
        const SizedBox(width: AppSpacing.sm),
        Expanded(child: _buildGridCard()),
      ],
    );
  }

  Widget _buildGridCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ShimmerPlaceholder(
          height: 100,
          width: double.infinity,
          shape: ShimmerShape.roundedRect,
          borderRadius: AppSpacing.radiusMd,
        ),
        const SizedBox(height: AppSpacing.sm),
        const ShimmerPlaceholder(
          height: 14,
          width: double.infinity,
          shape: ShimmerShape.textLine,
        ),
        const SizedBox(height: AppSpacing.xs),
        const ShimmerPlaceholder(
          height: 12,
          width: 80,
          shape: ShimmerShape.textLine,
        ),
      ],
    );
  }

  Widget _buildFullWidthCards() {
    return Column(
      children: List.generate(
        3,
        (i) => Padding(
          padding: EdgeInsets.only(bottom: i < 2 ? AppSpacing.sm : 0),
          child: Row(
            children: [
              const ShimmerPlaceholder(
                height: 56,
                width: 56,
                shape: ShimmerShape.roundedRect,
                borderRadius: AppSpacing.radiusMd,
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ShimmerPlaceholder(
                      height: 14,
                      width: double.infinity,
                      shape: ShimmerShape.textLine,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    const ShimmerPlaceholder(
                      height: 12,
                      width: 120,
                      shape: ShimmerShape.textLine,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
