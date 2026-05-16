import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Animated card wrapper with fade-in, scale entrance animation,
/// press feedback, and optional hover effect.
///
/// Wraps any child widget with a staggered entrance animation.
/// Useful for home screen cards, list items, and grid tiles.
class AnimatedCard extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final int delayMs;
  final Duration animationDuration;
  final bool enableHover;
  final double pressScale;
  final double hoverScale;

  const AnimatedCard({
    super.key,
    required this.child,
    this.onTap,
    this.delayMs = 0,
    this.animationDuration = const Duration(milliseconds: 400),
    this.enableHover = false,
    this.pressScale = 0.96,
    this.hoverScale = 1.02,
  });

  @override
  State<AnimatedCard> createState() => _AnimatedCardState();
}

class _AnimatedCardState extends State<AnimatedCard>
    with TickerProviderStateMixin {
  late AnimationController _entranceController;
  late Animation<double> _entranceScaleAnimation;
  late Animation<double> _opacityAnimation;

  late AnimationController _pressController;
  late Animation<double> _pressAnimation;

  late AnimationController _hoverController;
  late Animation<double> _hoverAnimation;

  @override
  void initState() {
    super.initState();

    _entranceController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    _entranceScaleAnimation = CurvedAnimation(
      parent: _entranceController,
      curve: Curves.easeOutBack,
    );

    _opacityAnimation = CurvedAnimation(
      parent: _entranceController,
      curve: Curves.easeOutCubic,
    );

    _pressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );

    _pressAnimation = Tween<double>(begin: 1.0, end: widget.pressScale).animate(
      CurvedAnimation(parent: _pressController, curve: Curves.easeInOut),
    );

    _hoverController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _hoverAnimation = Tween<double>(begin: 1.0, end: widget.hoverScale).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.easeInOut),
    );

    Future.delayed(Duration(milliseconds: widget.delayMs), () {
      if (mounted) {
        _entranceController.forward();
      }
    });
  }

  @override
  void dispose() {
    _entranceController.stop();
    _entranceController.dispose();
    _pressController.stop();
    _pressController.dispose();
    _hoverController.stop();
    _hoverController.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails _) {
    _pressController.forward();
  }

  void _onTapUpOrCancel() {
    _pressController.reverse();
  }

  void _onEnter(PointerEnterEvent _) {
    if (widget.enableHover) {
      _hoverController.forward();
    }
  }

  void _onExit(PointerExitEvent _) {
    if (widget.enableHover) {
      _hoverController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        _entranceController,
        _pressController,
        _hoverController,
      ]),
      builder: (context, child) {
        final combinedScale =
            _entranceScaleAnimation.value *
            _pressAnimation.value *
            _hoverAnimation.value;

        return RepaintBoundary(
          child: Transform.scale(
            scale: combinedScale,
            child: Opacity(
              opacity: _opacityAnimation.value,
              child: _buildInteractiveChild(child),
            ),
          ),
        );
      },
      child: widget.child,
    );
  }

  Widget _buildInteractiveChild(Widget? child) {
    if (widget.onTap == null && !widget.enableHover) {
      return child!;
    }

    return MouseRegion(
      onEnter: _onEnter,
      onExit: _onExit,
      child: GestureDetector(
        onTapDown: widget.onTap != null ? _onTapDown : null,
        onTapUp: widget.onTap != null ? (_) => _onTapUpOrCancel() : null,
        onTapCancel: widget.onTap != null ? _onTapUpOrCancel : null,
        child: InkWell(
          onTap: widget.onTap,
          borderRadius: BorderRadius.circular(12),
          child: child,
        ),
      ),
    );
  }
}
