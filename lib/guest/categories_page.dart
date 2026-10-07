import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../resources/color_resources.dart';
import 'brand_products.dart';
import 'browse_products.dart';

/// The full list of categories and brands, read from Firestore.
/// Opened by tapping "View All" next to Categories on the Home screen.
class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: ColorResources.background,
        appBar: AppBar(
          title: Text('Categories'),
          backgroundColor: ColorResources.background,
          foregroundColor: ColorResources.primary,
          bottom: TabBar(
            labelColor: ColorResources.primary,
            unselectedLabelColor: ColorResources.text,
            indicatorColor: ColorResources.primary,
            tabs: [
              Tab(text: 'Categories'),
              Tab(text: 'Brands'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildCategories(),
            _buildBrands(),
          ],
        ),
      ),
    );
  }

  // Categories come from the "categories" collection.
  Widget _buildCategories() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('categories').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(color: ColorResources.primary),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Text(
                'Could not load categories.\n${snapshot.error}',
                textAlign: TextAlign.center,
                style: TextStyle(color: ColorResources.text),
              ),
            ),
          );
        }

        final docs = snapshot.data?.docs ?? [];

        if (docs.isEmpty) {
          return SizedBox.shrink();
        }

        return ListView(
          padding: EdgeInsets.all(16),
          children: docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            final name = '${data['name'] ?? ''}';

            return InkWell(
              onTap: () {
                // Tapping a category opens the product list for it.
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BrowseProductsPage(),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(12),
              child: Container(
                margin: EdgeInsets.only(bottom: 12),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: ColorResources.white,
                  border: Border.all(color: ColorResources.border),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: ColorResources.background,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.category_outlined,
                        color: ColorResources.primary,
                      ),
                    ),
                    SizedBox(width: 16),
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
                          SizedBox(height: 4),
                          Text(
                            '${data['description'] ?? ''}',
                            style: TextStyle(color: ColorResources.text),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: ColorResources.lightText,
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  // Brands come from the "brands" collection.
  Widget _buildBrands() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('brands').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(color: ColorResources.primary),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Text(
                'Could not load brands.\n${snapshot.error}',
                textAlign: TextAlign.center,
                style: TextStyle(color: ColorResources.text),
              ),
            ),
          );
        }

        final docs = snapshot.data?.docs ?? [];

        if (docs.isEmpty) {
          return SizedBox.shrink();
        }

        return ListView(
          padding: EdgeInsets.all(16),
          children: docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            final name = '${data['name'] ?? ''}';

            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BrandProductsPage(
                      brandName: name,
                    ),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(12),
              child: Container(
                margin: EdgeInsets.only(bottom: 12),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: ColorResources.white,
                  border: Border.all(color: ColorResources.border),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        data['image'] ?? 'assets/images/green_gold.png',
                        width: 52,
                        height: 52,
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(width: 16),
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
                          SizedBox(height: 4),
                          Text(
                            '${data['description'] ?? ''}',
                            style: TextStyle(color: ColorResources.text),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: ColorResources.lightText,
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
