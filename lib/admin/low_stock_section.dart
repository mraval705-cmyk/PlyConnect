import 'package:flutter/material.dart';
import '../components/admin/low_stock_row.dart';
import '../resources/color_resources.dart';

/// Shows every stock item that is running low, with a button to restock it.
class LowStockSection extends StatelessWidget {
  final List<Map<String, dynamic>> stockList;

  final void Function(String id, String name, int current) onUpdate;

  const LowStockSection({
    super.key,
    required this.stockList,
    required this.onUpdate,
  });

  /// Anything under this many sheets is treated as low.
  static const int lowLimit = 20;

  /// The same check written as a plain loop, kept to show the difference
  /// between a loop and a collection function.
  static List<Map<String, dynamic>> findLow(List<Map<String, dynamic>> list) {
    final List<Map<String, dynamic>> low = [];

    for (final item in list) {
      final value = item['stock'];
      final count = value is num ? value.toInt() : int.tryParse('$value') ?? 0;

      if (count < lowLimit) {
        low.add(item);
      }
    }

    return low;
  }

  @override
  Widget build(BuildContext context) {
    final low = findLow(stockList);

    if (low.isEmpty) {
      return const Text(
        'Every product is well stocked.',
        style: TextStyle(color: ColorResources.success),
      );
    }

    return Column(
      children: low.map((item) {
        final value = item['stock'];
        final count = value is num ? value.toInt() : int.tryParse('$value') ?? 0;

        return LowStockRow(
          name: '${item['name']}',
          brand: '${item['brand']}',
          sheetsLeft: count,
          onUpdate: () {
            onUpdate('${item['id']}', '${item['name']}', count);
          },
        );
      }).toList(),
    );
  }
}