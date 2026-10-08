import 'package:flutter/material.dart';
import '../components/brand_form.dart';

/// Edit a brand. The list and the index of the item are given, so saving
/// changes the item that is already in the Manage Brands list.
class EditBrandPage extends StatelessWidget {
  final List<Map<String, dynamic>>? items;
  final int index;

  const EditBrandPage({
    super.key,
    this.items,
    this.index = 0,
  });

  @override
  Widget build(BuildContext context) {
    return BrandForm(
      isEditing: true,
      items: items,
      editIndex: index,
    );
  }
}