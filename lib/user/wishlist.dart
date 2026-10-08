import 'package:flutter/material.dart';
import '../components/guest_page.dart';
import '../guest/product_details.dart';
import '../resources/color_resources.dart';
import '../resources/sample_data.dart';
import 'order_summary.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  // A working copy of the sample wishlist, so removing a product keeps the
  // change for the rest of the session.
  final List<Map<String, dynamic>> wishlist =
      List<Map<String, dynamic>>.from(SampleData.wishlist);

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  /// Removes the product that sits at the given index.
  void removeItem(int index) {
    final name = '${wishlist[index]['name']}';

    setState(() {
      wishlist.removeAt(index);
    });

    showMessage('$name removed from your wishlist.');
  }

  Widget productCard(int index, Map<String, dynamic> product) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
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

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${product['name']}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: ColorResources.primary,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${product['brand']}',
                      style: const TextStyle(
                        fontSize: 11,
                        color: ColorResources.text,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Thickness: ${product['thickness']}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: ColorResources.lightText,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '₹${product['price']} / sq.ft',
                      style: const TextStyle(
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
                onPressed: () => removeItem(index),
                icon: const Icon(
                  Icons.favorite,
                  color: ColorResources.primary,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),
          Divider(color: ColorResources.border),
          const SizedBox(height: 8),

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
                            'name': '${product['name']}',
                            'brand': '${product['brand']}',
                            'category': '${product['category']}',
                            'thickness': '${product['thickness']}',
                            'price': '₹${product['price']} / sq.ft',
                            'image': '${product['image']}',
                          },
                        ),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: ColorResources.primary,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text('View Details'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OrderSummaryPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorResources.button,
                    foregroundColor: ColorResources.buttonText,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text('Place Order'),
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
    return GuestPage(
      title: 'My Wishlist',
      selectedIndex: 2,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            '${wishlist.length} Saved Products',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: ColorResources.primary,
            ),
          ),

          const SizedBox(height: 20),

          if (wishlist.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 60),
              child: Column(
                children: [
                  const Icon(
                    Icons.favorite_border,
                    size: 60,
                    color: ColorResources.lightText,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Your wishlist is empty.',
                    style: TextStyle(
                      fontSize: 18,
                      color: ColorResources.text,
                    ),
                  ),
                ],
              ),
            ),

          // List.generate gives the index of every row, and the index is what
          // removeItem uses to delete the right one.
          ...List.generate(wishlist.length, (index) {
            return productCard(index, wishlist[index]);
          }),
        ],
      ),
    );
  }
}