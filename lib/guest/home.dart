import 'package:flutter/material.dart';
import '../login.dart';
import '../resources/color_resources.dart';
import '../resources/sample_data.dart';
import '../user/my_orders.dart';
import '../user/my_profile.dart';
import '../user/wishlist.dart';
import 'brand_products.dart';
import 'browse_products.dart';
import 'categories_page.dart';
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

  void openPage(Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  String showPrice(dynamic value) {
    if (value is num) {
      return '₹${value.toStringAsFixed(0)} / sq.ft';
    }
    return '₹$value / sq.ft';
  }

  /// The same filtering the design shows, applied to the sample list.
  ///
  /// The category is compared in lower case, because a product and a chip do
  /// not always write it the same way.
  List<Map<String, dynamic>> filterProducts() {
    return SampleData.products.where((item) {
      final name = '${item['name']}'.toLowerCase();
      final brand = '${item['brand']}'.toLowerCase();
      final category = '${item['category']}'.toLowerCase();

      final matchesSearch = name.contains(search) || brand.contains(search);
      final matchesCategory = selectedCategory == 'All' ||
          category == selectedCategory.toLowerCase();

      return matchesSearch && matchesCategory;
    }).toList();
  }

  Widget heading(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: ColorResources.heading,
      ),
    );
  }

  Widget productCard(Map<String, String> product, double width) {
    return Container(
      width: width,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: ColorResources.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ColorResources.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(
            product['image'] ?? 'assets/images/club_prime.png',
            height: 160,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${product['brand']}',
                  style: const TextStyle(
                    fontSize: 10,
                    color: ColorResources.text,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${product['name']}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: ColorResources.heading,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${product['price']}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: ColorResources.primary,
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailsPage(
                            product: product,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorResources.primary,
                      foregroundColor: ColorResources.white,
                      padding:
                          const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('View Details'),
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
    final visible = filterProducts();

    return Scaffold(
      backgroundColor: ColorResources.background,

      appBar: AppBar(
        title: const Text('PlyConnect'),
        backgroundColor: ColorResources.background,
        foregroundColor: ColorResources.primary,
        actions: [
          IconButton(
            tooltip: 'Notifications',
            icon: const Icon(Icons.notifications_none),
            onPressed: () {
              showMessage('Please log in to view notifications.');
            },
          ),
          IconButton(
            tooltip: 'My Profile',
            icon: const Icon(Icons.person_outline),
            onPressed: () => openPage(const MyProfilePage()),
          ),
        ],
      ),

      drawer: Drawer(
        backgroundColor: ColorResources.background,
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Padding(
                padding: const EdgeInsets.all(24),
                child: heading('PlyConnect'),
              ),
              ListTile(
                leading: const Icon(Icons.home_outlined),
                title: const Text('Home'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.login),
                title: const Text('Login / Sign Up'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: const InputDecoration(
                hintText: 'Search plywood products...',
                prefixIcon: Icon(Icons.search, color: ColorResources.primary),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  search = value.trim().toLowerCase();
                });
              },
            ),

            const SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                heading('Categories'),
                TextButton(
                  onPressed: () => openPage(const CategoriesPage()),
                  child: const Text(
                    'View All',
                    style: TextStyle(color: ColorResources.primary),
                  ),
                ),
              ],
            ),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(categories.length, (index) {
                  final selected = selectedCategory == categories[index];

                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: InkWell(
                      onTap: () {
                        // Tapping a category filters the products below.
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
                                    ? ColorResources.primary
                                    : ColorResources.border,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Icon(
                                categoryIcons[index],
                                color: selected
                                    ? ColorResources.white
                                    : ColorResources.primary,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              categories[index],
                              style: const TextStyle(
                                fontSize: 12,
                                color: ColorResources.text,
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

            const SizedBox(height: 24),

            Container(
              width: double.infinity,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: const DecorationImage(
                  image: AssetImage('assets/images/home_banner.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      ColorResources.primary,
                      ColorResources.primary.withAlpha(70),
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'NEW ARRIVAL',
                      style: TextStyle(
                        fontSize: 12,
                        color: ColorResources.buttonText,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Ultra-Core\nPremium Plywood',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: ColorResources.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Starting from ₹95 / sq.ft',
                      style: TextStyle(color: ColorResources.white),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () => openPage(const BrowseProductsPage()),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorResources.white,
                        foregroundColor: ColorResources.primary,
                      ),
                      child: const Text('Explore Now'),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),
            heading('Trusted Brands'),
            const SizedBox(height: 12),

            // The brand strip comes from the sample list.
            SizedBox(
              height: 70,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: SampleData.brands.length,
                itemBuilder: (context, index) {
                  final brandName = '${SampleData.brands[index]['name']}';

                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                BrandProductsPage(brandName: brandName),
                          ),
                        );
                      },
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 18,
                        ),
                        decoration: BoxDecoration(
                          color: ColorResources.white,
                          border: Border.all(color: ColorResources.border),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          brandName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ColorResources.primary,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 24),
            heading('Popular Products'),
            const SizedBox(height: 16),

            if (visible.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: Text(
                  'No matching products.',
                  style: TextStyle(color: ColorResources.text),
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
                  children: visible.map((item) {
                    return productCard(
                      {
                        'name': '${item['name']}',
                        'brand': '${item['brand']}',
                        'category': '${item['category']}',
                        'thickness': '${item['thickness']}',
                        'price': showPrice(item['price']),
                        'image': '${item['image']}',
                      },
                      width,
                    );
                  }).toList(),
                );
              },
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
            openPage(const BrowseProductsPage());
          } else if (index == 2) {
            openPage(const WishlistPage());
          } else if (index == 3) {
            openPage(const MyOrdersPage());
          } else if (index == 4) {
            openPage(const MyProfilePage());
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