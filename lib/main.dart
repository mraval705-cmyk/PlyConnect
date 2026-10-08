import 'package:flutter/material.dart';
import 'resources/theme_resources.dart';
import 'splash.dart';

/// Entry point of the app.
///
/// The app runs on sample data for now, so there is nothing to start up
/// before the first screen.
void main() {
  runApp(const PlyConnectApp());
}

class PlyConnectApp extends StatelessWidget {
  const PlyConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PlyConnect',

      // The whole app looks the way it does because of this one line.
      // To change the colours everywhere, edit ColorResources.
      theme: ThemeResources.light,
      home: const SplashPage(),
    );
  }
}