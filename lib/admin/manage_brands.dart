import 'package:flutter/material.dart';
import '../resources/color_resources.dart';
import '../resources/sample_data.dart';
import 'add_brand.dart';
import 'edit_brand.dart';

class ManageBrandsPage extends StatefulWidget {
  const ManageBrandsPage({super.key});

  @override
  State<ManageBrandsPage> createState() => _ManageBrandsPageState();
}

class _ManageBrandsPageState extends State<ManageBrandsPage> {
  String search = '';

  // A working copy of the sample list, so removing a brand keeps the change
  // for the rest of the session.
  final List<Map<String, dynamic>> brands =
      List<Map<String, dynamic>>.from(SampleData.brands);

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void removeItem(String id) {
    setState(() {
      brands.removeWhere((item) => item['id'] == id);
    });

    showMessage('Brand removed.');
  }

  Widget brandCard(Map<String, dynamic> brand) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
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

              const SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${brand['name']}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: ColorResources.primary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${brand['description']}',
                      style: const TextStyle(
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

          const SizedBox(height: 8),

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
                icon: const Icon(
                  Icons.edit_outlined,
                  color: ColorResources.primary,
                ),
              ),
              IconButton(
                tooltip: 'Remove brand',
                onPressed: () => removeItem('${brand['id']}'),
                icon: const Icon(
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
    // where() filters the sample list, the same way it would filter live data.
    final visible = brands.where((brand) {
      final name = '${brand['name']}'.toLowerCase();
      final description = '${brand['description']}'.toLowerCase();
      return name.contains(search) || description.contains(search);
    }).toList();

    return Scaffold(
      backgroundColor: ColorResources.background,
      appBar: AppBar(
        title: const Text('Brands'),
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

                  const SizedBox(height: 16),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // The list is given, so the new brand is added to it.
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddBrandPage(
                              items: brands,
                            ),
                          ),
                        ).then((changed) {
                          if (changed == true) {
                            setState(() {});
                          }
                        });
                      },
                      icon: const Icon(Icons.add),
                      label: const Text('Add Brand'),
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
                      children: visible.map(brandCard).toList(),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}