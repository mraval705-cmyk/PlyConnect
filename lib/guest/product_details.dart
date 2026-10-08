import 'package:flutter/material.dart';
import '../login.dart';
import '../resources/color_resources.dart';
import '../user/order_summary.dart';
import 'browse_products.dart';
import 'compare_products.dart';
import 'contact_shop.dart';
import 'select_product.dart';

class ProductDetailsPage extends StatelessWidget {
  final Map<String, String> product;

  const ProductDetailsPage({
    super.key,
    required this.product,
  });

  void openPage(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  void openLogin(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
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
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(color: ColorResources.text),
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: ColorResources.heading,
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
        title: const Text('Product Details'),
        backgroundColor: ColorResources.background,
        foregroundColor: ColorResources.primary,
        actions: [
          IconButton(
            tooltip: 'Save product',
            icon: const Icon(Icons.favorite_border),
            onPressed: () {
              showMessage(context, 'Please log in to save products.');
            },
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                product['image'] ?? 'assets/images/club_prime.png',
                height: 240,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 24),

            Text(
              '${product['brand']}',
              style: const TextStyle(
                fontSize: 12,
                letterSpacing: 1,
                color: ColorResources.lightText,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              '${product['name']}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: ColorResources.heading,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              '${product['category']} Plywood',
              style: const TextStyle(
                fontSize: 16,
                color: ColorResources.text,
              ),
            ),

            const SizedBox(height: 16),

            Text(
              '${product['price']}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: ColorResources.primary,
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'Description',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: ColorResources.heading,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              '${product['thickness']} ${product['category']} plywood '
              'from ${product['brand']}. '
              'Contact the shop for available sheet sizes, '
              'stock and detailed specifications.',
              style: const TextStyle(
                fontSize: 16,
                height: 1.6,
                color: ColorResources.text,
              ),
            ),

            const SizedBox(height: 24),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: ColorResources.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: ColorResources.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Technical Specifications',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: ColorResources.heading,
                    ),
                  ),

                  Divider(color: ColorResources.border),

                  specification('Brand', '${product['brand']}'),
                  specification('Category', '${product['category']}'),
                  specification('Thickness', '${product['thickness']}'),
                  specification('Sheet size', 'Confirm with shop'),
                  specification('Warranty', 'Confirm with shop'),
                ],
              ),
            ),

            const SizedBox(height: 24),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      // Compare goes to the Select Product screen first,
                      // because one more product has to be picked.
                      openPage(context, const SelectProductPage());
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: ColorResources.primary,
                      side: const BorderSide(color: ColorResources.primary),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Compare'),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      openPage(context, const ContactShopPage());
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: ColorResources.primary,
                      side: const BorderSide(color: ColorResources.primary),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Contact'),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            SizedBox(
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  // The order request needs an account, so a guest is sent
                  // to the login screen first.
                  openLogin(context);
                  showMessage(context, 'Please login to place an order.');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorResources.primary,
                  foregroundColor: ColorResources.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Login to Place Order',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),

            const SizedBox(height: 16),

            const Text(
              'Please login to place an order or save products.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: ColorResources.lightText,
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        backgroundColor: ColorResources.background,
        selectedItemColor: ColorResources.primary,
        unselectedItemColor: ColorResources.text,
        selectedFontSize: 11,
        unselectedFontSize: 11,
        onTap: (index) {
          if (index == 1) {
            openPage(context, const BrowseProductsPage());
          } else {
            openLogin(context);
          }
        },
        items: const [
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