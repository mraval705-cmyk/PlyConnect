import 'package:flutter/material.dart';
import '../resources/color_resources.dart';
import '../resources/sample_data.dart';
import 'add_category.dart';
import 'edit_category.dart';

class ManageCategoriesPage extends StatefulWidget {
  const ManageCategoriesPage({super.key});

  @override
  State<ManageCategoriesPage> createState() => _ManageCategoriesPageState();
}

class _ManageCategoriesPageState extends State<ManageCategoriesPage> {
  String search = '';

  // A working copy of the sample list, so removing a category keeps the
  // change for the rest of the session.
  final List<Map<String, dynamic>> categories =
      List<Map<String, dynamic>>.from(SampleData.categories);

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void removeItem(String id) {
    setState(() {
      categories.removeWhere((item) => item['id'] == id);
    });

    showMessage('Category removed.');
  }

  Widget categoryCard(Map<String, dynamic> category) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorResources.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ColorResources.border),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${category['name']}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: ColorResources.primary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${category['description']}',
                  style: const TextStyle(
                    height: 1.4,
                    color: ColorResources.text,
                  ),
                ),
              ],
            ),
          ),

          IconButton(
            tooltip: 'Edit category',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditCategoryPage(),
                ),
              );
            },
            icon: const Icon(
              Icons.edit_outlined,
              color: ColorResources.primary,
            ),
          ),

          IconButton(
            tooltip: 'Remove category',
            onPressed: () => removeItem('${category['id']}'),
            icon: const Icon(
              Icons.delete_outline,
              color: ColorResources.primary,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // where() filters the sample list, the same way it would filter live data.
    final visible = categories.where((category) {
      final name = '${category['name']}'.toLowerCase();
      final description = '${category['description']}'.toLowerCase();
      return name.contains(search) || description.contains(search);
    }).toList();

    return Scaffold(
      backgroundColor: ColorResources.background,
      appBar: AppBar(
        title: const Text('Categories'),
        backgroundColor: ColorResources.background,
        foregroundColor: ColorResources.primary,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                    decoration: const InputDecoration(
                      hintText: 'Search Category',
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

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddCategoryPage(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.add),
                      label: const Text('Add Category'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: visible.isEmpty
                  ? const SizedBox.shrink()
                  : ListView(
                      padding: const EdgeInsets.all(16),
                      children: visible.map(categoryCard).toList(),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}