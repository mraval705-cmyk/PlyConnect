import 'package:flutter/material.dart';
import '../components/admin/order_detail_sheet.dart';
import '../resources/color_resources.dart';
import '../resources/sample_data.dart';

class ManageOrdersPage extends StatefulWidget {
  const ManageOrdersPage({super.key});

  @override
  State<ManageOrdersPage> createState() => _ManageOrdersPageState();
}

class _ManageOrdersPageState extends State<ManageOrdersPage> {
  String search = '';
  String selectedStatus = 'All';

  final statuses = ['All', 'Pending', 'Confirmed', 'Processing', 'Delivered'];

  // A working copy, so changing a status keeps the change for this session.
  final List<Map<String, dynamic>> orders =
      List<Map<String, dynamic>>.from(SampleData.orders);

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Color statusColor(String status) {
    if (status == 'Pending') return ColorResources.warning;
    if (status == 'Confirmed') return ColorResources.info;
    if (status == 'Delivered') return ColorResources.success;
    return ColorResources.primary;
  }

  /// Moves an order to the next status in the list.
  void nextStatus(Map<String, dynamic> order) {
    const next = ['Pending', 'Confirmed', 'Processing', 'Delivered'];

    final index = next.indexOf('${order['status']}');
    final newStatus = next[(index + 1) % next.length];

    setState(() {
      order['status'] = newStatus;
    });

    showMessage('Status changed to $newStatus.');
  }

  Widget countCard(String title, int count) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: ColorResources.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: ColorResources.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 10,
                color: ColorResources.text,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '$count',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: ColorResources.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget orderCard(Map<String, dynamic> order) {
    final quantity = order['quantity'];
    final status = '${order['status']}';

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorResources.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ColorResources.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '#${order['orderId']}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: ColorResources.primary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${order['customerName']}',
                      style: const TextStyle(
                        fontSize: 13,
                        color: ColorResources.text,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${order['date']}',
                      style: const TextStyle(
                        fontSize: 11,
                        color: ColorResources.lightText,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: ColorResources.background,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: ColorResources.border),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: statusColor(status),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),
          Divider(height: 1, color: ColorResources.border),
          const SizedBox(height: 12),

          Text(
            '${order['name']}',
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: ColorResources.heading,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '${order['brand']} • ${order['thickness']}',
            style: const TextStyle(color: ColorResources.text),
          ),
          const SizedBox(height: 6),
          Text(
            'Qty: $quantity ${quantity == 1 ? 'Sheet' : 'Sheets'}',
            style: const TextStyle(color: ColorResources.text),
          ),
          const SizedBox(height: 6),
          Text(
            '₹${order['total']}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: ColorResources.primary,
            ),
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => OrderDetailSheet.show(context, order),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                  ),
                  child: const Text('View Details'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => nextStatus(order),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                  ),
                  child: const Text('Next Status'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // where() is used twice here - once for the search, once for the status.
    final visible = orders.where((order) {
      final orderId = '${order['orderId']}'.toLowerCase();
      final customer = '${order['customerName']}'.toLowerCase();
      final status = '${order['status']}';

      final matchesSearch =
          orderId.contains(search) || customer.contains(search);
      final matchesStatus =
          selectedStatus == 'All' || status == selectedStatus;

      return matchesSearch && matchesStatus;
    }).toList();

    final pending = orders.where((order) {
      return order['status'] == 'Pending';
    }).length;

    final delivered = orders.where((order) {
      return order['status'] == 'Delivered';
    }).length;

    return Scaffold(
      backgroundColor: ColorResources.background,
      appBar: AppBar(
        title: const Text('Manage Orders'),
        backgroundColor: ColorResources.background,
        foregroundColor: ColorResources.primary,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Row(
              children: [
                countCard('TOTAL', orders.length),
                const SizedBox(width: 8),
                countCard('PENDING', pending),
                const SizedBox(width: 8),
                countCard('DELIVERED', delivered),
              ],
            ),

            const SizedBox(height: 20),

            TextField(
              decoration: const InputDecoration(
                hintText: 'Search Order ID or Customer',
                prefixIcon: Icon(Icons.search, color: ColorResources.primary),
              ),
              onChanged: (value) {
                setState(() {
                  search = value.trim().toLowerCase();
                });
              },
            ),

            const SizedBox(height: 16),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: statuses.map((status) {
                  final selected = selectedStatus == status;

                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(status),
                      selected: selected,
                      showCheckmark: false,
                      selectedColor: ColorResources.primary,
                      backgroundColor: ColorResources.white,
                      labelStyle: TextStyle(
                        color: selected
                            ? ColorResources.white
                            : ColorResources.primary,
                      ),
                      onSelected: (value) {
                        setState(() {
                          selectedStatus = status;
                        });
                      },
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 20),

            if (visible.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 40),
                child: Text(
                  'No matching orders.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: ColorResources.text),
                ),
              ),

            ...visible.map(orderCard),
          ],
        ),
      ),
    );
  }
}