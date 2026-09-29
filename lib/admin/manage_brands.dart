import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../resources/color_resources.dart';
import 'add_brand.dart';
import 'edit_brand.dart';

class ManageBrandsPage extends StatefulWidget {
  const ManageBrandsPage({super.key});

  @override
  State<ManageBrandsPage> createState() => _ManageBrandsPageState();
}

class _ManageBrandsPageState extends State<ManageBrandsPage> {
  String search = '';

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Future<void> removeBrand(String docId, String name) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: ColorResources.background,
          title: Text('Remove Brand'),
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
          .collection('brands')
          .doc(docId)
          .delete();
    } catch (error) {
      if (mounted) {
        showMessage('Could not remove the brand. $error');
      }
      return;
    }

    if (mounted) {
      showMessage('Brand removed.');
    }
  }

  Widget brandCard(String docId, Map<String, dynamic> brand) {
    final name = '${brand['name'] ?? ''}';
    final description = '${brand['description'] ?? ''}';

    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorResources.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ColorResources.border),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  brand['image'] ?? 'assets/images/green_gold.png',
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
                      name,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: ColorResources.primary,
                      ),
                    ),

                    SizedBox(height: 8),

                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 15,
                        height: 1.5,
                        color: ColorResources.text,
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditBrandPage(),
                    ),
                  );
                },
                icon: Icon(
                  Icons.edit_outlined,
                  color: ColorResources.primary,
                ),
              ),
              IconButton(
                tooltip: 'Remove brand',
                onPressed: () {
                  removeBrand(docId, name);
                },
                icon: Icon(
                  Icons.delete_outline,
                  color: ColorResources.primary,
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
    return Scaffold(
      backgroundColor: ColorResources.background,
      appBar: AppBar(
        title: Text('Brands'),
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
                      hintText: 'Search Brand',
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
                            builder: (context) => AddBrandPage(),
                          ),
                        );
                      },
                      icon: Icon(Icons.add),
                      label: Text('Add Brand'),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // StreamBuilder keeps this list live: add or remove a brand in
            // Firestore and it changes here without refreshing.
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('brands').snapshots(),
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
                        'No brands found.',
                        style: TextStyle(color: ColorResources.text),
                      ),
                    );
                  }

                  return ListView(
                    padding: EdgeInsets.all(16),
                    children: visible
                        .map((doc) => brandCard(doc.id, doc.data() as Map<String, dynamic>))
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
