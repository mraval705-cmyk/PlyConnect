import 'package:flutter/material.dart';
import '../../resources/color_resources.dart';

/// A circle that keeps turning while the data is being fetched.
///
/// AnimatedBuilder rebuilds only the spinning part, instead of rebuilding the
/// whole screen again and again.
class LoadingRing extends StatefulWidget {
  final double size;

  const LoadingRing({
    super.key,
    this.size = 30,
  });

  @override
  State<LoadingRing> createState() => _LoadingRingState();
}

class _LoadingRingState extends State<LoadingRing>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: controller,
        // The whole ring is turned by how far the controller has moved.
        builder: (context, child) {
          return Transform.rotate(
            angle: controller.value * 6.283,
            child: child,
          );
        },
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: ColorResources.border,
              width: 3,
            ),
          ),
          child: const Align(
            alignment: Alignment.topCenter,
            child: DecoratedBox(
              decoration: BoxDecoration(color: ColorResources.primary),
              child: SizedBox(height: 12, width: 3),
            ),
          ),
        ),
      ),
    );
  }
}