import 'package:flutter/material.dart';
import '../login.dart';
import '../resources/app_colors.dart';
import 'product_details.dart';

class GuestHomePage extends StatefulWidget {
  const GuestHomePage({super.key});

  @override
  State<GuestHomePage> createState() => _GuestHomePageState();
}

class _GuestHomePageState extends State<GuestHomePage> {
  String search = '';
  String selectedCategory = 'All';

  final categories = [
    'Commercial',
    'Marine',
    'Decorative',
    'Blockboard',
    'Veneers',
  ];

  final categoryIcons = [
    Icons.apartment,
    Icons.directions_boat_outlined,
    Icons.style_outlined,
    Icons.grid_view,
    Icons.layers_outlined,
  ];

  final brands = [
    'CENTURY',
    'GREENPLY',
    'KITPLY',
    'DURACORE',
  ];

  final products = [
    {
      'name': '18mm Commercial Ply',
      'brand': 'CENTURYPLY',
      'category': 'Commercial',
      'thickness': '18mm',
      'price': '₹85 / sq.ft',
      'image': 'assets/images/commercial.png',
    },
    {
      'name': '12mm BWP Marine Ply',
      'brand': 'GREENPLY',
      'category': 'Marine',
      'thickness': '12mm',
      'price': '₹112 / sq.ft',
      'image': 'assets/images/marine.png',
    },
  ];

  void openLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }

  void openDetails(Map<String, String> product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailsPage(
          product: product,
        ),
      ),
    );
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Widget heading(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.heading,
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
          Image.asset(
            product['image']!,
            height: 160,
            fit: BoxFit.cover,
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
                    color: AppColors.text,
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
                SizedBox(height: 8),
                Text(
                  product['price']!,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      openDetails(product);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.white,
                      padding: EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 10,
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
          selectedCategory == 'All' ||
          product['category'] == selectedCategory;

      return matchesSearch && matchesCategory;
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        title: Text('PlyConnect'),
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.primary,
        actions: [
          IconButton(
            tooltip: 'Notifications',
            icon: Icon(Icons.notifications_none),
            onPressed: () {
              showMessage('Please log in to view notifications.');
            },
          ),
          IconButton(
            tooltip: 'Login',
            icon: Icon(Icons.person_outline),
            onPressed: openLogin,
          ),
        ],
      ),

      drawer: Drawer(
        backgroundColor: AppColors.background,
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Padding(
                padding: EdgeInsets.all(24),
                child: heading('PlyConnect'),
              ),
              ListTile(
                leading: Icon(Icons.home_outlined),
                title: Text('Home'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.login),
                title: Text('Login / Sign Up'),
                onTap: () {
                  Navigator.pop(context);
                  openLogin();
                },
              ),
            ],
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search plywood products...',
                prefixIcon: Icon(
                  Icons.search,
                  color: AppColors.primary,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: AppColors.border),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  search = value.trim().toLowerCase();
                });
              },
            ),

            SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                heading('Categories'),
                TextButton(
                  onPressed: () {
                    setState(() {
                      selectedCategory = 'All';
                    });
                  },
                  child: Text(
                    'View All',
                    style: TextStyle(color: AppColors.primary),
                  ),
                ),
              ],
            ),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(categories.length, (index) {
                  final selected =
                      selectedCategory == categories[index];

                  return Padding(
                    padding: EdgeInsets.only(right: 12),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          selectedCategory = categories[index];
                        });
                      },
                      child: SizedBox(
                        width: 82,
                        child: Column(
                          children: [
                            Container(
                              width: 64,
                              height: 64,
                              decoration: BoxDecoration(
                                color: selected
                                    ? AppColors.primary
                                    : AppColors.border,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Icon(
                                categoryIcons[index],
                                color: selected
                                    ? AppColors.white
                                    : AppColors.primary,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              categories[index],
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.text,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),

            SizedBox(height: 24),

            Container(
              width: double.infinity,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: AssetImage('assets/images/home_banner.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary,
                      AppColors.primary.withAlpha(70),
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'NEW ARRIVAL',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.buttonText,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Ultra-Core\nPremium Plywood',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Starting from ₹95 / sq.ft',
                      style: TextStyle(color: AppColors.white),
                    ),
                    SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {
                        showMessage(
                          'Browse Products page is not connected yet.',
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.white,
                        foregroundColor: AppColors.primary,
                      ),
                      child: Text('Explore Now'),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 24),
            heading('Trusted Brands'),
            SizedBox(height: 12),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: brands.map((brand) {
                  return Container(
                    margin: EdgeInsets.only(right: 12),
                    padding: EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 18,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      border: Border.all(color: AppColors.border),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      brand,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            SizedBox(height: 24),
            heading('Popular Products'),
            SizedBox(height: 16),

            if (filteredProducts.isEmpty)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: Text(
                  'No matching products.',
                  style: TextStyle(color: AppColors.text),
                ),
              ),

            LayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.maxWidth < 320
                    ? constraints.maxWidth
                    : (constraints.maxWidth - 12) / 2;

                return Wrap(
                  spacing: 12,
                  runSpacing: 12,
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
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.background,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.text,
        selectedFontSize: 11,
        unselectedFontSize: 11,
        onTap: (index) {
          if (index == 1) {
            showMessage('Use the category filters above.');
          } else if (index >= 2) {
            openLogin();
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