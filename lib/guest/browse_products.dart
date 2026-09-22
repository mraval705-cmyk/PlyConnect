import 'package:flutter/material.dart';
import '../resources/app_colors.dart';

class BrowseProductsPage extends StatefulWidget {
  const BrowseProductsPage({super.key});

  @override
  State<BrowseProductsPage> createState() => _BrowseProductsPageState();
}

class _BrowseProductsPageState extends State<BrowseProductsPage> {
  String search = '';
  String category = 'All';
  String brand = 'All';
  String thickness = 'All';
  String priceOrder = 'Default';

  // Sample product data from Figma
  final products = [
    {
      'name': 'BWP Marine Plywood',
      'brand': 'GREENPLY',
      'category': 'Marine',
      'thickness': '18mm',
      'feature': 'Waterproof',
      'price': '112',
      'image': 'assets/images/bwp_marine.png',
    },
    {
      'name': 'Club Prime Board',
      'brand': 'CENTURYPLY',
      'category': 'Marine',
      'thickness': '19mm',
      'feature': 'Termite Proof',
      'price': '145',
      'image': 'assets/images/club_prime.png',
    },
    {
      'name': 'HDHMR Board',
      'brand': 'ACTION TESA',
      'category': 'HDHMR',
      'thickness': '12mm',
      'feature': 'Moisture Resistance',
      'price': '88',
      'image': 'assets/images/hdhmr.png',
    },
    {
      'name': 'Premium Birch Ply',
      'brand': 'SARDA PLYWOOD',
      'category': 'Birch',
      'thickness': '16mm',
      'feature': 'Multi-layer',
      'price': '210',
      'image': 'assets/images/birch.png',
    },
  ];

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Widget filterBox(
    String title,
    String selected,
    List<String> options,
    ValueChanged<String?> onChanged,
  ) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selected,
          dropdownColor: AppColors.background,
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: AppColors.primary,
          ),
          style: TextStyle(
            fontSize: 12,
            color: AppColors.primary,
          ),
          selectedItemBuilder: (context) {
            return options.map((option) {
              return Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  option == 'All' || option == 'Default'
                      ? title
                      : option,
                ),
              );
            }).toList();
          },
          items: options.map((option) {
            return DropdownMenuItem<String>(
              value: option,
              child: Text(option),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget productCard(Map<String, String> product, double width) {
    return Container(
      width: width,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              Image.asset(
                product['image']!,
                width: double.infinity,
                height: 170,
                fit: BoxFit.cover,
              ),

              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    tooltip: 'Save product',
                    icon: Icon(
                      Icons.favorite_border,
                      color: AppColors.primary,
                    ),
                    onPressed: () {
                      showMessage(
                        'Please log in to save products. '
                        'Login will be connected later.',
                      );
                    },
                  ),
                ),
              ),
            ],
          ),

          Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product['brand']!,
                  style: TextStyle(
                    fontSize: 10,
                    color: AppColors.lightText,
                  ),
                ),

                SizedBox(height: 8),

                Text(
                  product['name']!,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.heading,
                  ),
                ),

                SizedBox(height: 6),

                Text(
                  '${product['thickness']} • ${product['feature']}',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.text,
                  ),
                ),

                SizedBox(height: 16),

                Text(
                  '₹${product['price']} / sq.ft',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),

                SizedBox(height: 12),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      showMessage(
                        'Product Details will be connected later.',
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.button,
                      foregroundColor: AppColors.buttonText,
                      padding: EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
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
  }

  @override
  Widget build(BuildContext context) {
    final filteredProducts = products.where((product) {
      final matchesSearch =
          product['name']!.toLowerCase().contains(search) ||
          product['brand']!.toLowerCase().contains(search);

      final matchesCategory =
          category == 'All' || product['category'] == category;

      final matchesBrand =
          brand == 'All' || product['brand'] == brand;

      final matchesThickness =
          thickness == 'All' || product['thickness'] == thickness;

      return matchesSearch &&
          matchesCategory &&
          matchesBrand &&
          matchesThickness;
    }).toList();

    if (priceOrder == 'Low to High') {
      filteredProducts.sort(
        (a, b) => int.parse(a['price']!).compareTo(
          int.parse(b['price']!),
        ),
      );
    } else if (priceOrder == 'High to Low') {
      filteredProducts.sort(
        (a, b) => int.parse(b['price']!).compareTo(
          int.parse(a['price']!),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        title: Text('Browse Products'),
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.primary,
        actions: [
          IconButton(
            tooltip: 'Notifications',
            icon: Icon(Icons.notifications_none),
            onPressed: () {
              showMessage('Notifications will be connected later.');
            },
          ),
          IconButton(
            tooltip: 'Profile',
            icon: Icon(Icons.person_outline),
            onPressed: () {
              showMessage('Profile will be connected later.');
            },
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search plywood types, brands...',
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
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: AppColors.primary,
                  ),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  search = value.trim().toLowerCase();
                });
              },
            ),

            SizedBox(height: 16),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  filterBox(
                    'Category',
                    category,
                    ['All', 'Marine', 'HDHMR', 'Birch'],
                    (value) {
                      if (value == null) return;
                      setState(() {
                        category = value;
                      });
                    },
                  ),

                  filterBox(
                    'Brand',
                    brand,
                    [
                      'All',
                      'GREENPLY',
                      'CENTURYPLY',
                      'ACTION TESA',
                      'SARDA PLYWOOD',
                    ],
                    (value) {
                      if (value == null) return;
                      setState(() {
                        brand = value;
                      });
                    },
                  ),

                  filterBox(
                    'Thickness',
                    thickness,
                    ['All', '12mm', '16mm', '18mm', '19mm'],
                    (value) {
                      if (value == null) return;
                      setState(() {
                        thickness = value;
                      });
                    },
                  ),

                  filterBox(
                    'Price',
                    priceOrder,
                    ['Default', 'Low to High', 'High to Low'],
                    (value) {
                      if (value == null) return;
                      setState(() {
                        priceOrder = value;
                      });
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: 16),

            Text(
              '${filteredProducts.length} products',
              style: TextStyle(color: AppColors.text),
            ),

            SizedBox(height: 16),

            if (filteredProducts.isEmpty)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 40),
                child: Text(
                  'No products match your search or filters.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.text),
                ),
              ),

            LayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.maxWidth < 320
                    ? constraints.maxWidth
                    : (constraints.maxWidth - 16) / 2;

                return Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: filteredProducts.map((product) {
                    return productCard(product, width);
                  }).toList(),
                );
              },
            ),

            SizedBox(height: 24),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.background,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.text,
        selectedFontSize: 11,
        unselectedFontSize: 11,
        onTap: (index) {
          if (index != 1) {
            showMessage('Navigation will be connected later.');
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