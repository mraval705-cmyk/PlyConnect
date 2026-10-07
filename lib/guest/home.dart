import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../login.dart';
import '../resources/color_resources.dart';
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

  // The category chips are still a fixed list, because they describe the
  // shop sections. The products themselves now come from Firestore.
  String showPrice(dynamic value) {
    if (value is num) {
      return '₹${value.toStringAsFixed(0)} / sq.ft';
    }
    return '₹$value / sq.ft';
  }

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

  void openBrowse() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BrowseProductsPage(),
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
                    color: ColorResources.text,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  product['name']!,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: ColorResources.heading,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  product['price']!,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: ColorResources.primary,
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
                      backgroundColor: ColorResources.primary,
                      foregroundColor: ColorResources.white,
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

  // Kept for the same filtering as the design, now applied to Firestore docs.
  List<QueryDocumentSnapshot> filterProducts(List<QueryDocumentSnapshot> docs) {
    return docs.where((doc) {
      final data = doc.data() as Map<String, dynamic>;
      final name = '${data['name'] ?? ''}'.toLowerCase();
      final brand = '${data['brand'] ?? ''}'.toLowerCase();
      final category = '${data['category'] ?? ''}';

      final matchesSearch = name.contains(search) || brand.contains(search);
      final matchesCategory =
          selectedCategory == 'All' || category == selectedCategory;

      return matchesSearch && matchesCategory;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.background,

      appBar: AppBar(
        title: Text('PlyConnect'),
        backgroundColor: ColorResources.background,
        foregroundColor: ColorResources.primary,
        actions: [
          IconButton(
            tooltip: 'Notifications',
            icon: Icon(Icons.notifications_none),
            onPressed: () {
              showMessage('Please log in to view notifications.');
            },
          ),
          IconButton(
            tooltip: 'My Profile',
            icon: Icon(Icons.person_outline),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MyProfilePage(),
                ),
              );
            },
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
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search plywood products...',
                prefixIcon: Icon(
                  Icons.search,
                  color: ColorResources.primary,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: ColorResources.border),
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
                    // "View All" opens the full category list, which is
                    // read from the same Firestore collection.
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CategoriesPage(),
                      ),
                    );
                  },
                  child: Text(
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
                  final selected =
                      selectedCategory == categories[index];

                  return Padding(
                    padding: EdgeInsets.only(right: 12),
                    child: InkWell(
                      onTap: () {
                        // Tapping a category filters the products below it,
                        // so the matching products appear on the same screen.
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
                            SizedBox(height: 8),
                            Text(
                              categories[index],
                              style: TextStyle(
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
                      ColorResources.primary,
                      ColorResources.primary.withAlpha(70),
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
                        color: ColorResources.buttonText,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Ultra-Core\nPremium Plywood',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: ColorResources.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Starting from ₹95 / sq.ft',
                      style: TextStyle(color: ColorResources.white),
                    ),
                    SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: openBrowse,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorResources.white,
                        foregroundColor: ColorResources.primary,
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

            // Brands come from Firestore, so tapping one opens that brand's
            // own product list.
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('brands')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return SizedBox.shrink();
                }

                final docs = snapshot.data?.docs ?? [];

                if (docs.isEmpty) {
                  return SizedBox.shrink();
                }

                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: docs.map((doc) {
                      final data = doc.data() as Map<String, dynamic>;
                      final brandName = '${data['name'] ?? ''}';

                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BrandProductsPage(
                                brandName: brandName,
                              ),
                            ),
                          );
                        },
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          margin: EdgeInsets.only(right: 12),
                          padding: EdgeInsets.symmetric(
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
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: ColorResources.primary,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                );
              },
            ),

            SizedBox(height: 24),
            heading('Popular Products'),
            SizedBox(height: 16),

            // Products are read live from Firestore.
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('products')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: CircularProgressIndicator(
                        color: ColorResources.primary,
                      ),
                    ),
                  );
                }

                if (snapshot.hasError) {
                  return Text(
                    'Could not load products.',
                    style: TextStyle(color: ColorResources.text),
                  );
                }

                final docs = snapshot.data?.docs ?? [];
                final visible = filterProducts(docs);

                if (visible.isEmpty) {
                  return SizedBox.shrink();
                }

                return LayoutBuilder(
                  builder: (context, constraints) {
                    final width = constraints.maxWidth < 320
                        ? constraints.maxWidth
                        : (constraints.maxWidth - 12) / 2;

                    return Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: visible.map((doc) {
                        final data = doc.data() as Map<String, dynamic>;

                        return productCard(
                          {
                            'name': '${data['name'] ?? ''}',
                            'brand': '${data['brand'] ?? ''}',
                            'category': '${data['category'] ?? ''}',
                            'thickness': '${data['thickness'] ?? ''}',
                            'price': showPrice(data['price']),
                            'image': '${data['image'] ?? ''}',
                          },
                          width,
                        );
                      }).toList(),
                    );
                  },
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
        backgroundColor: ColorResources.background,
        selectedItemColor: ColorResources.primary,
        unselectedItemColor: ColorResources.text,
        selectedFontSize: 11,
        unselectedFontSize: 11,
        onTap: (index) {
          if (index == 1) {
            openBrowse();
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
          } else if (index == 4) {
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