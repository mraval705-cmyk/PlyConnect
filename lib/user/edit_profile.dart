import 'package:flutter/material.dart';
import '../resources/color_resources.dart';
import '../resources/sample_data.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();

  // A real form starts with the values that are already there, so the sample
  // user is used here.
  final nameController = TextEditingController(text: SampleData.nameText);
  final emailController = TextEditingController(text: SampleData.emailText);
  final mobileController = TextEditingController(text: SampleData.mobileText);

  /// Rebuilds when the typed name changes, so the circle letter updates too.
  void onNameChanged(String value) {
    setState(() {});
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  InputDecoration fieldDesign(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      suffixIcon: Icon(icon, color: ColorResources.primary),
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

  /// Checks the form, writes the values into the shared profile map, and goes
  /// back to the profile screen so the new details are visible there.
  void saveProfile() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    SampleData.updateProfile(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      mobile: mobileController.text.trim(),
    );

    Navigator.pop(context, true);
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.background,
      appBar: AppBar(
        title: const Text('Edit User Profile'),
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
                const SizedBox(height: 12),

                // There is no photo yet, so the first letter is shown.
                Center(
                  child: Container(
                    width: 100,
                    height: 100,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: ColorResources.background,
                      shape: BoxShape.circle,
                      border: Border.all(color: ColorResources.border, width: 2),
                    ),
                    child: Text(
                      nameController.text.isEmpty
                          ? 'P'
                          : nameController.text[0].toUpperCase(),
                      style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: ColorResources.primary,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                const Text(
                  'Edit your personal information',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: ColorResources.text,
                  ),
                ),

                const SizedBox(height: 32),

                TextFormField(
                  controller: nameController,
                  textCapitalization: TextCapitalization.words,
                  decoration: fieldDesign('Full Name', Icons.person_outline),
                  onChanged: onNameChanged,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration:
                      fieldDesign('Email Address', Icons.mail_outline),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your email';
                    }

                    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
                        .hasMatch(value.trim())) {
                      return 'Please enter a valid email';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 20),

                TextFormField(
                  controller: mobileController,
                  keyboardType: TextInputType.phone,
                  decoration:
                      fieldDesign('Mobile Number', Icons.phone_outlined),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your mobile number';
                    }

                    if (!RegExp(r'^[0-9]{10}$').hasMatch(value.trim())) {
                      return 'Enter a 10-digit mobile number';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 40),

                ElevatedButton(
                  onPressed: saveProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorResources.button,
                    foregroundColor: ColorResources.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Save Changes'),
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