import 'package:flutter/material.dart';
import '../components/admin/stat_card.dart';
import '../resources/color_resources.dart';

/// Shows the live numbers of the shop on the dashboard.
///
/// Every number is worked out from the sample list with fold, which is the
/// reduce function from the reading material.
class DashboardStats extends StatelessWidget {
  final double revenue;
  final int orders;
  final int products;
  final int customers;
  final int lowStock;

  const DashboardStats({
    super.key,
    required this.revenue,
    required this.orders,
    required this.products,
    required this.customers,
    required this.lowStock,
  });

  /// Total money of all the orders, calculated with fold.
  static double totalRevenue(List<Map<String, dynamic>> orderList) {
    return orderList.fold<double>(0, (sum, order) {
      final value = order['total'];
      if (value is num) {
        return sum + value.toDouble();
      }
      return sum + (double.tryParse('$value') ?? 0);
    });
  }

  /// How many orders are still not delivered, calculated with where.
  static int pendingOrders(List<Map<String, dynamic>> orderList) {
    return orderList.where((order) {
      return '${order['status']}' != 'Delivered';
    }).length;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: StatCard(
                label: 'REVENUE',
                value: '${revenue.toStringAsFixed(0)}',
                icon: Icons.payments_outlined,
                prefix: '₹',
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: StatCard(
                label: 'ORDERS',
                value: '$orders',
                icon: Icons.receipt_long_outlined,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: StatCard(
                label: 'CUSTOMERS',
                value: '$customers',
                icon: Icons.people_outline,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: StatCard(
                label: 'PRODUCTS',
                value: '$products',
                icon: Icons.inventory_2_outlined,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: StatCard(
                label: 'LOW STOCK',
                value: '$lowStock',
                icon: Icons.warning_amber_outlined,
                valueColor: lowStock > 0
                    ? ColorResources.danger
                    : ColorResources.success,
              ),
            ),
          ],
        ),
      ],
    );
  }
}