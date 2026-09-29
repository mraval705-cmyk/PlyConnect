// Firebase settings taken from the files that sir's Firebase project gave us:
//   android/app/google-services.json
//   ios/Runner/GoogleService-Info.plist
//
// The Firebase CLI normally generates this file automatically. We wrote the
// same values by hand so the project works without running the CLI.
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform, kIsWeb;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError(
          'PlyConnect is not set up for this platform yet.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBr14RC64m43wfV3LDZVv2t1m6d01CSvUo',
    appId: '1:985346615518:android:0b72ae208a40a1986c7a4f',
    messagingSenderId: '985346615518',
    projectId: 'plyconnect-1ba33',
    storageBucket: 'plyconnect-1ba33.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBr14RC64m43wfV3LDZVv2t1m6d01CSvUo',
    appId: '1:985346615518:android:0b72ae208a40a1986c7a4f',
    messagingSenderId: '985346615518',
    projectId: 'plyconnect-1ba33',
    storageBucket: 'plyconnect-1ba33.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBaK6lmyFSKPn60LDpET3zhPjqEEqlt28k',
    appId: '1:985346615518:ios:490c055fa3da55926c7a4f',
    messagingSenderId: '985346615518',
    projectId: 'plyconnect-1ba33',
    storageBucket: 'plyconnect-1ba33.firebasestorage.app',
  );
}
