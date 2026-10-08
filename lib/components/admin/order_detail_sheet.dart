import 'package:flutter/material.dart';
import '../../resources/color_resources.dart';

/// A bottom sheet that shows every field of one order in a Table.
class OrderDetailSheet extends StatelessWidget {
  final Map<String, dynamic> order;

  const OrderDetailSheet({
    super.key,
    required this.order,
  });

  /// Opens the sheet from any screen.
  static void show(BuildContext context, Map<String, dynamic> order) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: ColorResources.background,
      builder: (sheetContext) {
        return OrderDetailSheet(order: order);
      },
    );
  }

  /// One row of the table, with the name on the left and the value right.
  TableRow row(String title, String value, {bool bold = false}) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: ColorResources.text,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 12,
              fontWeight: bold ? FontWeight.bold : FontWeight.w500,
              color: bold ? ColorResources.primary : ColorResources.heading,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.7,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return ListView(
          controller: scrollController,
          padding: const EdgeInsets.all(20),
          children: [
            // The little grey line at the top of a bottom sheet.
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: ColorResources.border,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                const Text(
                  'Order Details',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: ColorResources.heading,
                  ),
                ),
                const Spacer(),
                IconButton(
                  tooltip: 'Close',
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Container(
              decoration: BoxDecoration(
                color: ColorResources.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: ColorResources.border),
              ),
              child: Table(
                border: TableBorder.all(color: ColorResources.border),
                columnWidths: const {
                  0: FlexColumnWidth(1),
                  1: FlexColumnWidth(1),
                },
                children: [
                  row('Order id', '${order['orderId'] ?? order['id']}'),
                  row('Customer', '${order['customerName'] ?? '-'}'),
                  row('Date', '${order['date'] ?? '-'}'),
                  row('Status', '${order['status'] ?? '-'}', bold: true),
                  row('Product', '${order['name'] ?? '-'}'),
                  row('Brand', '${order['brand'] ?? '-'}'),
                  row('Thickness', '${order['thickness'] ?? '-'}'),
                  row('Quantity', '${order['quantity'] ?? 1}'),
                  row('Total', '₹${order['total'] ?? 0}', bold: true),
                ],
              ),
            ),

            const SizedBox(height: 20),
          ],
        );
      },
    );
  }
}