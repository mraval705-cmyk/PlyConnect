import 'package:flutter/material.dart';
import '../components/admin/recent_order_row.dart';
import '../models/order_model.dart';
import '../resources/color_resources.dart';

/// Shows the three newest orders, taken straight from the sample list.
class RecentOrdersSection extends StatelessWidget {
  final List<Map<String, dynamic>> orderList;

  const RecentOrdersSection({
    super.key,
    required this.orderList,
  });

  @override
  Widget build(BuildContext context) {
    // map turns the plain maps into OrderModel objects, then take keeps only
    // the first three.
    final models = orderList
        .map((order) => OrderModel.fromMap(order))
        .take(3)
        .toList();

    if (models.isEmpty) {
      return const Text(
        'No orders yet.',
        style: TextStyle(color: ColorResources.text),
      );
    }

    return Column(
      children: models.map((order) => RecentOrderRow(order: order)).toList(),
    );
  }
}