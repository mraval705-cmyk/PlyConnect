import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../components/guest_page.dart';
import '../login.dart';
import '../resources/color_resources.dart';

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

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Color statusColor(String status) {
    if (status == 'Pending') {
      return ColorResources.warning;
    }
    if (status == 'Confirmed') {
      return ColorResources.info;
    }
    if (status == 'Delivered') {
      return ColorResources.success;
    }
    return ColorResources.primary;
  }

  // Only the orders that belong to the signed in user are shown.
  Stream<QuerySnapshot>? myOrdersStream() {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      return null;
    }

    return FirebaseFirestore.instance
        .collection('orders')
        .where('userId', isEqualTo: currentUser.uid)
        .snapshots();
  }

  Widget loginNeeded() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.receipt_long_outlined,
              size: 60,
              color: ColorResources.lightText,
            ),
            SizedBox(height: 16),
            Text(
              'Please login to see your orders.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: ColorResources.text,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                );
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
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
            Text(
              title,
              style: TextStyle(
                fontSize: 10,
                color: ColorResources.text,
              ),
            ),
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

  Widget orderCard(Map<String, dynamic> order) {
    final quantity = '${order['quantity'] ?? 1}';
    final status = '${order['status'] ?? 'Pending'}';

    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
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
                      '${order['orderId'] ?? ''}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: ColorResources.primary,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      '${order['date'] ?? ''}',
                      style: TextStyle(
                        fontSize: 12,
                        color: ColorResources.text,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
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

          SizedBox(height: 12),
          Divider(color: ColorResources.border),
          SizedBox(height: 12),

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
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${order['name'] ?? ''}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: ColorResources.primary,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      '${order['brand'] ?? ''} • ${order['thickness'] ?? ''}',
                      style: TextStyle(color: ColorResources.text),
                    ),
                    SizedBox(height: 10),
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
                  ],
                ),
              ),
            ],
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
                    showMessage('Invoice generation is not connected yet.');
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 6),
                  ),
                  child: Text('View Invoice'),
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
    final stream = myOrdersStream();

    return GuestPage(
      title: 'My Orders',
      selectedIndex: 3,
      body: stream == null
          ? loginNeeded()
          : StreamBuilder<QuerySnapshot>(
              stream: stream,
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
                        'Could not load your orders.\n${snapshot.error}',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: ColorResources.text),
                      ),
                    ),
                  );
                }

                final docs = snapshot.data?.docs ?? [];

                int countWithStatus(String status) {
                  return docs.where((doc) {
                    final data = doc.data() as Map<String, dynamic>;
                    return '${data['status'] ?? ''}' == status;
                  }).length;
                }

                final visible = docs.where((doc) {
                  final data = doc.data() as Map<String, dynamic>;
                  final orderId =
                      '${data['orderId'] ?? ''}'.toLowerCase();
                  final status = '${data['status'] ?? ''}';

                  final matchesSearch = orderId.contains(search);
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

                    SizedBox(height: 24),

                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Search by Order ID',
                        prefixIcon: Icon(
                          Icons.search,
                          color: ColorResources.primary,
                        ),
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
                          'No orders found.',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: ColorResources.text),
                        ),
                      ),

                    ...visible.map(
                      (doc) => orderCard(doc.data() as Map<String, dynamic>),
                    ),
                  ],
                );
              },
            ),
    );
  }
}
