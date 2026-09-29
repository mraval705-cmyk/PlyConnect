import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'resources/color_resources.dart';

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
      fillColor: ColorResources.white,
      prefixIcon: Icon(
        icon,
        color: ColorResources.primary,
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
        borderSide: BorderSide(color: ColorResources.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: ColorResources.primary),
      ),
    );
  }

  bool isLoading = false;

  // Creates the account in Firebase Authentication.
  Future<void> createAccount() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      // Save the name and mobile number in Firestore so that the Profile
      // screen can show them later.
      await FirebaseFirestore.instance
          .collection('users')
          .doc(credential.user!.uid)
          .set({
        'name': nameController.text.trim(),
        'mobile': mobileController.text.trim(),
        'email': emailController.text.trim(),
        'createdAt': FieldValue.serverTimestamp(),
      });

      if (!mounted) {
        return;
      }

      // The account is made, but the user must log in first. So we take
      // them to the Login screen instead of opening the app.
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
        (route) => false,
      );
    } on FirebaseAuthException catch (error) {
      showAuthError(error);
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  void showAuthError(FirebaseAuthException error) {
    String message;

    if (error.code == 'email-already-in-use') {
      message = 'This email is already registered. Please log in.';
    } else if (error.code == 'weak-password') {
      message = 'Please use a stronger password.';
    } else if (error.code == 'invalid-email') {
      message = 'Please enter a valid email address.';
    } else {
      message = 'Could not create the account. ${error.message}';
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
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
      backgroundColor: ColorResources.background,

      appBar: AppBar(
        title: Text('Create Account'),
        backgroundColor: ColorResources.background,
        foregroundColor: ColorResources.primary,
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
                    color: ColorResources.primary,
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
                    color: ColorResources.text,
                  ),
                ),

                SizedBox(height: 32),

                Text(
                  'Full Name',
                  style: TextStyle(color: ColorResources.text),
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
                  style: TextStyle(color: ColorResources.text),
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
                  style: TextStyle(color: ColorResources.text),
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
                  style: TextStyle(color: ColorResources.text),
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
                  style: TextStyle(color: ColorResources.text),
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
                    onPressed: isLoading ? null : createAccount,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorResources.button,
                      foregroundColor: ColorResources.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
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
                      style: TextStyle(color: ColorResources.text),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: ColorResources.primary,
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