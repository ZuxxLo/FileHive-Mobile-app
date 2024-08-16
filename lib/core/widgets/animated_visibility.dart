import 'package:flutter/material.dart';

//      isVisible: _controller.status == AnimationStatus.completed,

class AnimatedVisibility extends StatelessWidget {
  const AnimatedVisibility(
      {super.key, required this.child, required this.isVisible});

  final Widget child;
  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
      curve: Curves.easeInOut,
      offset: isVisible ? Offset.zero : const Offset(0, 1),
      duration: const Duration(milliseconds: 200),
      child: AnimatedOpacity(
        // If the widget is visible, animate to 0.0 (invisible).
        // If the widget is hidden, animate to 1.0 (fully visible).
        opacity: isVisible ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 200),
        // The green box must be a child of the AnimatedOpacity widget.
        child: child,
      ),
    );
  }
}
