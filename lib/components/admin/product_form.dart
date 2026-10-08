import 'package:flutter/material.dart';
import '../../resources/color_resources.dart';

/// A separate widget for the register / update form.
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
            style: const TextStyle(
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