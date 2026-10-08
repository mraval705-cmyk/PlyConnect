import 'package:flutter/material.dart';
import '../../resources/color_resources.dart';

/// A small dot that keeps growing and shrinking, so the screen looks alive.
///
/// AnimationController moves the value from 0 to 1, Tween decides what 0 and
/// 1 mean, and ScaleTransition turns that value into a visible size.
class PulsingDot extends StatefulWidget {
  final Color color;
  final double size;

  const PulsingDot({
    super.key,
    this.color = ColorResources.success,
    this.size = 12,
  });

  @override
  State<PulsingDot> createState() => _PulsingDotState();
}

class _PulsingDotState extends State<PulsingDot>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void initState() {
    super.initState();

    // repeat() plays the animation again and again.
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    // The controller must be closed when the widget leaves the screen.
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TweenAnimationBuilder is not needed here, CurvedAnimation just bends
    // the movement so it starts and ends slowly.
    final curve = CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOut,
    );

    return ScaleTransition(
      scale: Tween<double>(begin: 0.7, end: 1.0).animate(curve),
      child: FadeTransition(
        opacity: Tween<double>(begin: 0.4, end: 1.0).animate(curve),
        child: Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            color: widget.color,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}