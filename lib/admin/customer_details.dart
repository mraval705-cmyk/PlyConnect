import 'package:flutter/material.dart';
import '../components/admin/section_box.dart';
import '../components/admin/stat_card.dart';
import '../models/order_model.dart';
import '../resources/color_resources.dart';
import '../resources/sample_data.dart';

/// The full history of one customer. Opened by tapping a customer on the
/// Manage Customers screen. Only the orders of that customer are shown.
class CustomerDetailsPage extends StatelessWidget {
  final String name;
  final String email;
  final String mobile;
  final String userId;

  const CustomerDetailsPage({
    super.key,
    required this.name,
    required this.email,
    required this.mobile,
    required this.userId,
  });

  String get firstLetter {
    if (name.isEmpty) return '?';
    return name[0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    // Only the sample orders that belong to this customer.
    final orderList = SampleData.ordersOfUser(userId);

    final models = orderList
        .map((order) => OrderModel.fromMap(order))
        .toList();

    // Total money this customer has spent, worked out with fold.
    final spent = models.fold<double>(0, (sum, order) => sum + order.total);

    return Scaffold(
      backgroundColor: ColorResources.background,
      appBar: AppBar(
        title: const Text('Customer'),
        backgroundColor: ColorResources.background,
        foregroundColor: ColorResources.primary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 88,
                height: 88,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: ColorResources.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: ColorResources.border, width: 2),
                ),
                child: Text(
                  firstLetter,
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: ColorResources.primary,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 14),

            Text(
              name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: ColorResources.primary,
              ),
            ),

            const SizedBox(height: 4),
            Text(
              email,
              textAlign: TextAlign.center,
              style: const TextStyle(color: ColorResources.text),
            ),

            if (mobile.isNotEmpty) ...[
              const SizedBox(height: 2),
              Text(
                '+91 $mobile',
                textAlign: TextAlign.center,
                style: const TextStyle(color: ColorResources.text),
              ),
            ],

            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: StatCard(
                    label: 'ORDERS',
                    value: '${models.length}',
                    icon: Icons.receipt_long_outlined,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: StatCard(
                    label: 'TOTAL SPENT',
                    value: spent.toStringAsFixed(0),
                    prefix: '₹',
                    icon: Icons.payments_outlined,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            SectionBox(
              title: 'Order History',
              child: models.isEmpty
                  ? const Text(
                      'This customer has not placed an order yet.',
                      style: TextStyle(color: ColorResources.text),
                    )
                  : Column(
                      children: models.map((order) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: ColorResources.background,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '#${order.orderId}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: ColorResources.primary,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                order.productName,
                                style: const TextStyle(
                                  color: ColorResources.text,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${order.statusLine} • ₹${order.total.toStringAsFixed(0)}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: ColorResources.lightText,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}