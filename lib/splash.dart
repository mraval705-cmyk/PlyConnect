import 'package:flutter/material.dart';
import 'guest/welcome.dart';
import 'resources/color_resources.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    // After a short wait the app moves to the Welcome screen.
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) {
        return;
      }

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => WelcomePage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.background,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: 180,
                height: 180,
                fit: BoxFit.contain,
              ),

              SizedBox(height: 24),

              Text(
                'PlyConnect',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: ColorResources.primary,
                ),
              ),

              SizedBox(height: 8),

              Text(
                'Quality plywood from trusted brands',
                style: TextStyle(
                  fontSize: 14,
                  color: ColorResources.text,
                ),
              ),

              SizedBox(height: 48),

              SizedBox(
                width: 32,
                height: 32,
                child: CircularProgressIndicator(
                  color: ColorResources.primary,
                  strokeWidth: 3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
