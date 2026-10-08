import 'package:flutter/material.dart';
import '../components/brand_form.dart';

/// Add a brand. The list is given so the new brand can be added to it, which
/// is why the change is visible on the Manage Brands screen.
class AddBrandPage extends StatelessWidget {
  final List<Map<String, dynamic>>? items;

  const AddBrandPage({
    super.key,
    this.items,
  });

  @override
  Widget build(BuildContext context) {
    return BrandForm(items: items);
  }
}