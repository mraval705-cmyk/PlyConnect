import 'package:flutter/material.dart';
import '../components/brand_form.dart';

class EditBrandPage extends StatelessWidget {
  const EditBrandPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BrandForm(isEditing: true);
  }
}
