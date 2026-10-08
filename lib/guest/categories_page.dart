import 'package:flutter/material.dart';
import '../resources/color_resources.dart';
import '../resources/sample_data.dart';
import 'brand_products.dart';
import 'browse_products.dart';

/// The full list of categories and brands, taken from the sample data.
/// Opened by tapping "View All" next to Categories on the Home screen.
class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  Widget buildCategories(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: SampleData.categories.map((category) {
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const BrowseProductsPage(),
              ),
            );
          },
          borderRadius: BorderRadius.circular(12),
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
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
                  child: const Icon(
                    Icons.category_outlined,
                    color: ColorResources.primary,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${category['name']}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: ColorResources.primary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${category['description']}',
                        style: const TextStyle(color: ColorResources.text),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.chevron_right,
                  color: ColorResources.lightText,
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget buildBrands(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: SampleData.brands.map((brand) {
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BrandProductsPage(
                  brandName: '${brand['name']}',
                ),
              ),
            );
          },
          borderRadius: BorderRadius.circular(12),
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
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
                    brand['image'] ?? 'assets/images/green_gold.png',
                    width: 52,
                    height: 52,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${brand['name']}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: ColorResources.primary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${brand['description']}',
                        style: const TextStyle(color: ColorResources.text),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.chevron_right,
                  color: ColorResources.lightText,
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: ColorResources.background,
        appBar: AppBar(
          title: const Text('Categories'),
          backgroundColor: ColorResources.background,
          foregroundColor: ColorResources.primary,
          bottom: TabBar(
            labelColor: ColorResources.primary,
            unselectedLabelColor: ColorResources.text,
            indicatorColor: ColorResources.primary,
            tabs: const [
              Tab(text: 'Categories'),
              Tab(text: 'Brands'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            buildCategories(context),
            buildBrands(context),
          ],
        ),
      ),
    );
  }
}