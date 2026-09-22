import 'package:flutter/material.dart';
import '../resources/app_colors.dart';

class ManageBrandsPage extends StatefulWidget {
  const ManageBrandsPage({super.key});

  @override
  State<ManageBrandsPage> createState() => _ManageBrandsPageState();
}

class _ManageBrandsPageState extends State<ManageBrandsPage> {
  String search = '';

  // Sample brand information from Figma
  final brands = [
    {
      'id': 'B001',
      'name': 'Greenply',
      'description':
          'Premium quality plywood and veneers with '
          'eco-friendly certifications.',
      'image': 'assets/images/brand_greenply.png',
    },
    {
      'id': 'B002',
      'name': 'CenturyPly',
      'description':
          'Industry leader in durable plywood, laminates, '
          'and decorative veneers.',
      'image': 'assets/images/brand_century.png',
    },
    {
      'id': 'B003',
      'name': 'Kitply',
      'description':
          'Heritage brand known for high-grade marine '
          'plywood and industrial solutions.',
      'image': 'assets/images/brand_kitply.png',
    },
    {
      'id': 'B004',
      'name': 'Austin Plywood',
      'description':
          'Specialized hardwood plywood and architectural '
          'veneers for luxury interiors.',
      'image': 'assets/images/brand_austin.png',
    },
  ];

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Future<void> removeBrand(Map<String, String> brand) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: AppColors.background,
          title: Text('Remove Brand'),
          content: Text(
            'Remove ${brand['name']} from this demo list?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: Text(
                'Cancel',
                style: TextStyle(color: AppColors.primary),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, true);
              },
              child: Text(
                'Remove',
                style: TextStyle(color: AppColors.primary),
              ),
            ),
          ],
        );
      },
    );

    if (!mounted || confirmed != true) return;

    setState(() {
      brands.removeWhere(
        (item) => item['id'] == brand['id'],
      );
    });

    showMessage('Brand removed from this demo list.');
  }

  Widget brandCard(Map<String, String> brand) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  brand['image']!,
                  width: 70,
                  height: 70,
                  fit: BoxFit.contain,
                ),
              ),

              SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      brand['name']!,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),

                    SizedBox(height: 8),

                    Text(
                      brand['description']!,
                      style: TextStyle(
                        fontSize: 15,
                        height: 1.5,
                        color: AppColors.text,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 8),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                tooltip: 'Edit brand',
                onPressed: () {
                  showMessage('Edit Brand will be connected later.');
                },
                icon: Icon(
                  Icons.edit_outlined,
                  color: AppColors.primary,
                ),
              ),
              IconButton(
                tooltip: 'Remove brand',
                onPressed: () {
                  removeBrand(brand);
                },
                icon: Icon(
                  Icons.delete_outline,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredBrands = brands.where((brand) {
      return brand['name']!.toLowerCase().contains(search) ||
          brand['description']!.toLowerCase().contains(search);
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Brands'),
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.primary,
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search Brand',
                prefixIcon: Icon(
                  Icons.search,
                  color: AppColors.primary,
                ),
                filled: true,
                fillColor: AppColors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
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

            ElevatedButton.icon(
              onPressed: () {
                showMessage('Add Brand will be connected later.');
              },
              icon: Icon(Icons.add),
              label: Text('Add Brand'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.button,
                foregroundColor: AppColors.white,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),

            SizedBox(height: 12),

            Text(
              'Sample brands — database not connected',
              style: TextStyle(
                fontSize: 12,
                color: AppColors.lightText,
              ),
            ),

            SizedBox(height: 20),

            if (filteredBrands.isEmpty)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 40),
                child: Text(
                  'No brands found.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.text),
                ),
              ),

            ...filteredBrands.map(brandCard),
          ],
        ),
      ),
    );
  }
}