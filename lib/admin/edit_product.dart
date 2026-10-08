import 'package:flutter/material.dart';
import '../components/product_form.dart';

/// Edit a product. The list and the index are given so saving changes the
/// item that is already in the Manage Products list.
class EditProductPage extends StatelessWidget {
  final List<Map<String, dynamic>>? items;
  final int index;

  const EditProductPage({
    super.key,
    this.items,
    this.index = 0,
  });

  @override
  Widget build(BuildContext context) {
    return ProductForm(
      isEditing: true,
      items: items,
      editIndex: index,
    );
  }
}