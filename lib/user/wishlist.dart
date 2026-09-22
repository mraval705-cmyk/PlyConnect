import 'package:flutter/material.dart';
import '../components/guest_page.dart';
import '../resources/app_colors.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  final products = [
    {
      'name': 'Club Prime Plywood',
      'brand': 'CENTURYPLY',
      'thickness': '19 mm',
      'price': '145',
    },
    {
      'name': 'Architectural Birch',
      'brand': 'GREENPLY',
      'thickness': '12 mm',
      'price': '112',
    },
    {
      'name': 'Marine Shield BWP',
      'brand': 'KITPLY',
      'thickness': '18 mm',
      'price': '185',
    },
    {
      'name': 'Teak Veneer Board',
      'brand': 'AUSTIN PLY',
      'thickness': '6 mm',
      'price': '210',
    },
  ];

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void removeProduct(int index) {
    final name = products[index]['name'];

    setState(() {
      products.removeAt(index);
    });

    showMessage('$name removed from this demo wishlist.');
  }

  Widget productCard(int index) {
    final product = products[index];

    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  'assets/images/wishlist_product.png',
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
                      product['name']!,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      product['brand']!,
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.text,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Thickness: ${product['thickness']}',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.lightText,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      '₹${product['price']} / sq.ft',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),

              IconButton(
                tooltip: 'Remove from wishlist',
                onPressed: () {
                  removeProduct(index);
                },
                icon: Icon(
                  Icons.favorite,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),

          SizedBox(height: 12),
          Divider(color: AppColors.border),
          SizedBox(height: 8),

          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    showMessage('Product Details will be connected later.');
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    side: BorderSide(color: AppColors.border),
                    padding: EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text('View Details'),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    showMessage('Order Summary will be connected later.');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.button,
                    foregroundColor: AppColors.buttonText,
                    padding: EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
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

  @override
  Widget build(BuildContext context) {
    return GuestPage(
      title: 'My Wishlist',
      selectedIndex: 2,
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Text(
            '${products.length} Saved Products',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),

          SizedBox(height: 20),

          if (products.isEmpty)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 60),
              child: Column(
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: 60,
                    color: AppColors.lightText,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Your wishlist is empty.',
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColors.text,
                    ),
                  ),
                ],
              ),
            ),

          ...List.generate(products.length, productCard),
        ],
      ),
    );
  }
}