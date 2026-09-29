import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'admin/admin_login.dart';
import 'guest/home.dart';
import 'signup.dart';
import 'resources/color_resources.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool hidePassword = true;

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void openSignup() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SignupPage(),
      ),
    );
  }

  void openAdminLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AdminLoginPage(),
      ),
    );
  }

  bool isLoading = false;

  // Signs the user in with Firebase Authentication.
  Future<void> login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final entered = emailController.text.trim();

    // Firebase needs a real email address. If the user typed a mobile number
    // we cannot use it for Firebase login, so we tell them clearly.
    if (!entered.contains('@')) {
      showMessage(
        'Please enter your email address to log in. '
        'Mobile number login is not available yet.',
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: entered,
        password: passwordController.text,
      );

      if (!mounted) {
        return;
      }

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const GuestHomePage(),
        ),
        (route) => false,
      );
    } on FirebaseAuthException catch (error) {
      if (error.code == 'wrong-password' ||
          error.code == 'user-not-found' ||
          error.code == 'invalid-credential') {
        showMessage('Wrong email or password.');
      } else if (error.code == 'user-disabled') {
        showMessage('This account has been disabled.');
      } else if (error.code == 'too-many-requests') {
        showMessage('Too many attempts. Please try again later.');
      } else {
        showMessage('Could not log in. ${error.message}');
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
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.background,

      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
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
                SizedBox(height: 100),

                Text(
                  'Welcome Back',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: ColorResources.heading,
                  ),
                ),

                SizedBox(height: 8),

                Text(
                  'Login to place orders, save wishlist and '
                  'manage your account.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: ColorResources.text,
                    height: 1.5,
                  ),
                ),

                SizedBox(height: 24),

                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: ColorResources.primary,
                              width: 2,
                            ),
                          ),
                        ),
                        child: Text(
                          'Login',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: ColorResources.primary,
                          ),
                        ),
                      ),
                    ),

                    Expanded(
                      child: TextButton(
                        onPressed: openSignup,
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 16,
                            color: ColorResources.text,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 28),

                Text(
                  'Email or Mobile Number',
                  style: TextStyle(
                    fontSize: 13,
                    color: ColorResources.text,
                  ),
                ),

                SizedBox(height: 8),

                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'name@example.com',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: ColorResources.border,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: ColorResources.primary,
                      ),
                    ),
                  ),
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return 'Please enter email or mobile number';
                    }

                    final value = text.trim();

                    final isEmail = RegExp(
                      r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                    ).hasMatch(value);

                    final isMobile = RegExp(
                      r'^[0-9]{10}$',
                    ).hasMatch(value);

                    if (!isEmail && !isMobile) {
                      return 'Enter a valid email or 10-digit mobile number';
                    }

                    return null;
                  },
                ),

                SizedBox(height: 20),

                Text(
                  'Password',
                  style: TextStyle(
                    fontSize: 13,
                    color: ColorResources.text,
                  ),
                ),

                SizedBox(height: 8),

                TextFormField(
                  controller: passwordController,
                  obscureText: hidePassword,
                  decoration: InputDecoration(
                    hintText: 'Enter your password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: ColorResources.border,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: ColorResources.primary,
                      ),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        hidePassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: ColorResources.text,
                      ),
                      onPressed: () {
                        setState(() {
                          hidePassword = !hidePassword;
                        });
                      },
                    ),
                  ),
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      showMessage('Password reset is not connected yet.');
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: ColorResources.primary,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 8),

                SizedBox(
                  height: 56,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorResources.button,
                      foregroundColor: ColorResources.buttonText,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: isLoading
                        ? SizedBox(
                            height: 22,
                            width: 22,
                            child: CircularProgressIndicator(
                              color: ColorResources.buttonText,
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            'Login',
                            style: TextStyle(fontSize: 20),
                          ),
                  ),
                ),

                SizedBox(height: 16),

                Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(
                        color: ColorResources.text,
                      ),
                    ),
                    TextButton(
                      onPressed: openSignup,
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: ColorResources.primary,
                        ),
                      ),
                    ),
                  ],
                ),

                TextButton(
                  onPressed: openAdminLogin,
                  child: Text(
                    'Login as Admin →',
                    style: TextStyle(
                      color: ColorResources.primary,
                    ),
                  ),
                ),

                SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}