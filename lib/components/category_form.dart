import 'package:flutter/material.dart';
import '../resources/app_colors.dart';

class CategoryForm extends StatefulWidget {
  final bool isEditing;

  const CategoryForm({
    super.key,
    this.isEditing = false,
  });

  @override
  State<CategoryForm> createState() => _CategoryFormState();
}

class _CategoryFormState extends State<CategoryForm> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.isEditing) {
      nameController.text = 'BWP Grade';
      descriptionController.text =
          'Boiling Water Proof marine grade plywood, '
          'ideal for high-moisture areas like kitchens '
          'and bathrooms.';
    }
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  InputDecoration fieldDesign(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: AppColors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.primary),
      ),
    );
  }

  void saveCategory() {
    if (_formKey.currentState!.validate()) {
      showMessage(
        'Category details valid. Database saving is not connected yet.',
      );
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          widget.isEditing ? 'Edit Category' : 'Add Category',
        ),
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.primary,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 12),

                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    widget.isEditing
                        ? 'assets/images/category_edit.png'
                        : 'assets/images/category_add.png',
                    height: 190,
                    fit: BoxFit.cover,
                  ),
                ),

                SizedBox(height: 28),

                Text(
                  'CATEGORY NAME',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.text,
                  ),
                ),

                SizedBox(height: 8),

                TextFormField(
                  controller: nameController,
                  textCapitalization: TextCapitalization.words,
                  decoration: fieldDesign(
                    'e.g., Marine Grade Plywood',
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter category name';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 24),

                Text(
                  'SHORT DESCRIPTION',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.text,
                  ),
                ),

                SizedBox(height: 8),

                TextFormField(
                  controller: descriptionController,
                  minLines: 3,
                  maxLines: 5,
                  decoration: fieldDesign(
                    'Describe this category and its uses...',
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),

                if (widget.isEditing) ...[
                  SizedBox(height: 24),

                  Text(
                    'CATEGORY THUMBNAIL',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.text,
                    ),
                  ),

                  SizedBox(height: 8),

                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.image_outlined,
                          color: AppColors.primary,
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'category_edit.png',
                            style: TextStyle(color: AppColors.text),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            showMessage(
                              'Image selection will be connected later.',
                            );
                          },
                          child: Text(
                            'Change',
                            style: TextStyle(color: AppColors.primary),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

                SizedBox(height: 32),

                ElevatedButton(
                  onPressed: saveCategory,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.button,
                    foregroundColor: AppColors.white,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    widget.isEditing
                        ? 'Update Category'
                        : 'Save Category',
                  ),
                ),

                SizedBox(height: 12),

                OutlinedButton(
                  onPressed: () {
                    showMessage(
                      'Cancel navigation will be connected later.',
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    side: BorderSide(color: AppColors.border),
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text('Cancel'),
                ),

                SizedBox(height: 24),

                Text(
                  'Demo form — changes are not saved yet.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.lightText,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}