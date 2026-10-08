import 'package:flutter/material.dart';
import '../../resources/color_resources.dart';

/// A number that counts up when the screen opens.
///
/// This is the animation idea from Unit 5. The number starts at zero and
/// moves towards the real value over a short time, so the eye follows it.
///
/// It uses TweenAnimationBuilder, which is an implicit animation widget. We
/// only give it the end value and the time, and it does the movement itself.
class AnimatedNumber extends StatelessWidget {
  final num value;
  final TextStyle? style;
  final Duration duration;
  final String prefix;

  const AnimatedNumber({
    super.key,
    required this.value,
    this.style,
    this.duration = const Duration(milliseconds: 900),
    this.prefix = '',
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<num>(
      tween: Tween<num>(begin: 0, end: value),
      duration: duration,
      curve: Curves.easeOut,
      builder: (context, animated, child) {
        return Text(
          '$prefix${animated.toStringAsFixed(0)}',
          style: style ??
              const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: ColorResources.primary,
              ),
        );
      },
    );
  }
}

/// A thin bar that fills up when the screen opens.
///
/// Also from Unit 5. The width grows from nothing to the given percentage.
class AnimatedBar extends StatelessWidget {
  final double percent;
  final Color color;

  const AnimatedBar({
    super.key,
    required this.percent,
    this.color = ColorResources.primary,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: percent),
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeOut,
      builder: (context, animated, child) {
        return Container(
          height: 8,
          decoration: BoxDecoration(
            color: ColorResources.background,
            borderRadius: BorderRadius.circular(6),
          ),
          child: FractionallySizedBox(
            widthFactor: animated.clamp(0.0, 1.0),
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
        );
      },
    );
  }
}