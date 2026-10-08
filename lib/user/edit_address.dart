import 'package:flutter/material.dart';
import '../resources/color_resources.dart';
import '../resources/sample_data.dart';

class EditAddressPage extends StatefulWidget {
  const EditAddressPage({super.key});

  @override
  State<EditAddressPage> createState() => _EditAddressPageState();
}

class _EditAddressPageState extends State<EditAddressPage> {
  final _formKey = GlobalKey<FormState>();

  // A real form starts with the address that is already saved.
  final houseController =
      TextEditingController(text: '123, 4th Floor, Hemkunt Tower');
  final areaController = TextEditingController(text: 'Nehru Place');
  final cityController = TextEditingController(text: 'New Delhi');
  final stateController = TextEditingController(text: 'Delhi');
  final pincodeController = TextEditingController(text: '110019');
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
      fillColor: ColorResources.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: ColorResources.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: ColorResources.primary),
      ),
    );
  }

  /// Every field except the landmark must be filled in.
  String? requiredField(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  /// Checks every field, joins the parts into one address, writes it into the
  /// shared profile map and goes back, so the profile screen shows it.
  void saveAddress() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final address = [
      houseController.text.trim(),
      areaController.text.trim(),
      cityController.text.trim(),
      stateController.text.trim(),
      pincodeController.text.trim(),
      landmarkController.text.trim(),
    ].where((part) => part.isNotEmpty).join(', ');

    SampleData.updateProfile(address: address);

    Navigator.pop(context, true);
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
      backgroundColor: ColorResources.background,
      appBar: AppBar(
        title: const Text('Edit Delivery Address'),
        backgroundColor: ColorResources.background,
        foregroundColor: ColorResources.primary,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  size: 60,
                  color: ColorResources.primary,
                ),

                const SizedBox(height: 12),

                const Text(
                  'Delivery Address',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: ColorResources.primary,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Enter the address where you want your order delivered.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    height: 1.5,
                    color: ColorResources.text,
                  ),
                ),

                const SizedBox(height: 28),

                TextFormField(
                  controller: houseController,
                  decoration: fieldDesign('House / Building / Flat'),
                  validator: requiredField,
                ),

                const SizedBox(height: 20),

                TextFormField(
                  controller: areaController,
                  decoration: fieldDesign('Area / Street'),
                  validator: requiredField,
                ),

                const SizedBox(height: 20),

                TextFormField(
                  controller: cityController,
                  textCapitalization: TextCapitalization.words,
                  decoration: fieldDesign('City'),
                  validator: requiredField,
                ),

                const SizedBox(height: 20),

                TextFormField(
                  controller: stateController,
                  textCapitalization: TextCapitalization.words,
                  decoration: fieldDesign('State'),
                  validator: requiredField,
                ),

                const SizedBox(height: 20),

                TextFormField(
                  controller: pincodeController,
                  keyboardType: TextInputType.number,
                  decoration: fieldDesign('PIN Code'),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your PIN code';
                    }

                    if (!RegExp(r'^[1-9][0-9]{5}$').hasMatch(value.trim())) {
                      return 'Enter a valid 6-digit PIN code';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 20),

                TextFormField(
                  controller: landmarkController,
                  decoration: fieldDesign('Landmark (optional)'),
                ),

                const SizedBox(height: 32),

                ElevatedButton(
                  onPressed: saveAddress,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorResources.button,
                    foregroundColor: ColorResources.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Save Address'),
                ),

                const SizedBox(height: 12),

                OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: ColorResources.primary,
                    side: const BorderSide(color: ColorResources.primary),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Cancel'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}