import 'package:flutter/material.dart';
import '../components/product_form.dart';

class EditProductPage extends StatelessWidget {
  const EditProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ProductForm(isEditing: true);
  }
}
