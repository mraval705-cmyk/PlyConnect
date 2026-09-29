import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../resources/color_resources.dart';

class ManageOrdersPage extends StatefulWidget {
  const ManageOrdersPage({super.key});

  @override
  State<ManageOrdersPage> createState() => _ManageOrdersPageState();
}

class _ManageOrdersPageState extends State<ManageOrdersPage> {
  String search = '';
  String selectedStatus = 'All';

  final statuses = ['All', 'Pending', 'Confirmed', 'Processing', 'Delivered'];

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

  // Moves an order to the next status in the list and saves it in Firestore.
  Future<void> updateStatus(String docId, String currentStatus) async {
    const next = ['Pending', 'Confirmed', 'Processing', 'Delivered'];
    final index = next.indexOf(currentStatus);
    final newStatus = next[(index + 1) % next.length];

    try {
      await FirebaseFirestore.instance
          .collection('orders')
          .doc(docId)
          .update({'status': newStatus});
    } catch (error) {
      if (mounted) showMessage('Could not update the status. $error');
      return;
    }

    if (mounted) showMessage('Status changed to $newStatus.');
  }

  Widget countCard(String title, int count) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: ColorResources.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: ColorResources.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: TextStyle(fontSize: 10, color: ColorResources.text)),
            SizedBox(height: 8),
            Text(
              '$count',
              style: TextStyle(
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

  Widget orderCard(String docId, Map<String, dynamic> order) {
    final status = '${order['status'] ?? 'Pending'}';
    final quantity = '${order['quantity'] ?? 1}';

    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
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
                      '#${order['orderId'] ?? ''}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: ColorResources.primary,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '${order['customerName'] ?? order['customer'] ?? ''}',
                      style: TextStyle(fontSize: 13, color: ColorResources.text),
                    ),
                    SizedBox(height: 2),
                    Text(
                      '${order['date'] ?? ''}',
                      style:
                          TextStyle(fontSize: 11, color: ColorResources.lightText),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
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

          SizedBox(height: 12),
          Divider(height: 1, color: ColorResources.border),
          SizedBox(height: 12),

          Text(
            '${order['name'] ?? ''}',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: ColorResources.heading,
            ),
          ),
          SizedBox(height: 6),
          Text(
            '${order['brand'] ?? ''} • ${order['thickness'] ?? ''}',
            style: TextStyle(color: ColorResources.text),
          ),
          SizedBox(height: 6),
          Text(
            'Qty: $quantity ${quantity == '1' ? 'Sheet' : 'Sheets'}',
            style: TextStyle(color: ColorResources.text),
          ),
          SizedBox(height: 6),
          Text(
            '₹${order['total'] ?? 0}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: ColorResources.primary,
            ),
          ),

          SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    showMessage('Order details will be connected later.');
                  },
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 6),
                  ),
                  child: Text('View Details'),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    updateStatus(docId, status);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 6),
                  ),
                  child: Text('Next Status'),
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
    return Scaffold(
      backgroundColor: ColorResources.background,
      appBar: AppBar(
        title: Text('Manage Orders'),
        backgroundColor: ColorResources.background,
        foregroundColor: ColorResources.primary,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('orders').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: ColorResources.primary,
                      ),
                    );
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.all(24),
                        child: Text(
                          'Could not load orders.\n${snapshot.error}',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: ColorResources.text),
                        ),
                      ),
                    );
                  }

                  final docs = snapshot.data?.docs ?? [];

                  if (docs.isEmpty) {
                    return SizedBox.shrink();
                  }

                  int countWithStatus(String status) {
                    return docs.where((doc) {
                      final data = doc.data() as Map<String, dynamic>;
                      return '${data['status'] ?? ''}' == status;
                    }).length;
                  }

                  final visible = docs.where((doc) {
                    final data = doc.data() as Map<String, dynamic>;
                    final orderId = '${data['orderId'] ?? ''}'.toLowerCase();
                    final customer =
                        '${data['customerName'] ?? ''}'.toLowerCase();
                    final status = '${data['status'] ?? ''}';

                    final matchesSearch =
                        orderId.contains(search) || customer.contains(search);
                    final matchesStatus =
                        selectedStatus == 'All' || status == selectedStatus;

                    return matchesSearch && matchesStatus;
                  }).toList();

                  return ListView(
                    padding: EdgeInsets.all(16),
                    children: [
                      Row(
                        children: [
                          countCard('TOTAL', docs.length),
                          SizedBox(width: 8),
                          countCard('PENDING', countWithStatus('Pending')),
                          SizedBox(width: 8),
                          countCard('DELIVERED', countWithStatus('Delivered')),
                        ],
                      ),

                      SizedBox(height: 20),

                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Search Order ID or Customer',
                          prefixIcon:
                              Icon(Icons.search, color: ColorResources.primary),
                        ),
                        onChanged: (value) {
                          setState(() {
                            search = value.trim().toLowerCase();
                          });
                        },
                      ),

                      SizedBox(height: 16),

                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: statuses.map((status) {
                            final selected = selectedStatus == status;

                            return Padding(
                              padding: EdgeInsets.only(right: 8),
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

                      SizedBox(height: 20),

                      if (visible.isEmpty)
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 40),
                          child: Text(
                            'No matching orders.',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: ColorResources.text),
                          ),
                        ),

                      ...visible.map(
                        (doc) => orderCard(
                          doc.id,
                          doc.data() as Map<String, dynamic>,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
