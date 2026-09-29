import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../resources/color_resources.dart';
import 'add_product.dart';
import 'edit_product.dart';

class ManageProductsPage extends StatefulWidget {
  const ManageProductsPage({super.key});

  @override
  State<ManageProductsPage> createState() => _ManageProductsPageState();
}

class _ManageProductsPageState extends State<ManageProductsPage> {
  String search = '';

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Future<void> deleteProduct(String docId, String name) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: ColorResources.background,
          title: Text('Remove Product'),
          content: Text('Remove $name from the database?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: Text(
                'Cancel',
                style: TextStyle(color: ColorResources.primary),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, true);
              },
              child: Text(
                'Remove',
                style: TextStyle(color: ColorResources.primary),
              ),
            ),
          ],
        );
      },
    );

    if (!mounted || confirmed != true) {
      return;
    }

    try {
      await FirebaseFirestore.instance
          .collection('products')
          .doc(docId)
          .delete();
    } catch (error) {
      if (mounted) {
        showMessage('Could not remove the product. $error');
      }
      return;
    }

    if (mounted) {
      showMessage('Product removed.');
    }
  }

  // Turns the raw Firestore numbers into readable text.
  String showPrice(dynamic value) {
    if (value is num) {
      return value.toStringAsFixed(2);
    }
    return '$value';
  }

  Widget productCard(String docId, Map<String, dynamic> product) {
    final name = '${product['name'] ?? ''}';

    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: ColorResources.white,
        border: Border.all(color: ColorResources.border),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              product['image'] ?? 'assets/images/club_prime.png',
              width: 75,
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
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: ColorResources.heading,
                  ),
                ),

                SizedBox(height: 6),

                Text(
                  '${product['brand'] ?? ''}',
                  style: TextStyle(color: ColorResources.text),
                ),

                SizedBox(height: 8),

                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  crossAxisAlignment: WrapCrossAlignment.center,
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
                        '${product['thickness'] ?? ''}',
                        style: TextStyle(
                          fontSize: 12,
                          color: ColorResources.text,
                        ),
                      ),
                    ),
                    Text(
                      '₹${showPrice(product['price'])}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: ColorResources.primary,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 4),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      tooltip: 'Edit product',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditProductPage(),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.edit_outlined,
                        color: ColorResources.primary,
                      ),
                    ),
                    IconButton(
                      tooltip: 'Remove product',
                      onPressed: () {
                        deleteProduct(docId, name);
                      },
                      icon: Icon(
                        Icons.delete_outline,
                        color: ColorResources.primary,
                      ),
                    ),
                  ],
                ),
              ],
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
        title: Text('Products'),
        backgroundColor: ColorResources.background,
        foregroundColor: ColorResources.primary,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search Product',
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

                  SizedBox(width: 8),

                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddProductPage(),
                        ),
                      );
                    },
                    icon: Icon(Icons.add),
                    label: Text('Add'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('products').snapshots(),
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
                        'No products found.',
                        style: TextStyle(color: ColorResources.text),
                      ),
                    );
                  }

                  return ListView(
                    padding: EdgeInsets.all(16),
                    children: visible
                        .map((doc) => productCard(
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
