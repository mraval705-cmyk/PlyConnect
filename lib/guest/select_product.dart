import 'package:flutter/material.dart';
import '../components/guest_page.dart';
import '../resources/app_colors.dart';

class SelectProductPage extends StatefulWidget {
  const SelectProductPage({super.key});

  @override
  State<SelectProductPage> createState() => _SelectProductPageState();
}

class _SelectProductPageState extends State<SelectProductPage> {
  String search = '';
  String brand = 'All';
  String thickness = 'All';
  String? selectedProduct;

  final products = [
    {
      'name': 'Greenply BWP',
      'brand': 'Greenply',
      'thickness': '19mm',
      'price': '125',
      'image': 'assets/images/compare_greenply.png',
    },
    {
      'name': 'Kitply Gold',
      'brand': 'Kitply',
      'thickness': '18mm',
      'price': '118',
      'image': 'assets/images/compare_kitply.png',
    },
    {
      'name': 'Sainik 710',
      'brand': 'CenturyPly',
      'thickness': '19mm',
      'price': '105',
      'image': 'assets/images/compare_sainik.png',
    },
    {
      'name': 'Austin Platinum',
      'brand': 'Austin',
      'thickness': '19mm',
      'price': '132',
      'image': 'assets/images/compare_austin.png',
    },
  ];

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Widget filter(
    String label,
    String value,
    List<String> options,
    ValueChanged<String?> onChanged,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          dropdownColor: AppColors.background,
          style: TextStyle(color: AppColors.primary),
          items: options.map((option) {
            return DropdownMenuItem(
              value: option,
              child: Text(option == 'All' ? label : option),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final visibleProducts = products.where((product) {
      final matchesSearch =
          product['name']!.toLowerCase().contains(search) ||
          product['brand']!.toLowerCase().contains(search);

      return matchesSearch &&
          (brand == 'All' || product['brand'] == brand) &&
          (thickness == 'All' || product['thickness'] == thickness);
    }).toList();

    return GuestPage(
      title: 'Select Product',
      selectedIndex: 1,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.button,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'assets/images/compare_selected.png',
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'SELECTED PRODUCT',
                          style: TextStyle(
                            fontSize: 11,
                            color: AppColors.buttonText,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'Club Prime Plywood',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.white,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'CenturyPly • 19mm',
                          style: TextStyle(color: AppColors.buttonText),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            TextField(
              decoration: InputDecoration(
                hintText: 'Search product to compare...',
                prefixIcon: Icon(Icons.search, color: AppColors.primary),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.border),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  search = value.trim().toLowerCase();
                });
              },
            ),

            SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: filter(
                    'Brand',
                    brand,
                    ['All', 'Greenply', 'Kitply', 'CenturyPly', 'Austin'],
                    (value) {
                      if (value == null) return;
                      setState(() {
                        brand = value;
                        selectedProduct = null;
                      });
                    },
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: filter(
                    'Thickness',
                    thickness,
                    ['All', '18mm', '19mm'],
                    (value) {
                      if (value == null) return;
                      setState(() {
                        thickness = value;
                        selectedProduct = null;
                      });
                    },
                  ),
                ),
              ],
            ),

            SizedBox(height: 24),

            Text(
              'Recommended for Comparison',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),

            SizedBox(height: 16),

            if (visibleProducts.isEmpty)
              Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  'No matching products.',
                  style: TextStyle(color: AppColors.text),
                ),
              ),

            ...visibleProducts.map((product) {
              final selected = selectedProduct == product['name'];

              return Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Material(
                  color: AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(
                      color: selected
                          ? AppColors.primary
                          : AppColors.border,
                    ),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        selectedProduct = product['name'];
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              product['image']!,
                              width: 72,
                              height: 80,
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
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.heading,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  '${product['brand']} • '
                                  '${product['thickness']}',
                                  style: TextStyle(color: AppColors.text),
                                ),
                                SizedBox(height: 6),
                                Text(
                                  '₹${product['price']} / sq.ft',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            selected
                                ? Icons.radio_button_checked
                                : Icons.radio_button_unchecked,
                            color: AppColors.primary,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),

            SizedBox(height: 12),

            ElevatedButton(
              onPressed: () {
                if (selectedProduct == null) {
                  showMessage('Please select a product first.');
                } else {
                  showMessage(
                    '$selectedProduct selected. '
                    'Comparison navigation will be connected later.',
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.button,
                foregroundColor: AppColors.white,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text('Compare Now'),
            ),
          ],
        ),
      ),
    );
  }
}