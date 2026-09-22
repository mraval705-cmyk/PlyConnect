import 'package:flutter/material.dart';
import '../components/guest_page.dart';
import '../resources/app_colors.dart';

class CompareProductsPage extends StatelessWidget {
  const CompareProductsPage({super.key});

  void showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Widget productCard(String image, String brand, String name) {
    return Container(
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
            image,
            height: 150,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  brand,
                  style: TextStyle(
                    fontSize: 11,
                    color: AppColors.text,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget tableCell(String text, bool bold) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 13,
          fontWeight: bold ? FontWeight.bold : FontWeight.normal,
          color: AppColors.text,
        ),
      ),
    );
  }

  TableRow comparisonRow(String title, String first, String second) {
    return TableRow(
      children: [
        tableCell(title, true),
        tableCell(first, false),
        tableCell(second, false),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GuestPage(
      title: 'Compare Products',
      selectedIndex: 1,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: productCard(
                    'assets/images/bwp_marine.png',
                    'CENTURYPLY',
                    'Club Prime Plywood',
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: productCard(
                    'assets/images/green_gold.png',
                    'GREENPLY',
                    'Green Gold BWP',
                  ),
                ),
              ],
            ),

            SizedBox(height: 24),

            Text(
              'Sample comparison from the design',
              style: TextStyle(
                fontSize: 12,
                color: AppColors.lightText,
              ),
            ),

            SizedBox(height: 8),

            LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: constraints.maxWidth < 340
                        ? 340
                        : constraints.maxWidth,
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Table(
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        border: TableBorder(
                          horizontalInside: BorderSide(
                            color: AppColors.border,
                          ),
                        ),
                        children: [
                          TableRow(
                            decoration: BoxDecoration(
                              color: AppColors.border,
                            ),
                            children: [
                              tableCell('Specification', true),
                              tableCell('Product A', true),
                              tableCell('Product B', true),
                            ],
                          ),
                          comparisonRow(
                            'Category',
                            'Marine Grade',
                            'Boiling Water Proof',
                          ),
                          comparisonRow('Thickness', '19 mm', '18 mm'),
                          comparisonRow('Size', '8 × 4 ft', '8 × 4 ft'),
                          comparisonRow('Material', 'Gurjan', 'Hardwood'),
                          comparisonRow(
                            'Water Resistance',
                            'Boiling Water Marine',
                            'BWP Grade',
                          ),
                          comparisonRow('Warranty', 'Lifetime', '25 Years'),
                          comparisonRow(
                            'Approx. Price',
                            '₹145 / sq.ft',
                            '₹138 / sq.ft',
                          ),
                          comparisonRow(
                            'Availability',
                            'In Stock',
                            'In Stock',
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),

            SizedBox(height: 24),

            ElevatedButton(
              onPressed: () {
                showMessage(context, 'Contact page will be connected later.');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.button,
                foregroundColor: AppColors.white,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Contact Shop',
                style: TextStyle(fontSize: 18),
              ),
            ),

            SizedBox(height: 12),

            OutlinedButton(
              onPressed: () {
                showMessage(context, 'Products page will be connected later.');
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primary,
                side: BorderSide(color: AppColors.primary),
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text('Back to Products'),
            ),
          ],
        ),
      ),
    );
  }
}