import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../resources/color_resources.dart';
import 'home.dart';
import 'product_details.dart';

/// Shows every product that belongs to one brand.
/// Opened by tapping a brand card on the Home screen.
class BrandProductsPage extends StatelessWidget {
  final String brandName;

  const BrandProductsPage({
    super.key,
    required this.brandName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.background,
      appBar: AppBar(
        title: Text(brandName),
        backgroundColor: ColorResources.background,
        foregroundColor: ColorResources.primary,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('products')
            .snapshots(),
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
                  'Could not load products.\n${snapshot.error}',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: ColorResources.text),
                ),
              ),
            );
          }

          final docs = (snapshot.data?.docs ?? []).where((doc) {
            final data = doc.data() as Map<String, dynamic>;
            return '${data['brand'] ?? ''}'.toLowerCase() ==
                brandName.toLowerCase();
          }).toList();

          if (docs.isEmpty) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Text(
                  'No products from $brandName yet.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: ColorResources.text),
                ),
              ),
            );
          }

          return ListView(
            padding: EdgeInsets.all(16),
            children: docs.map((doc) {
              final data = doc.data() as Map<String, dynamic>;
              final name = '${data['name'] ?? ''}';
              final price = data['price'];

              return Container(
                margin: EdgeInsets.only(bottom: 16),
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: ColorResources.white,
                  border: Border.all(color: ColorResources.border),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        data['image'] ?? 'assets/images/club_prime.png',
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
                            name,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: ColorResources.heading,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            '${data['thickness'] ?? ''}',
                            style: TextStyle(color: ColorResources.text),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '₹${price is num ? price.toStringAsFixed(0) : price}'
                            ' / sq.ft',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: ColorResources.primary,
                            ),
                          ),
                          SizedBox(height: 10),
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductDetailsPage(
                                      product: {
                                        'name': name,
                                        'brand': '${data['brand'] ?? ''}',
                                        'category': '${data['category'] ?? ''}',
                                        'thickness': '${data['thickness'] ?? ''}',
                                        'price': '₹${price is num ? price.toStringAsFixed(0) : price}'
                                            ' / sq.ft',
                                        'image': '${data['image'] ?? ''}',
                                      },
                                    ),
                                  ),
                                );
                              },
                              style: OutlinedButton.styleFrom(
                                padding:
                                    EdgeInsets.symmetric(vertical: 10),
                              ),
                              child: Text('View Details'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
