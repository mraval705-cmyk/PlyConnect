import 'package:flutter/material.dart';
import '../../models/order_model.dart';
import '../../resources/color_resources.dart';

/// One order row for the dashboard list.
class RecentOrderRow extends StatelessWidget {
  final OrderModel order;

  const RecentOrderRow({
    super.key,
    required this.order,
  });

  /// The colour that matches the status.
  static Color statusColor(String status) {
    switch (status) {
      case 'Delivered':
        return ColorResources.success;
      case 'Shipped':
      case 'Processing':
        return ColorResources.info;
      case 'Confirmed':
        return ColorResources.warning;
      default:
        return ColorResources.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: ColorResources.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ColorResources.border),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '#${order.orderId}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: ColorResources.primary,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  order.customerName,
                  style: const TextStyle(
                    fontSize: 12,
                    color: ColorResources.text,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: ColorResources.background,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: ColorResources.border),
            ),
            child: Text(
              order.status,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: statusColor(order.status),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            '₹${order.total.toStringAsFixed(0)}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: ColorResources.heading,
            ),
          ),
        ],
      ),
    );
  }
}