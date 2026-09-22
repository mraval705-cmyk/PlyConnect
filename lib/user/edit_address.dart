import 'package:flutter/material.dart';
import '../resources/app_colors.dart';

class EditAddressPage extends StatefulWidget {
  const EditAddressPage({super.key});

  @override
  State<EditAddressPage> createState() => _EditAddressPageState();
}

class _EditAddressPageState extends State<EditAddressPage> {
  final _formKey = GlobalKey<FormState>();

  final houseController = TextEditingController(
    text: '123, 4th Floor, Hemkunt Tower',
  );

  final areaController = TextEditingController(
    text: 'Nehru Place',
  );

  final cityController = TextEditingController(
    text: 'New Delhi',
  );

  final stateController = TextEditingController(
    text: 'Delhi',
  );

  final pincodeController = TextEditingController(
    text: '110019',
  );

  final landmarkController = TextEditingController();

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

  String? requiredField(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  void saveAddress() {
    if (_formKey.currentState!.validate()) {
      showMessage(
        'Address valid. Database saving is not connected yet.',
      );
    }
  }

  @override
  void dispose() {
    houseController.dispose();
    areaController.dispose();
    cityController.dispose();
    stateController.dispose();
    pincodeController.dispose();
    landmarkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Edit Delivery Address'),
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.primary,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 60,
                  color: AppColors.primary,
                ),

                SizedBox(height: 12),

                Text(
                  'Delivery Address',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),

                SizedBox(height: 8),

                Text(
                  'Enter the address where you want your order delivered.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    height: 1.5,
                    color: AppColors.text,
                  ),
                ),

                SizedBox(height: 28),

                TextFormField(
                  controller: houseController,
                  decoration: fieldDesign('House / Building / Flat'),
                  validator: requiredField,
                ),

                SizedBox(height: 20),

                TextFormField(
                  controller: areaController,
                  decoration: fieldDesign('Area / Street'),
                  validator: requiredField,
                ),

                SizedBox(height: 20),

                TextFormField(
                  controller: cityController,
                  textCapitalization: TextCapitalization.words,
                  decoration: fieldDesign('City'),
                  validator: requiredField,
                ),

                SizedBox(height: 20),

                TextFormField(
                  controller: stateController,
                  textCapitalization: TextCapitalization.words,
                  decoration: fieldDesign('State'),
                  validator: requiredField,
                ),

                SizedBox(height: 20),

                TextFormField(
                  controller: pincodeController,
                  keyboardType: TextInputType.number,
                  decoration: fieldDesign('PIN Code'),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your PIN code';
                    }

                    if (!RegExp(r'^[1-9][0-9]{5}$')
                        .hasMatch(value.trim())) {
                      return 'Enter a valid 6-digit PIN code';
                    }

                    return null;
                  },
                ),

                SizedBox(height: 20),

                TextFormField(
                  controller: landmarkController,
                  decoration: fieldDesign('Landmark (optional)'),
                ),

                SizedBox(height: 32),

                ElevatedButton(
                  onPressed: saveAddress,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.button,
                    foregroundColor: AppColors.white,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text('Save Address'),
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