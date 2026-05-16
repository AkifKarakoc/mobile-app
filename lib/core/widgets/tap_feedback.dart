import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Lightweight reusable wrapper that adds tap scale feedback to any child.
///
/// Simpler than AnimatedCard — no entrance animation, just press feedback
/// with optional haptic feedback and material splash.
class TapFeedback extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final double pressedScale;
  final Duration duration;
  final double borderRadius;
  final bool enableHaptic;

  const TapFeedback({
    super.key,
    required this.child,
    this.onTap,
    this.pressedScale = 0.96,
    this.duration = const Duration(milliseconds: 100),
    this.borderRadius = 12.0,
    this.enableHaptic = true,
  });

  @override
  State<TapFeedback> createState() => _TapFeedbackState();
}

class _TapFeedbackState extends State<TapFeedback>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: widget.pressedScale,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails _) {
    if (widget.enableHaptic) {
      HapticFeedback.lightImpact();
    }
    _controller.forward();
  }

  void _onTapUpOrCancel() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return RepaintBoundary(
          child: Transform.scale(scale: _scaleAnimation.value, child: child),
        );
      },
      child: GestureDetector(
        onTapDown: widget.onTap != null ? _onTapDown : null,
        onTapUp: widget.onTap != null ? (_) => _onTapUpOrCancel() : null,
        onTapCancel: widget.onTap != null ? _onTapUpOrCancel : null,
        child: InkWell(
          onTap: widget.onTap,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          child: widget.child,
        ),
      ),
    );
  }
}
