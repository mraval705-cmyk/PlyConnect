import 'package:flutter/material.dart';
import '../resources/app_colors.dart';

class ManageCategoriesPage extends StatefulWidget {
  const ManageCategoriesPage({super.key});

  @override
  State<ManageCategoriesPage> createState() =>
      _ManageCategoriesPageState();
}

class _ManageCategoriesPageState extends State<ManageCategoriesPage> {
  String search = '';

  final categories = [
    {
      'id': 'C001',
      'name': 'MR Grade',
      'description': 'Moisture Resistant grade plywood',
    },
    {
      'id': 'C002',
      'name': 'BWR Grade',
      'description': 'Boiling Water Resistant grade',
    },
    {
      'id': 'C003',
      'name': 'BWP Grade',
      'description': 'Boiling Water Proof marine grade',
    },
    {
      'id': 'C004',
      'name': 'Commercial Plywood',
      'description': 'Standard utility grade plywood',
    },
  ];

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Future<void> removeCategory(Map<String, String> category) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: AppColors.background,
          title: Text('Remove Category'),
          content: Text(
            'Remove ${category['name']} from this demo list?',
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
      categories.removeWhere(
        (item) => item['id'] == category['id'],
      );
    });

    showMessage('Category removed from this demo list.');
  }

  Widget categoryCard(Map<String, String> category) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category['name']!,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  category['description']!,
                  style: TextStyle(
                    height: 1.4,
                    color: AppColors.text,
                  ),
                ),
              ],
            ),
          ),

          IconButton(
            tooltip: 'Edit category',
            onPressed: () {
              showMessage('Edit Category will be connected later.');
            },
            icon: Icon(
              Icons.edit_outlined,
              color: AppColors.primary,
            ),
          ),

          IconButton(
            tooltip: 'Remove category',
            onPressed: () {
              removeCategory(category);
            },
            icon: Icon(
              Icons.delete_outline,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredCategories = categories.where((category) {
      return category['name']!.toLowerCase().contains(search) ||
          category['description']!.toLowerCase().contains(search);
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Categories'),
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.primary,
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search Category',
                prefixIcon: Icon(
                  Icons.search,
                  color: AppColors.primary,
                ),
                filled: true,
                fillColor: AppColors.white,
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

            ElevatedButton.icon(
              onPressed: () {
                showMessage('Add Category will be connected later.');
              },
              icon: Icon(Icons.add),
              label: Text('Add Category'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.button,
                foregroundColor: AppColors.white,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            SizedBox(height: 12),

            Text(
              'Sample categories — database not connected',
              style: TextStyle(
                fontSize: 12,
                color: AppColors.lightText,
              ),
            ),

            SizedBox(height: 20),

            if (filteredCategories.isEmpty)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 40),
                child: Text(
                  'No categories found.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.text),
                ),
              ),

            ...filteredCategories.map(categoryCard),
          ],
        ),
      ),
    );
  }
}