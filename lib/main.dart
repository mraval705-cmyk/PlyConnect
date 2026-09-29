import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'resources/theme_resources.dart';
import 'splash.dart';

void main() {
  // Firebase must be ready before the first screen is shown, so we use
  // WidgetsFlutterBinding and wait for initializeApp to finish.
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const PlyConnectApp());
}

class PlyConnectApp extends StatefulWidget {
  const PlyConnectApp({super.key});

  @override
  State<PlyConnectApp> createState() => _PlyConnectAppState();
}

class _PlyConnectAppState extends State<PlyConnectApp> {
  late final Future<FirebaseApp> _future;

  @override
  void initState() {
    super.initState();

    _future = Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseApp>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Firebase is still starting up.
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }

        if (snapshot.hasError) {
          // Firebase could not start. Showing the reason helps during testing.
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.cloud_off,
                        size: 60,
                        color: Colors.red,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Could not start Firebase',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${snapshot.error}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'PlyConnect',

          // The whole app looks the way it does because of this one line.
          // To change colours everywhere, edit ColorResources.
          theme: ThemeResources.light,
          home: const SplashPage(),
        );
      },
    );
  }
}
