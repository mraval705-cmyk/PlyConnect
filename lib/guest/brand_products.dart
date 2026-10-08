import 'package:flutter/material.dart';
import '../resources/color_resources.dart';
import '../resources/sample_data.dart';
import 'product_details.dart';

/// Shows every product that belongs to one brand.
/// Opened by tapping a brand on the Home screen.
class BrandProductsPage extends StatelessWidget {
  final String brandName;

  const BrandProductsPage({
    super.key,
    required this.brandName,
  });

  String showPrice(dynamic value) {
    if (value is num) {
      return value.toStringAsFixed(0);
    }
    return '$value';
  }

  @override
  Widget build(BuildContext context) {
    // The sample list is filtered with where().
    // The brand name is compared in lower case, because a product writes the
    // brand in capitals while the brand list writes it in normal case.
    final list = SampleData.products.where((item) {
      return '${item['brand']}'.toLowerCase() == brandName.toLowerCase();
    }).toList();

    return Scaffold(
      backgroundColor: ColorResources.background,
      appBar: AppBar(
        title: Text(brandName),
        backgroundColor: ColorResources.background,
        foregroundColor: ColorResources.primary,
      ),
      body: list.isEmpty
          ? const SizedBox.shrink()
          : ListView(
              padding: const EdgeInsets.all(16),
              children: list.map((item) {
                final price = showPrice(item['price']);

                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(12),
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
                          item['image'] ?? 'assets/images/club_prime.png',
                          width: 80,
                          height: 90,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${item['name']}',
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: ColorResources.heading,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              '${item['thickness']}',
                              style: const TextStyle(color: ColorResources.text),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '₹$price / sq.ft',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: ColorResources.primary,
                              ),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              width: double.infinity,
                              child: OutlinedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProductDetailsPage(
                                        product: {
                                          'name': '${item['name']}',
                                          'brand': '${item['brand']}',
                                          'category': '${item['category']}',
                                          'thickness': '${item['thickness']}',
                                          'price': '₹$price / sq.ft',
                                          'image': '${item['image']}',
                                        },
                                      ),
                                    ),
                                  );
                                },
                                style: OutlinedButton.styleFrom(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
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
              }).toList(),
            ),
    );
  }
}