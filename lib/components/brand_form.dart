import 'package:flutter/material.dart';
import '../resources/color_resources.dart';

class BrandForm extends StatefulWidget {
  final bool isEditing;

  // The list this form should add to or update, given by the Manage Brands
  // screen so that the change is visible in the list.
  final List<Map<String, dynamic>>? items;

  // The position of the item being edited inside that list.
  final int editIndex;

  const BrandForm({
    super.key,
    this.isEditing = false,
    this.items,
    this.editIndex = 0,
  });

  @override
  State<BrandForm> createState() => _BrandFormState();
}

class _BrandFormState extends State<BrandForm> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.isEditing) {
      nameController.text = 'Greenply';
      descriptionController.text =
          'Premium quality plywood and veneers with '
          'eco-friendly certifications.';
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
      fillColor: ColorResources.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: ColorResources.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: ColorResources.primary),
      ),
    );
  }

  bool isLoading = false;

  // Writes the brand into the "brands" collection in Firestore.
  // The brand is added to, or changed inside, the list that the
  // Manage Brands screen passed in. Nothing is sent to a server.
  Future<void> saveBrand() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final brand = <String, dynamic>{
        'id': 'NEW' + DateTime.now().millisecondsSinceEpoch.toString(),
        'name': nameController.text.trim(),
        'description': descriptionController.text.trim(),
        'image': 'assets/images/green_gold.png',
      };

      if (widget.items != null) {
        if (widget.isEditing) {
          // Update replaces the item that sits at the given index.
          widget.items![widget.editIndex] = brand;
        } else {
          // Add puts the new item at the end of the list.
          widget.items!.add(brand);
        }
      }

      if (!mounted) {
        return;
      }

      showMessage(widget.isEditing ? 'Brand updated.' : 'Brand added.');

      Future.delayed(const Duration(milliseconds: 400), () {
        if (mounted) {
          Navigator.pop(context, true);
        }
      });
    } catch (error) {
      if (mounted) {
        showMessage('Could not save the brand. $error');
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
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
      backgroundColor: ColorResources.background,
      appBar: AppBar(
        title: Text(
          widget.isEditing ? 'Edit Brand' : 'Add Brand',
        ),
        backgroundColor: ColorResources.background,
        foregroundColor: ColorResources.primary,
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
                        ? 'assets/images/green_gold.png'
                        : 'assets/images/home_banner.png',
                    height: 190,
                    fit: BoxFit.cover,
                  ),
                ),

                SizedBox(height: 28),

                Text(
                  'BRAND NAME',
                  style: TextStyle(
                    fontSize: 12,
                    color: ColorResources.text,
                  ),
                ),

                SizedBox(height: 8),

                TextFormField(
                  controller: nameController,
                  textCapitalization: TextCapitalization.words,
                  decoration: fieldDesign(
                    'e.g., Greenply',
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter brand name';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 24),

                Text(
                  'SHORT DESCRIPTION',
                  style: TextStyle(
                    fontSize: 12,
                    color: ColorResources.text,
                  ),
                ),

                SizedBox(height: 8),

                TextFormField(
                  controller: descriptionController,
                  minLines: 3,
                  maxLines: 5,
                  decoration: fieldDesign(
                    'Describe this brand and its products...',
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
                    'BRAND LOGO',
                    style: TextStyle(
                      fontSize: 12,
                      color: ColorResources.text,
                    ),
                  ),

                  SizedBox(height: 8),

                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: ColorResources.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: ColorResources.border),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.image_outlined,
                          color: ColorResources.primary,
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'brand_logo.png',
                            style: TextStyle(color: ColorResources.text),
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
                            style: TextStyle(color: ColorResources.primary),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

                SizedBox(height: 32),

                ElevatedButton(
                  onPressed: isLoading ? null : saveBrand,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorResources.button,
                    foregroundColor: ColorResources.white,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: isLoading
                      ? SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(
                            color: ColorResources.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
                          widget.isEditing ? 'Update Brand' : 'Save Brand',
                        ),
                ),

                SizedBox(height: 12),

                OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: ColorResources.primary,
                    side: BorderSide(color: ColorResources.border),
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
                    color: ColorResources.lightText,
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
