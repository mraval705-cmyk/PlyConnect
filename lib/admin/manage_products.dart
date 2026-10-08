import 'package:flutter/material.dart';
import '../resources/color_resources.dart';
import '../resources/sample_data.dart';
import 'add_product.dart';
import 'edit_product.dart';

class ManageProductsPage extends StatefulWidget {
  const ManageProductsPage({super.key});

  @override
  State<ManageProductsPage> createState() => _ManageProductsPageState();
}

class _ManageProductsPageState extends State<ManageProductsPage> {
  String search = '';

  // Ids of the products the admin ticked with the checkbox.
  final Set<String> selected = <String>{};

  // A working copy of the sample list, so removing a product keeps the
  // change for the rest of the session.
  final List<Map<String, dynamic>> products =
      List<Map<String, dynamic>>.from(SampleData.products);

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  /// Opens a yes or no question before anything is deleted.
  void askBeforeDelete(String title, VoidCallback onYes) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(title),
          content: const Text('This action cannot be undone.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                onYes();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorResources.primary,
                foregroundColor: ColorResources.white,
              ),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void removeItem(String id) {
    askBeforeDelete('Delete this product?', () {
      setState(() {
        products.removeWhere((item) => item['id'] == id);
        selected.remove(id);
      });

      showMessage('Product removed.');
    });
  }

  /// Removes every product that was ticked in one go.
  void removeSelected() {
    if (selected.isEmpty) {
      showMessage('Select at least one product first.');
      return;
    }

    askBeforeDelete('Delete ${selected.length} products?', () {
      setState(() {
        products.removeWhere((item) => selected.contains(item['id']));
        selected.clear();
      });

      showMessage('Selected products removed.');
    });
  }

  /// Ticks every product, or unticks them all when all are already ticked.
  void toggleAll(List<Map<String, dynamic>> visible) {
    final allTicked = visible.isNotEmpty &&
        visible.every((item) => selected.contains(item['id']));

    setState(() {
      if (allTicked) {
        selected.clear();
      } else {
        selected.addAll(visible.map((item) => '${item['id']}'));
      }
    });
  }

  /// Waits for the add or edit form to finish, then refreshes the list.
  Future<void> openForm(Widget page) async {
    final changed = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (context) => page),
    );

    if (changed == true) {
      setState(() {});
      showMessage('List updated.');
    }
  }

  String showPrice(dynamic value) {
    if (value is num) {
      return value.toStringAsFixed(0);
    }
    return '$value';
  }

  Widget productCard(Map<String, dynamic> product) {
    final id = '${product['id']}';

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: ColorResources.white,
        border: Border.all(color: ColorResources.border),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Checkbox to tick more than one product together.
          Checkbox(
            value: selected.contains(id),
            onChanged: (value) {
              setState(() {
                if (value == true) {
                  selected.add(id);
                } else {
                  selected.remove(id);
                }
              });
            },
          ),

          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              product['image'] ?? 'assets/images/club_prime.png',
              width: 70,
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
                  '${product['name']}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: ColorResources.heading,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  '${product['brand']}',
                  style: const TextStyle(color: ColorResources.text),
                ),

                const SizedBox(height: 8),

                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: ColorResources.background,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '${product['thickness']}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: ColorResources.text,
                        ),
                      ),
                    ),
                    Text(
                      '₹${showPrice(product['price'])}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: ColorResources.primary,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 4),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      tooltip: 'Edit product',
                      onPressed: () {
                        openForm(
                          EditProductPage(
                            items: products,
                            index: products.indexOf(product),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.edit_outlined,
                        color: ColorResources.primary,
                      ),
                    ),
                    IconButton(
                      tooltip: 'Remove product',
                      onPressed: () => removeItem(id),
                      icon: const Icon(
                        Icons.delete_outline,
                        color: ColorResources.primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // where() filters the sample list, the same way it would filter live data.
    final visible = products.where((product) {
      final name = '${product['name']}'.toLowerCase();
      final brand = '${product['brand']}'.toLowerCase();
      return name.contains(search) || brand.contains(search);
    }).toList();

    return Scaffold(
      backgroundColor: ColorResources.background,
      appBar: AppBar(
        title: const Text('Products'),
        backgroundColor: ColorResources.background,
        foregroundColor: ColorResources.primary,
      ),

      // FloatingActionButton is the quick way to add a new product.
      floatingActionButton: FloatingActionButton(
        onPressed: () => openForm(AddProductPage(items: products)),
        backgroundColor: ColorResources.primary,
        foregroundColor: ColorResources.white,
        tooltip: 'Add product',
        child: const Icon(Icons.add),
      ),

      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: 'Search Product',
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
                  ),

                  const SizedBox(width: 8),

                  ElevatedButton.icon(
                    onPressed: () => openForm(AddProductPage(items: products)),
                    icon: const Icon(Icons.add),
                    label: const Text('Add'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ],
              ),
            ),

            // The bar appears only when something is ticked.
            AnimatedSize(
              duration: const Duration(milliseconds: 250),
              child: selected.isEmpty
                  ? const SizedBox(width: double.infinity)
                  : Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      color: ColorResources.primary,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${selected.length} selected',
                            style: const TextStyle(
                              color: ColorResources.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              TextButton(
                                onPressed: () => toggleAll(visible),
                                child: const Text(
                                  'Select all',
                                  style: TextStyle(color: ColorResources.white),
                                ),
                              ),
                              TextButton(
                                onPressed: removeSelected,
                                child: const Text(
                                  'Delete',
                                  style: TextStyle(color: ColorResources.white),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
            ),

            Expanded(
              child: visible.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'No product found.',
                            style: TextStyle(color: ColorResources.text),
                          ),
                          const SizedBox(height: 12),
                          OutlinedButton.icon(
                            onPressed: () {
                              setState(() {
                                search = '';
                              });
                            },
                            icon: const Icon(Icons.refresh),
                            label: const Text('Clear search'),
                          ),
                        ],
                      ),
                    )
                  : ListView(
                      padding: const EdgeInsets.all(16),
                      children: visible.map(productCard).toList(),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}