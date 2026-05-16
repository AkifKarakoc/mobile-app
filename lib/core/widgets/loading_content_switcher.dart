import 'package:flutter/material.dart';

enum LoadingContentTransition { fade, slideUp, scale }

class LoadingContentSwitcher extends StatelessWidget {
  final Widget loadingWidget;
  final Widget content;
  final bool isLoading;
  final Duration duration;
  final LoadingContentTransition transition;

  const LoadingContentSwitcher({
    super.key,
    required this.loadingWidget,
    required this.content,
    required this.isLoading,
    this.duration = const Duration(milliseconds: 400),
    this.transition = LoadingContentTransition.fade,
  });

  Widget _buildTransition(Widget child) {
    return switch (transition) {
      LoadingContentTransition.fade => child,
      LoadingContentTransition.slideUp => _slideUpBuilder(child),
      LoadingContentTransition.scale => _scaleBuilder(child),
    };
  }

  Widget _slideUpBuilder(Widget child) {
    return AnimatedSwitcher(
      duration: duration,
      reverseDuration: duration,
      transitionBuilder: (child, animation) {
        final slide = Tween<Offset>(
          begin: const Offset(0, 0.1),
          end: Offset.zero,
        ).animate(CurvedAnimation(parent: animation, curve: Curves.easeInOut));
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(position: slide, child: child),
        );
      },
      child: child,
    );
  }

  Widget _scaleBuilder(Widget child) {
    return AnimatedSwitcher(
      duration: duration,
      reverseDuration: duration,
      transitionBuilder: (child, animation) {
        final scale = Tween<double>(
          begin: 0.95,
          end: 1.0,
        ).animate(CurvedAnimation(parent: animation, curve: Curves.easeInOut));
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(scale: scale, child: child),
        );
      },
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTransition(
      KeyedSubtree(
        key: ValueKey(isLoading),
        child: isLoading ? loadingWidget : content,
      ),
    );
  }
}
