import 'package:flutter/material.dart';
import '../resources/app_colors.dart';

class ManageProductsPage extends StatefulWidget {
  const ManageProductsPage({super.key});

  @override
  State<ManageProductsPage> createState() => _ManageProductsPageState();
}

class _ManageProductsPageState extends State<ManageProductsPage> {
  String search = '';

  final products = [
    {
      'id': 'P001',
      'name': 'BWP Marine Plywood',
      'brand': 'CenturyPly',
      'thickness': '19 mm',
      'price': '4,640.00',
    },
    {
      'id': 'P002',
      'name': 'MR Grade Commercial',
      'brand': 'Greenply',
      'thickness': '12 mm',
      'price': '3,250.00',
    },
    {
      'id': 'P003',
      'name': 'Natural Teak Veneer',
      'brand': 'Kitply',
      'thickness': '6 mm',
      'price': '1,890.00',
    },
  ];

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Future<void> deleteProduct(Map<String, String> product) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: AppColors.background,
          title: Text('Remove Product'),
          content: Text(
            'Remove ${product['name']} from this demo list?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: Text(
                'Cancel',
                style: TextStyle(color: AppColors.primary),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, true);
              },
              child: Text(
                'Remove',
                style: TextStyle(color: AppColors.primary),
              ),
            ),
          ],
        );
      },
    );

    if (!mounted || confirmed != true) return;

    setState(() {
      products.removeWhere(
        (item) => item['id'] == product['id'],
      );
    });

    showMessage('Product removed from the demo list.');
  }

  Widget productCard(Map<String, String> product) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'assets/images/wishlist_product.png',
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
                  product['name']!,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.heading,
                  ),
                ),

                SizedBox(height: 6),

                Text(
                  product['brand']!,
                  style: TextStyle(color: AppColors.text),
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
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        product['thickness']!,
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.text,
                        ),
                      ),
                    ),
                    Text(
                      '₹${product['price']}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
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
                        showMessage(
                          'Edit Product will be connected later.',
                        );
                      },
                      icon: Icon(
                        Icons.edit_outlined,
                        color: AppColors.primary,
                      ),
                    ),
                    IconButton(
                      tooltip: 'Remove product',
                      onPressed: () {
                        deleteProduct(product);
                      },
                      icon: Icon(
                        Icons.delete_outline,
                        color: AppColors.primary,
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
    final filteredProducts = products.where((product) {
      return product['name']!.toLowerCase().contains(search) ||
          product['brand']!.toLowerCase().contains(search);
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Products'),
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.primary,
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search Product',
                      prefixIcon: Icon(
                        Icons.search,
                        color: AppColors.primary,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: AppColors.border,
                        ),
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
                    showMessage(
                      'Add Product will be connected later.',
                    );
                  },
                  icon: Icon(Icons.add),
                  label: Text('Add'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.button,
                    foregroundColor: AppColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 12),

            Text(
              'Sample products — database not connected',
              style: TextStyle(
                fontSize: 12,
                color: AppColors.lightText,
              ),
            ),

            SizedBox(height: 20),

            if (filteredProducts.isEmpty)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 40),
                child: Text(
                  'No products found.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.text),
                ),
              ),

            ...filteredProducts.map(productCard),
          ],
        ),
      ),
    );
  }
}