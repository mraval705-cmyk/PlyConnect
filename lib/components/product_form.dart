import 'package:flutter/material.dart';
import '../resources/app_colors.dart';

class ProductForm extends StatefulWidget {
  final bool isEditing;

  const ProductForm({
    super.key,
    this.isEditing = false,
  });

  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();

  String? brand;
  String? category;
  String? thickness;
  String? sheetSize;

  final brands = [
    'CenturyPly',
    'Greenply',
    'Kitply',
    'Austin',
    'Action Tesa',
  ];

  final categories = [
    'MR Grade',
    'BWR Grade',
    'BWP Grade',
    'Commercial Plywood',
  ];

  final thicknesses = [
    '6 mm',
    '12 mm',
    '16 mm',
    '18 mm',
    '19 mm',
  ];

  final sheetSizes = [
    '8 × 4 ft',
    '7 × 4 ft',
    '6 × 4 ft',
  ];

  @override
  void initState() {
    super.initState();

    if (widget.isEditing) {
      nameController.text = 'BWP Marine Plywood';
      priceController.text = '4640.00';
      descriptionController.text =
          'Premium boiling water proof marine grade plywood. '
          'Termite and borer resistant with superior strength '
          'for high-moisture areas.';

      brand = 'CenturyPly';
      category = 'BWP Grade';
      thickness = '19 mm';
      sheetSize = '8 × 4 ft';
    }
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  InputDecoration fieldDesign(String label) {
    return InputDecoration(
      labelText: label,
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

  Widget dropdown(
    String label,
    String? selected,
    List<String> options,
    ValueChanged<String?> onChanged,
  ) {
    return DropdownButtonFormField<String>(
      initialValue: selected,
      isExpanded: true,
      decoration: fieldDesign(label),
      dropdownColor: AppColors.white,
      items: options.map((option) {
        return DropdownMenuItem<String>(
          value: option,
          child: Text(option),
        );
      }).toList(),
      onChanged: onChanged,
      validator: (value) {
        if (value == null) {
          return 'Please select $label';
        }
        return null;
      },
    );
  }

  void saveProduct() {
    if (_formKey.currentState!.validate()) {
      showMessage(
        'Product details valid. Image upload and database '
        'saving are not connected yet.',
      );
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          widget.isEditing ? 'Edit Product' : 'Add Product',
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
                Text(
                  widget.isEditing ? 'PRODUCT MEDIA' : 'PRODUCT IMAGE',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.text,
                  ),
                ),

                SizedBox(height: 12),

                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    border: Border.all(color: AppColors.border),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      if (widget.isEditing)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            'assets/images/wishlist_product.png',
                            width: 120,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        )
                      else
                        Icon(
                          Icons.add_a_photo_outlined,
                          size: 48,
                          color: AppColors.lightText,
                        ),

                      SizedBox(height: 12),

                      Text(
                        widget.isEditing
                            ? 'Current Image'
                            : 'Upload Product Image',
                        style: TextStyle(color: AppColors.text),
                      ),

                      SizedBox(height: 8),

                      TextButton(
                        onPressed: () {
                          showMessage(
                            'Image selection will be connected later.',
                          );
                        },
                        child: Text(
                          widget.isEditing ? 'Change Image' : 'Choose File',
                          style: TextStyle(color: AppColors.primary),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 24),

                TextFormField(
                  controller: nameController,
                  decoration: fieldDesign('Product Name'),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter product name';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 20),

                dropdown(
                  'Brand',
                  brand,
                  brands,
                  (value) {
                    setState(() {
                      brand = value;
                    });
                  },
                ),

                SizedBox(height: 20),

                dropdown(
                  'Category',
                  category,
                  categories,
                  (value) {
                    setState(() {
                      category = value;
                    });
                  },
                ),

                SizedBox(height: 20),

                dropdown(
                  'Thickness',
                  thickness,
                  thicknesses,
                  (value) {
                    setState(() {
                      thickness = value;
                    });
                  },
                ),

                SizedBox(height: 20),

                dropdown(
                  'Sheet Size',
                  sheetSize,
                  sheetSizes,
                  (value) {
                    setState(() {
                      sheetSize = value;
                    });
                  },
                ),

                SizedBox(height: 20),

                TextFormField(
                  controller: priceController,
                  keyboardType: TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: fieldDesign(
                    'Price per Sheet',
                  ).copyWith(prefixText: '₹ '),
                  validator: (value) {
                    final price = double.tryParse(value?.trim() ?? '');

                    if (price == null || !price.isFinite || price <= 0) {
                      return 'Enter a valid price greater than zero';
                    }

                    return null;
                  },
                ),

                SizedBox(height: 20),

                TextFormField(
                  controller: descriptionController,
                  minLines: 3,
                  maxLines: 5,
                  decoration: fieldDesign('Product Description'),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter product description';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 28),

                ElevatedButton(
                  onPressed: saveProduct,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.button,
                    foregroundColor: AppColors.white,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    widget.isEditing ? 'Update Product' : 'Save Product',
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
                    side: BorderSide(color: AppColors.primary),
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text('Cancel'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}