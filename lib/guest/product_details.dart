import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../login.dart';
import '../resources/color_resources.dart';
import '../user/order_summary.dart';
import '../user/wishlist.dart';
import '../user/my_orders.dart';
import '../user/my_profile.dart';
import '../user/wishlist.dart';
import 'browse_products.dart';
import 'contact_shop.dart';
import 'select_product.dart';

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

  // True when somebody is browsing without an account. Only a guest is asked
  // to login, a signed in user never sees the login button.
  bool get isGuest {
    return FirebaseAuth.instance.currentUser == null;
  }

  // A signed in user adds the product to their own wishlist in Firestore.
  Future<void> addToWishlist(BuildContext context) async {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      return;
    }

    final name = product['name'] ?? '';

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .collection('wishlist')
          .doc(name)
          .set({
        'name': name,
        'brand': '${product['brand'] ?? ''}',
        'category': '${product['category'] ?? ''}',
        'thickness': '${product['thickness'] ?? ''}',
        'price': '${product['price'] ?? 0}',
        'image': '${product['image'] ?? ''}',
        'addedAt': FieldValue.serverTimestamp(),
      });
    } catch (error) {
      if (!context.mounted) return;
      showMessage(context, 'Could not save the product. $error');
      return;
    }

    if (!context.mounted) return;
    showMessage(context, '$name added to your wishlist.');
  }

  // A guest is sent to login, a signed in user goes to the wishlist screen.
  void openWishlistOrLogin(BuildContext context) {
    if (isGuest) {
      openLogin(context);
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const WishlistPage(),
        ),
      );
    }
  }

  // Only a signed in user can send an order request to the shop.
  void placeOrderOrLogin(BuildContext context) {
    if (isGuest) {
      openLogin(context);
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const OrderSummaryPage(),
      ),
    );
  }

  // The Compare button goes to the Select Product screen first, because the
  // design asks the user to pick one more product before the comparison.
  void openCompare(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SelectProductPage(),
      ),
    );
  }

  void openContactShop(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ContactShopPage(),
      ),
    );
  }

  void openBrowse(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BrowseProductsPage(),
      ),
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
              style: TextStyle(color: ColorResources.text),
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
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
        title: Text('Product Details'),
        backgroundColor: ColorResources.background,
        foregroundColor: ColorResources.primary,
        actions: [
          // A signed in user saves directly, a guest is asked to login first.
          IconButton(
            tooltip: isGuest ? 'Login to save product' : 'Save to wishlist',
            icon: Icon(Icons.favorite_border),
            onPressed: () {
              if (isGuest) {
                openLogin(context);
              } else {
                addToWishlist(context);
              }
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
                color: ColorResources.lightText,
              ),
            ),

            SizedBox(height: 8),

            Text(
              product['name']!,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: ColorResources.heading,
              ),
            ),

            SizedBox(height: 8),

            Text(
              '${product['category']} Plywood',
              style: TextStyle(
                fontSize: 16,
                color: ColorResources.text,
              ),
            ),

            SizedBox(height: 16),

            Text(
              product['price']!,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: ColorResources.primary,
              ),
            ),

            SizedBox(height: 24),

            Text(
              'Description',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: ColorResources.heading,
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
                color: ColorResources.text,
              ),
            ),

            SizedBox(height: 24),

            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: ColorResources.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: ColorResources.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Technical Specifications',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: ColorResources.heading,
                    ),
                  ),

                  Divider(color: ColorResources.border),

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
                      openCompare(context);
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: ColorResources.primary,
                      side: BorderSide(color: ColorResources.primary),
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
                      openContactShop(context);
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: ColorResources.primary,
                      side: BorderSide(color: ColorResources.primary),
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

            // Guest: asks for login. Signed in: sends the order request to
            // the shop straight away.
            SizedBox(
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  placeOrderOrLogin(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorResources.primary,
                  foregroundColor: ColorResources.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  isGuest ? 'Login to Place Order' : 'Send Order Request',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),

            SizedBox(height: 16),

            // The note is only useful for a guest.
            if (isGuest)
              Text(
                'Please login to place an order or save products.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: ColorResources.lightText,
                ),
              ),

            SizedBox(height: 24),
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
          if (index == 0) {
            Navigator.pop(context);
          } else if (index == 1) {
            openBrowse(context);
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const WishlistPage(),
              ),
            );
          } else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MyOrdersPage(),
              ),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MyProfilePage(),
              ),
            );
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