import 'package:flutter/material.dart';
import '../../resources/color_resources.dart';

/// A simple bar where the value follows the finger.
///
/// Wherever the finger touches, the round handle jumps to that spot and the
/// value is shown in a small box just above it. That is easier to use than
/// the default slider, because there is nothing to hold and drag.
class TouchSlider extends StatefulWidget {
  final double value;
  final double min;
  final double max;

  /// Called on every move with the new value.
  final ValueChanged<double> onChanged;

  /// Wording for the box above the handle, for example "sheets".
  final String suffix;

  const TouchSlider({
    super.key,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
    this.suffix = '',
  });

  @override
  State<TouchSlider> createState() => _TouchSliderState();
}

class _TouchSliderState extends State<TouchSlider> {
  /// Width of the drawn bar, remembered so the touch can be turned into a
  /// value. It is 0 before the first layout.
  double barWidth = 0;

  /// Turns a touch position into a value between min and max.
  double valueAt(double x) {
    if (barWidth <= 0) return widget.min;

    final part = (x / barWidth).clamp(0.0, 1.0);
    final raw = widget.min + part * (widget.max - widget.min);

    // Rounded to a whole number, because sheets are never in decimals.
    return raw.roundToDouble().clamp(widget.min, widget.max);
  }

  void handleTouch(double x) {
    final next = valueAt(x);
    widget.onChanged(next);
  }

  @override
  Widget build(BuildContext context) {
    final span = widget.max - widget.min;
    final filled = span == 0 ? 0.0 : (widget.value - widget.min) / span;
    final filledWidth = barWidth * filled.clamp(0.0, 1.0);

    return LayoutBuilder(
      builder: (context, constraints) {
        barWidth = constraints.maxWidth;

        // The handle sits at the end of the filled part, and the value box
        // is drawn above it.
        final handleLeft = (filledWidth - 12).clamp(0.0, barWidth - 24);

        return Stack(
          clipBehavior: Clip.none,
          children: [
            // The value box above the handle.
            Positioned(
              left: handleLeft,
              bottom: 34,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: ColorResources.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${widget.value.round()} ${widget.suffix}'.trim(),
                  style: const TextStyle(
                    color: ColorResources.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // The bar and the round handle.
            Positioned(
              left: 0,
              right: 0,
              top: 12,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,

                // A single tap jumps straight to that spot.
                onTapDown: (details) {
                  handleTouch(details.localPosition.dx);
                },

                // Dragging keeps following the finger.
                onHorizontalDragUpdate: (details) {
                  handleTouch(details.localPosition.dx);
                },

                child: SizedBox(
                  height: 26,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // The empty part of the bar.
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: ColorResources.border,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),

                      // The filled part of the bar.
                      Container(
                        width: filledWidth,
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: ColorResources.primary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),

                      // The round handle.
                      Positioned(
                        left: handleLeft,
                        child: Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: ColorResources.primary,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: ColorResources.white,
                              width: 3,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}