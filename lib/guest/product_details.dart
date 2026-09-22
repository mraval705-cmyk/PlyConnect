import 'package:flutter/material.dart';
import '../login.dart';
import '../resources/app_colors.dart';

class ProductDetailsPage extends StatelessWidget {
  final Map<String, String> product;

  const ProductDetailsPage({
    super.key,
    required this.product,
  });

  void openLogin(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }

  void showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Widget specification(String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(color: AppColors.text),
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.heading,
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
      backgroundColor: AppColors.background,

      appBar: AppBar(
        title: Text('Product Details'),
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.primary,
        actions: [
          IconButton(
            tooltip: 'Login to save product',
            icon: Icon(Icons.favorite_border),
            onPressed: () {
              openLogin(context);
            },
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                product['image']!,
                height: 240,
                fit: BoxFit.cover,
              ),
            ),

            SizedBox(height: 24),

            Text(
              product['brand']!,
              style: TextStyle(
                fontSize: 12,
                letterSpacing: 1,
                color: AppColors.lightText,
              ),
            ),

            SizedBox(height: 8),

            Text(
              product['name']!,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.heading,
              ),
            ),

            SizedBox(height: 8),

            Text(
              '${product['category']} Plywood',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.text,
              ),
            ),

            SizedBox(height: 16),

            Text(
              product['price']!,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),

            SizedBox(height: 24),

            Text(
              'Description',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.heading,
              ),
            ),

            SizedBox(height: 8),

            Text(
              '${product['thickness']} ${product['category']} plywood '
              'from ${product['brand']}. '
              'Contact the shop for available sheet sizes, '
              'stock and detailed specifications.',
              style: TextStyle(
                fontSize: 16,
                height: 1.6,
                color: AppColors.text,
              ),
            ),

            SizedBox(height: 24),

            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Technical Specifications',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.heading,
                    ),
                  ),

                  Divider(color: AppColors.border),

                  specification('Brand', product['brand']!),
                  specification('Category', product['category']!),
                  specification('Thickness', product['thickness']!),
                  specification('Sheet size', 'Confirm with shop'),
                  specification('Warranty', 'Confirm with shop'),
                ],
              ),
            ),

            SizedBox(height: 24),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      showMessage(
                        context,
                        'Compare page is not connected yet.',
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primary,
                      side: BorderSide(color: AppColors.primary),
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text('Compare'),
                  ),
                ),

                SizedBox(width: 12),

                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      showMessage(
                        context,
                        'Contact page is not connected yet.',
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primary,
                      side: BorderSide(color: AppColors.primary),
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text('Contact'),
                  ),
                ),
              ],
            ),

            SizedBox(height: 12),

            SizedBox(
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  openLogin(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Login to Place Order',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),

            SizedBox(height: 16),

            Text(
              'Please login to place an order or save products.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: AppColors.lightText,
              ),
            ),

            SizedBox(height: 24),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.background,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.text,
        selectedFontSize: 11,
        unselectedFontSize: 11,
        onTap: (index) {
          if (index == 0) {
            Navigator.pop(context);
          } else if (index == 1) {
            showMessage(
              context,
              'Use the category filters on Home.',
            );
          } else {
            openLogin(context);
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category_outlined),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Wishlist',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}