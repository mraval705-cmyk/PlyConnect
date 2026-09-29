import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../components/guest_page.dart';
import '../guest/product_details.dart';
import '../login.dart';
import '../resources/color_resources.dart';
import 'order_summary.dart';

/// The wishlist is stored inside each user's own document:
///   users / {uid} / wishlist / {productId}
/// Because of this, a brand new user automatically has an empty wishlist.
class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Stream<QuerySnapshot>? wishlistStream() {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      return null;
    }

    return FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .collection('wishlist')
        .snapshots();
  }

  Future<void> removeProduct(String docId, String name) async {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      return;
    }

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .collection('wishlist')
          .doc(docId)
          .delete();
    } catch (error) {
      if (mounted) {
        showMessage('Could not remove the product. $error');
      }
      return;
    }

    if (mounted) {
      showMessage('$name removed from your wishlist.');
    }
  }

  Widget productCard(String docId, Map<String, dynamic> product) {
    final name = '${product['name'] ?? ''}';

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  product['image'] ?? 'assets/images/club_prime.png',
                  width: 80,
                  height: 95,
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
                        color: ColorResources.primary,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      '${product['brand'] ?? ''}',
                      style: TextStyle(
                        fontSize: 11,
                        color: ColorResources.text,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Thickness: ${product['thickness'] ?? ''}',
                      style: TextStyle(
                        fontSize: 12,
                        color: ColorResources.lightText,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      '₹${product['price'] ?? 0} / sq.ft',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: ColorResources.primary,
                      ),
                    ),
                  ],
                ),
              ),

              IconButton(
                tooltip: 'Remove from wishlist',
                onPressed: () {
                  removeProduct(docId, name);
                },
                icon: Icon(
                  Icons.favorite,
                  color: ColorResources.primary,
                ),
              ),
            ],
          ),

          SizedBox(height: 12),
          Divider(color: ColorResources.border),
          SizedBox(height: 8),

          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailsPage(
                          product: {
                            'name': '${product['name'] ?? ''}',
                            'brand': '${product['brand'] ?? ''}',
                            'category': '${product['category'] ?? ''}',
                            'thickness': '${product['thickness'] ?? ''}',
                            'price': '₹${product['price'] ?? 0} / sq.ft',
                            'image': '${product['image'] ?? ''}',
                          },
                        ),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: ColorResources.primary,
                    padding: EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Text('View Details'),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderSummaryPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorResources.button,
                    foregroundColor: ColorResources.buttonText,
                    padding: EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Text('Place Order'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Shown when nobody is logged in.
  Widget loginNeeded() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_border,
              size: 60,
              color: ColorResources.lightText,
            ),
            SizedBox(height: 16),
            Text(
              'Please login to see your wishlist.',
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

  @override
  Widget build(BuildContext context) {
    final stream = wishlistStream();

    return GuestPage(
      title: 'My Wishlist',
      selectedIndex: 2,
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
                        'Could not load your wishlist.\n${snapshot.error}',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: ColorResources.text),
                      ),
                    ),
                  );
                }

                final docs = snapshot.data?.docs ?? [];

                return ListView(
                  padding: EdgeInsets.all(16),
                  children: [
                    Text(
                      '${docs.length} Saved Products',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: ColorResources.primary,
                      ),
                    ),

                    SizedBox(height: 20),

                    if (docs.isEmpty)
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 60),
                        child: Column(
                          children: [
                            Icon(
                              Icons.favorite_border,
                              size: 60,
                              color: ColorResources.lightText,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Your wishlist is empty.',
                              style: TextStyle(
                                fontSize: 18,
                                color: ColorResources.text,
                              ),
                            ),
                          ],
                        ),
                      ),

                    ...docs.map(
                      (doc) => productCard(
                        doc.id,
                        doc.data() as Map<String, dynamic>,
                      ),
                    ),
                  ],
                );
              },
            ),
    );
  }
}
