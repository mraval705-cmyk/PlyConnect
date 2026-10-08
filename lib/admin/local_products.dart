import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../resources/color_resources.dart';

/// One product as a Dart object. This is the class idea from the reading
/// material: fields, a constructor and methods instead of loose values.
class Product {
  String name;
  String brand;
  String category;
  String thickness;
  String price;
  String image;

  Product({
    required this.name,
    required this.brand,
    required this.category,
    required this.thickness,
    required this.price,
    required this.image,
  });

  // Firestore document  →  Product object
  factory Product.fromMap(Map<String, dynamic> data) {
    return Product(
      name: '${data['name'] ?? ''}',
      brand: '${data['brand'] ?? ''}',
      category: '${data['category'] ?? ''}',
      thickness: '${data['thickness'] ?? ''}',
      price: '${data['price'] ?? 0}',
      image: '${data['image'] ?? 'assets/images/club_prime.png'}',
    );
  }

  // Product object  →  a plain map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'brand': brand,
      'category': category,
      'thickness': thickness,
      'price': price,
      'image': image,
    };
  }

  // Product object  →  json text, for shared_preferences
  String toJson() {
    return jsonEncode(toMap());
  }

  // json text  →  Product object
  factory Product.fromJson(String text) {
    return Product.fromMap(jsonDecode(text) as Map<String, dynamic>);
  }
}

/// ---------------------------------------------------------------------------
/// A separate widget for ONE registered product.
/// Each row on the screen is built from this class, so the list is only a
/// list of these widgets. Deleting removes the product from the list and
/// this widget is destroyed with it.
/// ---------------------------------------------------------------------------
class ProductCard extends StatelessWidget {
  final int index;
  final Product product;
  final bool isEditing;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ProductCard({
    super.key,
    required this.index,
    required this.product,
    required this.isEditing,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: ColorResources.white,
        border: Border.all(
          color: isEditing ? ColorResources.primary : ColorResources.border,
          width: isEditing ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // The index is the key, so it is shown on the left.
          Container(
            width: 34,
            height: 34,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: ColorResources.background,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '$index',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: ColorResources.primary,
              ),
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: ColorResources.heading,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${product.brand} • ${product.category} • '
                  '${product.thickness}',
                  style: TextStyle(fontSize: 12, color: ColorResources.text),
                ),
                const SizedBox(height: 4),
                Text(
                  '₹${product.price}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: ColorResources.primary,
                  ),
                ),
              ],
            ),
          ),

          IconButton(
            tooltip: 'Edit product',
            onPressed: onEdit,
            icon: Icon(Icons.edit_outlined, color: ColorResources.primary),
          ),
          IconButton(
            tooltip: 'Delete product',
            onPressed: onDelete,
            icon: Icon(Icons.delete_outline, color: ColorResources.danger),
          ),
        ],
      ),
    );
  }
}

/// ---------------------------------------------------------------------------
/// A separate widget for the register / update form.
/// ---------------------------------------------------------------------------
class ProductForm extends StatelessWidget {
  final int editIndex;
  final TextEditingController nameController;
  final TextEditingController brandController;
  final TextEditingController categoryController;
  final TextEditingController thicknessController;
  final TextEditingController priceController;
  final TextEditingController imageController;
  final VoidCallback onSubmit;
  final VoidCallback onClear;

