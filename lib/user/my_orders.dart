import 'package:flutter/material.dart';
import '../components/guest_page.dart';
import '../resources/app_colors.dart';

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

  // Sample orders for UI practice
  final orders = [
    {
      'id': '#ORD-98765',
      'date': 'Oct 24, 2023',
      'status': 'Delivered',
      'name': 'Club Prime Plywood',
      'details': 'CenturyPly • 19 mm',
      'quantity': '1',
      'total': '4,640.00',
    },
    {
      'id': '#ORD-98766',
      'date': 'Oct 25, 2023',
      'status': 'Pending',
      'name': 'Club Prime Plywood',
      'details': 'CenturyPly • 19 mm',
      'quantity': '2',
      'total': '9,280.00',
    },
    {
      'id': '#ORD-98767',
      'date': 'Oct 26, 2023',
      'status': 'Processing',
      'name': 'Club Prime Plywood',
      'details': 'CenturyPly • 19 mm',
      'quantity': '3',
      'total': '13,920.00',
    },
  ];

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Widget countCard(String title, int count) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 10,
                color: AppColors.text,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '$count',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget orderCard(Map<String, String> order) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
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
                      order['id']!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      order['date']!,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.text,
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
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.border),
                ),
                child: Text(
                  order['status']!,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 12),
          Divider(color: AppColors.border),
          SizedBox(height: 12),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  'assets/images/wishlist_product.png',
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
                      order['name']!,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      order['details']!,
                      style: TextStyle(color: AppColors.text),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Qty: ${order['quantity']} '
                      '${order['quantity'] == '1' ? 'Sheet' : 'Sheets'}',
                      style: TextStyle(color: AppColors.text),
                    ),
                    SizedBox(height: 6),
                    Text(
                      '₹${order['total']}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
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
                    showMessage('Order Details will be connected later.');
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    side: BorderSide(color: AppColors.primary),
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
                    backgroundColor: AppColors.button,
                    foregroundColor: AppColors.white,
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
    final pendingCount = orders.where(
      (order) => order['status'] == 'Pending',
    ).length;

    final deliveredCount = orders.where(
      (order) => order['status'] == 'Delivered',
    ).length;

    final filteredOrders = orders.where((order) {
      final matchesSearch = order['id']!.toLowerCase().contains(search);

      final matchesStatus = selectedStatus == 'All' ||
          order['status'] == selectedStatus;

      return matchesSearch && matchesStatus;
    }).toList();

    return GuestPage(
      title: 'My Orders',
      selectedIndex: 3,
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Text(
            'Sample orders — database not connected',
            style: TextStyle(
              fontSize: 12,
              color: AppColors.lightText,
            ),
          ),

          SizedBox(height: 12),

          Row(
            children: [
              countCard('TOTAL', orders.length),
              SizedBox(width: 8),
              countCard('PENDING', pendingCount),
              SizedBox(width: 8),
              countCard('DELIVERED', deliveredCount),
            ],
          ),

          SizedBox(height: 24),

          TextField(
            decoration: InputDecoration(
              hintText: 'Search by Order ID',
              prefixIcon: Icon(
                Icons.search,
                color: AppColors.primary,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColors.border),
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
                    selectedColor: AppColors.primary,
                    backgroundColor: AppColors.white,
                    labelStyle: TextStyle(
                      color: selected
                          ? AppColors.white
                          : AppColors.primary,
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

          if (filteredOrders.isEmpty)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 40),
              child: Text(
                'No matching orders.',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.text),
              ),
            ),

          ...filteredOrders.map(orderCard),
        ],
      ),
    );
  }
}