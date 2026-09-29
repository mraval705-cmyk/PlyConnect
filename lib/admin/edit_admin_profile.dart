import 'package:flutter/material.dart';
import '../resources/color_resources.dart';

class EditAdminProfilePage extends StatefulWidget {
  const EditAdminProfilePage({super.key});

  @override
  State<EditAdminProfilePage> createState() => _EditAdminProfilePageState();
}

class _EditAdminProfilePageState extends State<EditAdminProfilePage> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController(
    text: 'Rajesh Kumar',
  );

  final emailController = TextEditingController(
    text: 'admin@plyconnect.com',
  );

  final mobileController = TextEditingController(
    text: '9876543210',
  );

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
        borderSide: BorderSide(color: ColorResources.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: ColorResources.primary),
      ),
    );
  }

  void saveProfile() {
    if (_formKey.currentState!.validate()) {
      showMessage(
        'Details valid. Profile saving is not connected yet.',
      );
    }
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
        title: Text('Edit Admin Profile'),
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
                SizedBox(height: 12),

                Center(
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          'assets/images/user_profile.png',
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: ColorResources.button,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            tooltip: 'Change photo',
                            onPressed: () {
                              showMessage(
                                'Photo selection will be connected later.',
                              );
                            },
                            icon: Icon(
                              Icons.camera_alt_outlined,
                              color: ColorResources.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 16),

                Text(
                  'Edit shop owner information',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: ColorResources.text,
                  ),
                ),

                SizedBox(height: 32),

                TextFormField(
                  controller: nameController,
                  textCapitalization: TextCapitalization.words,
                  decoration: fieldDesign(
                    'Full Name',
                    Icons.person_outline,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 20),

                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: fieldDesign(
                    'Email Address',
                    Icons.mail_outline,
                  ),
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

                SizedBox(height: 20),

                TextFormField(
                  controller: mobileController,
                  keyboardType: TextInputType.phone,
                  decoration: fieldDesign(
                    'Mobile Number',
                    Icons.phone_outlined,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your mobile number';
                    }

                    if (!RegExp(r'^[0-9]{10}$')
                        .hasMatch(value.trim())) {
                      return 'Enter a 10-digit mobile number';
                    }

                    return null;
                  },
                ),

                SizedBox(height: 40),

                ElevatedButton(
                  onPressed: saveProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorResources.button,
                    foregroundColor: ColorResources.white,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text('Save Changes'),
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
