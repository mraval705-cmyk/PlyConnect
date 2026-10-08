import 'package:flutter/material.dart';
import '../../models/product.dart';
import '../../resources/color_resources.dart';

/// A separate widget for ONE registered product.
///
/// Each row on the screen is built from this class, so the list is only a
/// list of these widgets. Deleting a product destroys its widget.
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
              style: const TextStyle(
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
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: ColorResources.heading,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${product.brand} • ${product.category} • '
                  '${product.thickness}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: ColorResources.text,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '₹${product.price}',
                  style: const TextStyle(
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
            icon: const Icon(
              Icons.edit_outlined,
              color: ColorResources.primary,
            ),
          ),
          IconButton(
            tooltip: 'Delete product',
            onPressed: onDelete,
            icon: const Icon(
              Icons.delete_outline,
              color: ColorResources.danger,
            ),
          ),
        ],
      ),
    );
  }
}