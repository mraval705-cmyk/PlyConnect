import 'package:flutter/material.dart';
import '../../resources/color_resources.dart';

/// One "this is running low" warning row, with a button to fix the count.
class LowStockRow extends StatelessWidget {
  final String name;
  final String brand;
  final int sheetsLeft;
  final VoidCallback onUpdate;

  const LowStockRow({
    super.key,
    required this.name,
    required this.brand,
    required this.sheetsLeft,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    final isEmpty = sheetsLeft <= 0;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: ColorResources.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isEmpty ? ColorResources.danger : ColorResources.warning,
        ),
      ),
      child: Row(
        children: [
          Icon(
            isEmpty ? Icons.error_outline : Icons.warning_amber_outlined,
            size: 20,
            color: isEmpty ? ColorResources.danger : ColorResources.warning,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: ColorResources.heading,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '$brand • ${sheetsLeft <= 0 ? 'out of stock' : '$sheetsLeft left'}',
                  style: TextStyle(
                    fontSize: 12,
                    color: isEmpty
                        ? ColorResources.danger
                        : ColorResources.warning,
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: onUpdate,
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }
}