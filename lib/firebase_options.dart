// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        return macos;
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
    apiKey: 'AIzaSyBYxyQSwremtMKlRVGEc5lKEnhXZ47icXI',
    appId: '1:497965163960:web:9789c438844233f71c1b4d',
    messagingSenderId: '497965163960',
    projectId: 'adishnakara-calender',
    authDomain: 'adishnakara-calender.firebaseapp.com',
    storageBucket: 'adishnakara-calender.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCXaZTQQlNPh6Fr19uP6KGC4bzb0vLlYo0',
    appId: '1:497965163960:android:90d5754d2d6372e41c1b4d',
    messagingSenderId: '497965163960',
    projectId: 'adishnakara-calender',
    storageBucket: 'adishnakara-calender.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyADIapPQcEPv-wOWE53E5PORWtihAPscr4',
    appId: '1:497965163960:ios:d4c34d851514357c1c1b4d',
    messagingSenderId: '497965163960',
    projectId: 'adishnakara-calender',
    storageBucket: 'adishnakara-calender.appspot.com',
    iosBundleId: 'com.example.adishankaraCalender',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyADIapPQcEPv-wOWE53E5PORWtihAPscr4',
    appId: '1:497965163960:ios:3d58f3cbff730a311c1b4d',
    messagingSenderId: '497965163960',
    projectId: 'adishnakara-calender',
    storageBucket: 'adishnakara-calender.appspot.com',
    iosBundleId: 'com.example.adishankaraCalender.RunnerTests',
  );
}
