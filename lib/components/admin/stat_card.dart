import 'package:flutter/material.dart';
import '../../resources/color_resources.dart';
import 'animated_number.dart';

/// A small box that shows one number, for example "42 orders".
/// It is used several times on the dashboard, so it is written once and
/// reused instead of being copied again and again.
class StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color? valueColor;
  final String prefix;

  const StatCard({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    this.valueColor,
    this.prefix = '',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: ColorResources.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: ColorResources.border),
        boxShadow: [
          BoxShadow(
            color: ColorResources.primary.withAlpha(12),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: ColorResources.primary),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 10,
                    color: ColorResources.lightText,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // The number counts up instead of appearing at once. This is the
          // animation idea from Unit 5.
          AnimatedNumber(
            value: double.tryParse(value) ?? 0,
            prefix: prefix,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: valueColor ?? ColorResources.primary,
            ),
          ),
        ],
      ),
    );
  }
}