  const ProductForm({
    super.key,
    required this.editIndex,
    required this.nameController,
    required this.brandController,
    required this.categoryController,
    required this.thicknessController,
    required this.priceController,
    required this.imageController,
    required this.onSubmit,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    final isEditing = editIndex >= 0;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorResources.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ColorResources.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            isEditing
                ? 'UPDATE PRODUCT AT INDEX $editIndex'
                : 'REGISTER A NEW PRODUCT',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: ColorResources.primary,
            ),
          ),
          const SizedBox(height: 12),

          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Product Name'),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: brandController,
            decoration: const InputDecoration(labelText: 'Brand'),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: categoryController,
            decoration: const InputDecoration(labelText: 'Category'),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: thicknessController,
            decoration: const InputDecoration(labelText: 'Thickness'),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: priceController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Price'),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: imageController,
            decoration: const InputDecoration(
              labelText: 'Image path',
              hintText: 'assets/images/club_prime.png',
            ),
          ),

          const SizedBox(height: 14),

          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: onSubmit,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: Text(isEditing ? 'Update' : 'Register'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton(
                  onPressed: onClear,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text('Clear'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// ---------------------------------------------------------------------------
/// The page. It owns the list of Product objects and the index key.
///   Register  →  adds a Product, the new ProductCard appears
///   Update    →  replaces the Product at the given index
///   Delete    →  removes the Product, its ProductCard is destroyed
///   Save      →  writes the list to shared_preferences
///   Load      →  reads the list back from shared_preferences
/// ---------------------------------------------------------------------------
class LocalProductsPage extends StatefulWidget {
  const LocalProductsPage({super.key});

  @override
  State<LocalProductsPage> createState() => _LocalProductsPageState();
}

class _LocalProductsPageState extends State<LocalProductsPage> {
  // The registered list. It starts empty every time the app opens.
  final List<Product> products = [];

  final nameController = TextEditingController();
  final brandController = TextEditingController();
  final categoryController = TextEditingController();
  final thicknessController = TextEditingController();
  final priceController = TextEditingController();
  final imageController = TextEditingController();

  // The key. -1 means nothing is being edited, a real number means the
  // product at that position is being edited.
  int editIndex = -1;

  bool isBusy = false;

  // The key used inside shared_preferences.
  static const String storageKey = 'plyconnect_local_products';

  @override
  void initState() {
    super.initState();

    // The list is filled straight away from shared_preferences, so the
    // registered products are still there after the app is closed.
    loadFromStorage();
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void clearForm() {
    nameController.clear();
    brandController.clear();
    categoryController.clear();
    thicknessController.clear();
    priceController.clear();
    imageController.clear();
    editIndex = -1;
  }

  // Registers a new product. It is added to the end of the list.
  void registerProduct() {
    if (nameController.text.trim().isEmpty) {
      showMessage('Please enter a product name.');
      return;
    }

    setState(() {
      products.add(
        Product(
          name: nameController.text.trim(),
          brand: brandController.text.trim(),
          category: categoryController.text.trim(),
          thickness: thicknessController.text.trim(),
          price: priceController.text.trim(),
          image: imageController.text.trim().isEmpty
              ? 'assets/images/club_prime.png'
              : imageController.text.trim(),
        ),
      );
    });

    clearForm();
    showMessage('Registered.');
  }

  // Replaces the product that sits at the given index.
  void updateProduct(int index) {
    if (index < 0 || index >= products.length) {
      showMessage('That product no longer exists.');
      return;
    }

    if (nameController.text.trim().isEmpty) {
      showMessage('Please enter a product name.');
      return;
    }

    setState(() {
      products[index] = Product(
        name: nameController.text.trim(),
        brand: brandController.text.trim(),
        category: categoryController.text.trim(),
        thickness: thicknessController.text.trim(),
        price: priceController.text.trim(),
        image: imageController.text.trim().isEmpty
            ? 'assets/images/club_prime.png'
            : imageController.text.trim(),
      );
    });

    clearForm();
    showMessage('Updated at index $index.');
  }

  // Removes the product at the given index. Its widget is destroyed.
  void deleteProduct(int index) {
    if (index < 0 || index >= products.length) {
      showMessage('That product no longer exists.');
      return;
    }

    final removed = products[index].name;

    setState(() {
      products.removeAt(index);
    });

    // The list shifted, so the editing index has to shift as well.
    if (editIndex == index) {
      clearForm();
    } else if (editIndex > index) {
      setState(() {
        editIndex = editIndex - 1;
      });
    }

    showMessage('$removed deleted from index $index.');
  }

  // Puts a product into the form so it can be changed.
  void startEditing(int index) {
    final item = products[index];

    setState(() {
      editIndex = index;
      nameController.text = item.name;
      brandController.text = item.brand;
      categoryController.text = item.category;
      thicknessController.text = item.thickness;
      priceController.text = item.price;
      imageController.text = item.image;
    });
  }

  // SAVE: keeps the list on the phone using shared_preferences.
  Future<void> saveToStorage() async {
    if (products.isEmpty) {
      showMessage('Nothing registered yet.');
      return;
    }

    setState(() {
      isBusy = true;
    });

    try {
      final preferences = await SharedPreferences.getInstance();
      final jsonList = products.map((item) => item.toJson()).toList();

      await preferences.setString(storageKey, jsonEncode(jsonList));
    } catch (error) {
      if (!mounted) return;
      showMessage('Could not save. $error');
      return;
    }

    if (!mounted) return;
    setState(() {
      isBusy = false;
    });

    showMessage('Saved ${products.length} products on this phone.');
  }

  // LOAD: brings the list back from shared_preferences.
  Future<void> loadFromStorage() async {
    setState(() {
      isBusy = true;
    });

    try {
      final preferences = await SharedPreferences.getInstance();
      final text = preferences.getString(storageKey);

      if (text != null) {
        final jsonList = jsonDecode(text) as List;

        setState(() {
          products.clear();

          for (final item in jsonList) {
            products.add(Product.fromJson('$item'));
          }
        });
      }
    } catch (error) {
      if (!mounted) return;
      showMessage('Could not load. $error');
      return;
    }

    if (!mounted) return;
    setState(() {
      isBusy = false;
    });
  }

  // Copies the registered list into Firestore as well.

  // Brings the products from Firestore into the registered list.

  @override
  void dispose() {
    nameController.dispose();
    brandController.dispose();
    categoryController.dispose();
    thicknessController.dispose();
    priceController.dispose();
    imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = editIndex >= 0;

    return Scaffold(
      backgroundColor: ColorResources.background,
      appBar: AppBar(
        title: const Text('Local Products'),
        backgroundColor: ColorResources.background,
        foregroundColor: ColorResources.primary,
      ),
      body: isBusy
          ? Center(
              child: CircularProgressIndicator(color: ColorResources.primary),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // The two buttons the teacher asked for. These keep the
                  // list on the phone.
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: loadFromStorage,
                          icon: const Icon(Icons.download),
                          label: const Text('Load'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: saveToStorage,
                          icon: const Icon(Icons.save),
                          label: const Text('Save'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: ColorResources.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: ColorResources.border),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.inventory_2_outlined,
                          color: ColorResources.primary,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            '${products.length} products registered',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: ColorResources.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // The register / update form is its own widget.
                  ProductForm(
                    editIndex: editIndex,
                    nameController: nameController,
                    brandController: brandController,
                    categoryController: categoryController,
                    thicknessController: thicknessController,
                    priceController: priceController,
                    imageController: imageController,
                    onSubmit: () {
                      if (isEditing) {
                        updateProduct(editIndex);
                      } else {
                        registerProduct();
                      }
                    },
                    onClear: () {
                      setState(clearForm);
                    },
                  ),

                  const SizedBox(height: 20),

                  Text(
                    'Registered products',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: ColorResources.heading,
                    ),
                  ),

                  const SizedBox(height: 12),

                  if (products.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: Text(
                        'Nothing registered yet.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: ColorResources.text),
                      ),
                    ),

                  // Every registered product is shown with its own
                  // ProductCard widget. The index is the key, so deleting
                  // one destroys that widget and the rest shift up.
                  ...List.generate(products.length, (index) {
                    return ProductCard(
                      key: ValueKey(index),
                      index: index,
                      product: products[index],
                      isEditing: editIndex == index,
                      onEdit: () => startEditing(index),
                      onDelete: () => deleteProduct(index),
                    );
                  }),

                  const SizedBox(height: 24),
                ],
              ),
            ),
    );
  }
}
