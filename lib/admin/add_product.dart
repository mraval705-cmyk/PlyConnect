import 'package:flutter/material.dart';
import '../components/product_form.dart';

/// Add a product. The list is given so the new product is added to it.
class AddProductPage extends StatelessWidget {
  final List<Map<String, dynamic>>? items;

  const AddProductPage({
    super.key,
    this.items,
  });

  @override
  Widget build(BuildContext context) {
    return ProductForm(items: items);
  }
}