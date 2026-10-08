import 'package:flutter/material.dart';
import '../components/admin/stat_card.dart';
import '../components/guest_page.dart';
import '../resources/color_resources.dart';
import '../resources/sample_data.dart';

class MyOrdersPage extends StatefulWidget {
  const MyOrdersPage({super.key});

  @override
  State<MyOrdersPage> createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {
  String search = '';
  String selectedStatus = 'All';

  final statuses = [
    'All',
    'Pending',
    'Confirmed',
    'Processing',
    'Delivered',
  ];

  // A working copy of the sample orders.
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
                    const SizedBox(height: 6),
                    Text(
                      '${order['date']}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: ColorResources.text,
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
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: statusColor(status),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),
          Divider(color: ColorResources.border),
          const SizedBox(height: 12),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  order['image'] ?? 'assets/images/club_prime.png',
                  width: 80,
                  height: 90,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${order['name']}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: ColorResources.primary,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${order['brand']} • ${order['thickness']}',
                      style: const TextStyle(color: ColorResources.text),
                    ),
                    const SizedBox(height: 10),
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
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    showMessage('Order details will be connected later.');
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                  ),
                  child: const Text('View Details'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    showMessage('Invoice generation is not connected yet.');
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                  ),
                  child: const Text('View Invoice'),
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
    // where() filters the sample orders, the same way it would filter live
    // data.
    final visible = orders.where((order) {
      final orderId = '${order['orderId']}'.toLowerCase();
      final status = '${order['status']}';

      final matchesSearch = orderId.contains(search);
      final matchesStatus =
          selectedStatus == 'All' || status == selectedStatus;

      return matchesSearch && matchesStatus;
    }).toList();

    // fold() is not needed here, a simple count is enough.
    int countWithStatus(String status) {
      return orders.where((order) {
        return order['status'] == status;
      }).length;
    }

    return GuestPage(
      title: 'My Orders',
      selectedIndex: 3,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            children: [
              Expanded(
                child: StatCard(
                  label: 'TOTAL',
                  value: '${orders.length}',
                  icon: Icons.receipt_long_outlined,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: StatCard(
                  label: 'PENDING',
                  value: '${countWithStatus('Pending')}',
                  icon: Icons.pending_actions_outlined,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: StatCard(
                  label: 'DELIVERED',
                  value: '${countWithStatus('Delivered')}',
                  icon: Icons.check_circle_outline,
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          TextField(
            decoration: const InputDecoration(
              hintText: 'Search by Order ID',
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
    );
  }
}