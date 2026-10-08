import 'package:flutter/material.dart';
import '../resources/color_resources.dart';
import '../resources/sample_data.dart';
import '../user/my_orders.dart';
import '../user/my_profile.dart';
import '../user/wishlist.dart';
import 'home.dart';
import 'product_details.dart';

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

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void openPage(Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  String showPrice(dynamic value) {
    if (value is num) {
      return value.toStringAsFixed(0);
    }
    return '$value';
  }

  /// A price may be stored as a number or as text, so it is read the same
  /// way every time before sorting.
  double readPrice(Map<String, dynamic> item) {
    final value = item['price'];
    if (value is num) {
      return value.toDouble();
    }
    return double.tryParse('$value') ?? 0;
  }

  /// The same filtering the design shows, applied to the sample list.
  List<Map<String, dynamic>> filtered() {
    final result = SampleData.products.where((item) {
      final name = '${item['name']}'.toLowerCase();
      final itemBrand = '${item['brand']}';
      final itemCategory = '${item['category']}';
      final itemThickness = '${item['thickness']}';

      final matchesSearch =
          name.contains(search) || itemBrand.toLowerCase().contains(search);
      final matchesCategory =
          category == 'All' || itemCategory == category;
      final matchesBrand = brand == 'All' || itemBrand == brand;
      final matchesThickness =
          thickness == 'All' || itemThickness == thickness;

      return matchesSearch &&
          matchesCategory &&
          matchesBrand &&
          matchesThickness;
    }).toList();

    // sort() puts the cheapest or the dearest product first.
    if (priceOrder == 'Low to High') {
      result.sort((a, b) => readPrice(a).compareTo(readPrice(b)));
    } else if (priceOrder == 'High to Low') {
      result.sort((a, b) => readPrice(b).compareTo(readPrice(a)));
    }

    return result;
  }

  Widget filterBox(
    String title,
    String selected,
    List<String> options,
    ValueChanged<String?> onChanged,
  ) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: ColorResources.white,
        border: Border.all(color: ColorResources.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selected,
          dropdownColor: ColorResources.background,
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: ColorResources.primary,
          ),
          style: const TextStyle(fontSize: 12, color: ColorResources.primary),
          selectedItemBuilder: (context) {
            return options.map((option) {
              return Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  option == 'All' || option == 'Default' ? title : option,
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

  Widget productCard(Map<String, dynamic> product) {
    final price = showPrice(product['price']);

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: ColorResources.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ColorResources.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              Image.asset(
                product['image'] ?? 'assets/images/club_prime.png',
                width: double.infinity,
                height: 170,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  decoration: BoxDecoration(
                    color: ColorResources.background,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    tooltip: 'Save product',
                    icon: const Icon(
                      Icons.favorite_border,
                      color: ColorResources.primary,
                    ),
                    onPressed: () {
                      showMessage('Please log in to save products.');
                    },
                  ),
                ),
              ),
            ],
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
                    color: ColorResources.lightText,
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
                const SizedBox(height: 6),
                Text(
                  '${product['thickness']}',
                  style: const TextStyle(fontSize: 12, color: ColorResources.text),
                ),
                const SizedBox(height: 16),
                Text(
                  '₹$price / sq.ft',
                  style: const TextStyle(
                    fontSize: 15,
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
                            product: {
                              'name': '${product['name']}',
                              'brand': '${product['brand']}',
                              'category': '${product['category']}',
                              'thickness': '${product['thickness']}',
                              'price': '₹$price / sq.ft',
                              'image': '${product['image']}',
                            },
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
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

  Widget buildFilterRow() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          filterBox(
            'Category',
            category,
            const ['All', 'Marine', 'HDHMR', 'Birch', 'Commercial'],
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
            const [
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
            const ['All', '12mm', '16mm', '18mm', '19mm'],
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
            const ['Default', 'Low to High', 'High to Low'],
            (value) {
              if (value == null) return;
              setState(() {
                priceOrder = value;
              });
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final visible = filtered();

    return Scaffold(
      backgroundColor: ColorResources.background,

      appBar: AppBar(
        title: const Text('Browse Products'),
        backgroundColor: ColorResources.background,
        foregroundColor: ColorResources.primary,
        actions: [
          IconButton(
            tooltip: 'Profile',
            icon: const Icon(Icons.person_outline),
            onPressed: () => openPage(const MyProfilePage()),
          ),
        ],
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  decoration: const InputDecoration(
                    hintText: 'Search plywood types, brands...',
                    prefixIcon: Icon(
                      Icons.search,
                      color: ColorResources.primary,
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      search = value.trim().toLowerCase();
                    });
                  },
                ),
                const SizedBox(height: 16),
                buildFilterRow(),
              ],
            ),
          ),

          const SizedBox(height: 8),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    '${visible.length} products',
                    style: const TextStyle(color: ColorResources.text),
                  ),

                  const SizedBox(height: 16),

                  if (visible.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 40),
                      child: Text(
                        'No products match your search or filters.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: ColorResources.text),
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
                        children: visible.map((item) {
                          return SizedBox(
                            width: width,
                            child: productCard(item),
                          );
                        }).toList(),
                      );
                    },
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        type: BottomNavigationBarType.fixed,
        backgroundColor: ColorResources.background,
        selectedItemColor: ColorResources.primary,
        unselectedItemColor: ColorResources.text,
        selectedFontSize: 11,
        unselectedFontSize: 11,
        onTap: (index) {
          if (index == 0) {
            openPage(const GuestHomePage());
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