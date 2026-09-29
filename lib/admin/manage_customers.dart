import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../resources/color_resources.dart';

class ManageCustomersPage extends StatefulWidget {
  const ManageCustomersPage({super.key});

  @override
  State<ManageCustomersPage> createState() => _ManageCustomersPageState();
}

class _ManageCustomersPageState extends State<ManageCustomersPage> {
  String search = '';

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  String initialOf(String name) {
    if (name.isEmpty) {
      return '?';
    }
    return name[0].toUpperCase();
  }

  Widget customerCard(Map<String, dynamic> customer) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorResources.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ColorResources.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipOval(
            child: Container(
              width: 56,
              height: 56,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: ColorResources.background,
                shape: BoxShape.circle,
                border: Border.all(color: ColorResources.border),
              ),
              child: Text(
                initialOf('${customer['name'] ?? ''}'),
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: ColorResources.primary,
                ),
              ),
            ),
          ),

          SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${customer['name'] ?? ''}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: ColorResources.heading,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '${customer['email'] ?? ''}',
                  style: TextStyle(
                    fontSize: 12,
                    color: ColorResources.text,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  customer['mobile'] == null || '${customer['mobile']}'.isEmpty
                      ? 'Mobile not given'
                      : '+91 ${customer['mobile']}',
                  style: TextStyle(
                    fontSize: 12,
                    color: ColorResources.lightText,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: ColorResources.background,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '${customer['orderCount'] ?? 0} Orders',
                        style: TextStyle(
                          fontSize: 11,
                          color: ColorResources.primary,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Joined ${customer['joined'] ?? 'recently'}',
                      style: TextStyle(
                        fontSize: 11,
                        color: ColorResources.lightText,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Column(
            children: [
              IconButton(
                tooltip: 'View customer',
                onPressed: () {
                  showMessage(
                    'Customer details will be connected later.',
                  );
                },
                icon: Icon(
                  Icons.visibility_outlined,
                  color: ColorResources.primary,
                ),
              ),
              IconButton(
                tooltip: 'Call customer',
                onPressed: () {
                  showMessage('Calling will be connected later.');
                },
                icon: Icon(
                  Icons.call_outlined,
                  color: ColorResources.primary,
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
        title: Text('Manage Customers'),
        backgroundColor: ColorResources.background,
        foregroundColor: ColorResources.primary,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              // Real customers come from the same "users" collection that
              // Sign Up writes to, so this list is always up to date.
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('users').snapshots(),
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
                          'Could not load customers.\n${snapshot.error}',
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

                  final visible = docs.where((doc) {
                    final data = doc.data() as Map<String, dynamic>;
                    final name = '${data['name'] ?? ''}'.toLowerCase();
                    final email = '${data['email'] ?? ''}'.toLowerCase();
                    final mobile = '${data['mobile'] ?? ''}';
                    return name.contains(search) ||
                        email.contains(search) ||
                        mobile.contains(search);
                  }).toList();

                  return ListView(
                    padding: EdgeInsets.all(16),
                    children: [
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: ColorResources.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: ColorResources.border),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.people_outline,
                              color: ColorResources.primary,
                              size: 32,
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${docs.length}',
                                    style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      color: ColorResources.primary,
                                    ),
                                  ),
                                  Text(
                                    'Total Customers',
                                    style:
                                        TextStyle(color: ColorResources.text),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 16),

                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Search Customer',
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

                      SizedBox(height: 20),

                      if (visible.isEmpty)
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 40),
                          child: Text(
                            'No customers found.',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: ColorResources.text),
                          ),
                        ),

                      ...visible.map(
                        (doc) => customerCard(doc.data() as Map<String, dynamic>),
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
