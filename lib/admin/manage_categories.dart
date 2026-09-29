import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../resources/color_resources.dart';
import 'add_category.dart';
import 'edit_category.dart';

class ManageCategoriesPage extends StatefulWidget {
  const ManageCategoriesPage({super.key});

  @override
  State<ManageCategoriesPage> createState() => _ManageCategoriesPageState();
}

class _ManageCategoriesPageState extends State<ManageCategoriesPage> {
  String search = '';

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Future<void> removeCategory(String docId, String name) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: ColorResources.background,
          title: Text('Remove Category'),
          content: Text('Remove $name from the database?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: Text(
                'Cancel',
                style: TextStyle(color: ColorResources.primary),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, true);
              },
              child: Text(
                'Remove',
                style: TextStyle(color: ColorResources.primary),
              ),
            ),
          ],
        );
      },
    );

    if (!mounted || confirmed != true) {
      return;
    }

    try {
      await FirebaseFirestore.instance
          .collection('categories')
          .doc(docId)
          .delete();
    } catch (error) {
      if (mounted) {
        showMessage('Could not remove the category. $error');
      }
      return;
    }

    if (mounted) {
      showMessage('Category removed.');
    }
  }

  Widget categoryCard(String docId, Map<String, dynamic> category) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
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
                  '${category['name'] ?? ''}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: ColorResources.primary,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '${category['description'] ?? ''}',
                  style: TextStyle(
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
            icon: Icon(
              Icons.edit_outlined,
              color: ColorResources.primary,
            ),
          ),

          IconButton(
            tooltip: 'Remove category',
            onPressed: () {
              removeCategory(docId, '${category['name'] ?? ''}');
            },
            icon: Icon(
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
    return Scaffold(
      backgroundColor: ColorResources.background,
      appBar: AppBar(
        title: Text('Categories'),
        backgroundColor: ColorResources.background,
        foregroundColor: ColorResources.primary,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
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

                  SizedBox(height: 16),

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
                      icon: Icon(Icons.add),
                      label: Text('Add Category'),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('categories')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: ColorResources.primary,
                      ),
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

                  final visible = docs.where((doc) {
                    final data = doc.data() as Map<String, dynamic>;
                    final name = '${data['name'] ?? ''}'.toLowerCase();
                    final description =
                        '${data['description'] ?? ''}'.toLowerCase();
                    return name.contains(search) || description.contains(search);
                  }).toList();

                  if (visible.isEmpty) {
                    return Center(
                      child: Text(
                        'No categories found.',
                        style: TextStyle(color: ColorResources.text),
                      ),
                    );
                  }

                  return ListView(
                    padding: EdgeInsets.all(16),
                    children: visible
                        .map((doc) => categoryCard(
                              doc.id,
                              doc.data() as Map<String, dynamic>,
                            ))
                        .toList(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
