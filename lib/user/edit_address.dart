import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../resources/color_resources.dart';

class EditAddressPage extends StatefulWidget {
  const EditAddressPage({super.key});

  @override
  State<EditAddressPage> createState() => _EditAddressPageState();
}

class _EditAddressPageState extends State<EditAddressPage> {
  final _formKey = GlobalKey<FormState>();

  // Empty by default and then filled with the address already saved for the
  // logged in user, so no sample values are shown in a real form.
  final houseController = TextEditingController();
  final areaController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final pincodeController = TextEditingController();
  final landmarkController = TextEditingController();

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadAddress();
  }

  Future<void> loadAddress() async {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
      return;
    }

    try {
      final document = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .get();

      final data = document.data();

      if (data != null && data['address'] != null) {
        houseController.text = '${data['house'] ?? ''}';
        areaController.text = '${data['area'] ?? ''}';
        cityController.text = '${data['city'] ?? ''}';
        stateController.text = '${data['state'] ?? ''}';
        pincodeController.text = '${data['pincode'] ?? ''}';
        landmarkController.text = '${data['landmark'] ?? ''}';
      }
    } catch (error) {
      // Keep the fields empty.
    }

    if (!mounted) {
      return;
    }

    setState(() {
      isLoading = false;
    });
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

  String? requiredField(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  // Joins the six fields into one string and saves it in Firestore.
  String buildAddressText() {
    final landmark = landmarkController.text.trim();

    final address =
        '${houseController.text.trim()}, ${areaController.text.trim()},\n'
        '${cityController.text.trim()} - ${pincodeController.text.trim()}';

    if (landmark.isEmpty) {
      return address;
    }

    return 'Landmark: $landmark\n$address';
  }

  Future<void> saveAddress() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      showMessage('Please login before saving an address.');
      return;
    }

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .set({
        'house': houseController.text.trim(),
        'area': areaController.text.trim(),
        'city': cityController.text.trim(),
        'state': stateController.text.trim(),
        'pincode': pincodeController.text.trim(),
        'landmark': landmarkController.text.trim(),
        'address': buildAddressText(),
      }, SetOptions(merge: true));
    } catch (error) {
      showMessage('Could not save the address. $error');
      return;
    }

    if (!mounted) {
      return;
    }

    showMessage('Address saved.');

    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        Navigator.pop(context);
      }
    });
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
        title: Text('Edit Delivery Address'),
        backgroundColor: ColorResources.background,
        foregroundColor: ColorResources.primary,
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
                  color: ColorResources.primary,
                ),

                SizedBox(height: 12),

                Text(
                  'Delivery Address',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: ColorResources.primary,
                  ),
                ),

                SizedBox(height: 8),

                Text(
                  'Enter the address where you want your order delivered.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    height: 1.5,
                    color: ColorResources.text,
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
                  onPressed: isLoading ? null : saveAddress,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorResources.button,
                    foregroundColor: ColorResources.white,
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
                    Navigator.pop(context);
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: ColorResources.primary,
                    side: BorderSide(color: ColorResources.primary),
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