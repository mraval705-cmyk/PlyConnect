import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../resources/color_resources.dart';

class StockManagementPage extends StatefulWidget {
  const StockManagementPage({super.key});

  @override
  State<StockManagementPage> createState() => _StockManagementPageState();
}

class _StockManagementPageState extends State<StockManagementPage> {
  String search = '';

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Color statusColor(String status) {
    if (status == 'Out of Stock') {
      return ColorResources.danger;
    }
    if (status == 'Low Stock') {
      return ColorResources.warning;
    }
    return ColorResources.success;
  }

  Widget stockCard(String docId, Map<String, dynamic> item) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorResources.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ColorResources.border),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: ColorResources.background,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              docId.substring(0, docId.length.clamp(0, 4)),
              style: TextStyle(
                fontSize: 10,
                color: ColorResources.primary,
              ),
            ),
          ),

          SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${item['name'] ?? ''}',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: ColorResources.heading,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '${item['brand'] ?? ''}',
                  style: TextStyle(
                    fontSize: 12,
                    color: ColorResources.lightText,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  '${item['stock'] ?? 0} ${item['unit'] ?? 'Sheets'}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: ColorResources.primary,
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
              '${item['status'] ?? ''}',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: statusColor('${item['status'] ?? ''}'),
              ),
            ),
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
        title: Text('Stock Management'),
        backgroundColor: ColorResources.background,
        foregroundColor: ColorResources.primary,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search Stock',
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
            ),

            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('stock').snapshots(),
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
                          'Could not load stock.\n${snapshot.error}',
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
                    final brand = '${data['brand'] ?? ''}'.toLowerCase();
                    return name.contains(search) || brand.contains(search);
                  }).toList();

                  if (visible.isEmpty) {
                    return Center(
                      child: Text(
                        'No stock items found.',
                        style: TextStyle(color: ColorResources.text),
                      ),
                    );
                  }

                  return ListView(
                    padding: EdgeInsets.all(16),
                    children: visible
                        .map((doc) => stockCard(
                              doc.id,
                              doc.data() as Map<String, dynamic>,
                            ))
                        .toList(),
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
