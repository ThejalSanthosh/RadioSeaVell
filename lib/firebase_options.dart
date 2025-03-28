// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
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
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBvKC3ao8G3yCVr71h6oEcsKwnLydrS680',
    appId: '1:672776868003:web:58ab09638d0afc503a2f16',
    messagingSenderId: '672776868003',
    projectId: 'radioseawell-95bbe',
    authDomain: 'radioseawell-95bbe.firebaseapp.com',
    storageBucket: 'radioseawell-95bbe.firebasestorage.app',
    measurementId: 'G-JHELQY8WMY',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBmba_vDxh92aHiWZAPSQhgqNeWQIOi_X8',
    appId: '1:672776868003:android:605e1f7bd3e92d9a3a2f16',
    messagingSenderId: '672776868003',
    projectId: 'radioseawell-95bbe',
    storageBucket: 'radioseawell-95bbe.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAlc3dZzB9QXUy2pFDFa4Obg7-ZcbyS9kU',
    appId: '1:672776868003:ios:667ede18154b00783a2f16',
    messagingSenderId: '672776868003',
    projectId: 'radioseawell-95bbe',
    storageBucket: 'radioseawell-95bbe.firebasestorage.app',
    iosBundleId: 'com.example.radioSeaWell',
  );
}
