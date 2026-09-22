import 'package:flutter/material.dart';
import '../resources/app_colors.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();

  final currentController = TextEditingController();
  final newController = TextEditingController();
  final confirmController = TextEditingController();

  bool hideCurrent = true;
  bool hideNew = true;
  bool hideConfirm = true;

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  InputDecoration passwordDesign(
    String label,
    bool hidden,
    VoidCallback toggle,
  ) {
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
      suffixIcon: IconButton(
        tooltip: hidden ? 'Show password' : 'Hide password',
        onPressed: toggle,
        icon: Icon(
          hidden
              ? Icons.visibility_outlined
              : Icons.visibility_off_outlined,
          color: AppColors.primary,
        ),
      ),
    );
  }

  void updatePassword() {
    if (_formKey.currentState!.validate()) {
      showMessage(
        'Form valid. Current password verification and '
        'password update are not connected yet.',
      );
    }
  }

  @override
  void dispose() {
    currentController.dispose();
    newController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Change Password'),
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
                SizedBox(height: 12),

                Text(
                  'ACCOUNT EMAIL',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.lightText,
                  ),
                ),

                SizedBox(height: 8),

                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Text(
                    'arjun.sharma@email.com',
                    style: TextStyle(color: AppColors.text),
                  ),
                ),

                SizedBox(height: 24),

                TextFormField(
                  controller: currentController,
                  obscureText: hideCurrent,
                  autocorrect: false,
                  enableSuggestions: false,
                  decoration: passwordDesign(
                    'Current Password',
                    hideCurrent,
                    () {
                      setState(() {
                        hideCurrent = !hideCurrent;
                      });
                    },
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your current password';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 20),

                TextFormField(
                  controller: newController,
                  obscureText: hideNew,
                  autocorrect: false,
                  enableSuggestions: false,
                  decoration: passwordDesign(
                    'New Password',
                    hideNew,
                    () {
                      setState(() {
                        hideNew = !hideNew;
                      });
                    },
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter a new password';
                    }

                    if (value.length < 8) {
                      return 'Use at least 8 characters';
                    }

                    if (value == currentController.text) {
                      return 'New password must differ from current password';
                    }

                    return null;
                  },
                ),

                SizedBox(height: 20),

                TextFormField(
                  controller: confirmController,
                  obscureText: hideConfirm,
                  autocorrect: false,
                  enableSuggestions: false,
                  decoration: passwordDesign(
                    'Confirm New Password',
                    hideConfirm,
                    () {
                      setState(() {
                        hideConfirm = !hideConfirm;
                      });
                    },
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your new password';
                    }

                    if (value != newController.text) {
                      return 'Passwords do not match';
                    }

                    return null;
                  },
                ),

                SizedBox(height: 12),

                Text(
                  'Use at least 8 characters.',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.lightText,
                  ),
                ),

                SizedBox(height: 32),

                ElevatedButton(
                  onPressed: updatePassword,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.button,
                    foregroundColor: AppColors.white,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text('Update Password'),
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