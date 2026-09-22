import 'package:flutter/material.dart';
import '../components/category_form.dart';

class EditCategoryPage extends StatelessWidget {
  const EditCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CategoryForm(isEditing: true);
  }
}