import 'package:flutter/material.dart';
import 'resources/app_colors.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  // Common design for input boxes
  InputDecoration fieldDesign(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: AppColors.white,
      prefixIcon: Icon(
        icon,
        color: AppColors.primary,
        size: 20,
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 18,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: AppColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: AppColors.primary),
      ),
    );
  }

  void createAccount() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Details valid. Account saving is not connected yet.',
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    mobileController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        title: Text('Create Account'),
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.primary,
        elevation: 0,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 24),

                Center(
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 96,
                    height: 96,
                    fit: BoxFit.contain,
                  ),
                ),

                SizedBox(height: 24),

                Text(
                  'Create Your Account',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),

                SizedBox(height: 8),

                Text(
                  'Sign up to save products, place orders '
                  'and manage your account.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.5,
                    color: AppColors.text,
                  ),
                ),

                SizedBox(height: 32),

                Text(
                  'Full Name',
                  style: TextStyle(color: AppColors.text),
                ),
                SizedBox(height: 8),

                TextFormField(
                  controller: nameController,
                  textCapitalization: TextCapitalization.words,
                  decoration: fieldDesign(
                    'Enter your full name',
                    Icons.person_outline,
                  ),
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 20),

                Text(
                  'Mobile Number',
                  style: TextStyle(color: AppColors.text),
                ),
                SizedBox(height: 8),

                TextFormField(
                  controller: mobileController,
                  keyboardType: TextInputType.phone,
                  decoration: fieldDesign(
                    'Enter 10-digit mobile number',
                    Icons.phone_outlined,
                  ),
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return 'Please enter your mobile number';
                    }

                    if (!RegExp(r'^[0-9]{10}$')
                        .hasMatch(text.trim())) {
                      return 'Enter a valid 10-digit mobile number';
                    }

                    return null;
                  },
                ),

                SizedBox(height: 20),

                Text(
                  'Email Address',
                  style: TextStyle(color: AppColors.text),
                ),
                SizedBox(height: 8),

                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: fieldDesign(
                    'name@example.com',
                    Icons.mail_outline,
                  ),
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return 'Please enter your email';
                    }

                    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
                        .hasMatch(text.trim())) {
                      return 'Please enter a valid email';
                    }

                    return null;
                  },
                ),

                SizedBox(height: 20),

                Text(
                  'Password',
                  style: TextStyle(color: AppColors.text),
                ),
                SizedBox(height: 8),

                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: fieldDesign(
                    'Enter your password',
                    Icons.lock_outline,
                  ),
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return 'Please enter a password';
                    }

                    if (text.length < 8) {
                      return 'Use at least 8 characters';
                    }

                    return null;
                  },
                ),

                SizedBox(height: 20),

                Text(
                  'Confirm Password',
                  style: TextStyle(color: AppColors.text),
                ),
                SizedBox(height: 8),

                TextFormField(
                  controller: confirmController,
                  obscureText: true,
                  decoration: fieldDesign(
                    'Re-enter your password',
                    Icons.lock_outline,
                  ),
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Please confirm your password';
                    }

                    if (text != passwordController.text) {
                      return 'Passwords do not match';
                    }

                    return null;
                  },
                ),

                SizedBox(height: 28),

                SizedBox(
                  height: 56,
                  child: ElevatedButton(
                    onPressed: createAccount,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.button,
                      foregroundColor: AppColors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      'Create Account',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),

                SizedBox(height: 24),

                Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(color: AppColors.text),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}