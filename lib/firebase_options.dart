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
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyBGWY9WzgovpTfk1B2HyxGIRwDmX48Aqeo',
    appId: '1:953822619021:web:3fe4aca368551b8dc849c4',
    messagingSenderId: '953822619021',
    projectId: 'todo-assignment-4ff74',
    authDomain: 'todo-assignment-4ff74.firebaseapp.com',
    storageBucket: 'todo-assignment-4ff74.appspot.com',
    measurementId: 'G-D274E7BYEL',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBP57_23w92tDA5GLDEXz_09diNba8fwu0',
    appId: '1:953822619021:android:496d3f62b0f3bb36c849c4',
    messagingSenderId: '953822619021',
    projectId: 'todo-assignment-4ff74',
    storageBucket: 'todo-assignment-4ff74.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD3PnWKXsyf7G4mkldqk1SbN4ndZxh9NVk',
    appId: '1:953822619021:ios:da6981334fb665ccc849c4',
    messagingSenderId: '953822619021',
    projectId: 'todo-assignment-4ff74',
    storageBucket: 'todo-assignment-4ff74.appspot.com',
    iosBundleId: 'com.example.todoApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD3PnWKXsyf7G4mkldqk1SbN4ndZxh9NVk',
    appId: '1:953822619021:ios:da6981334fb665ccc849c4',
    messagingSenderId: '953822619021',
    projectId: 'todo-assignment-4ff74',
    storageBucket: 'todo-assignment-4ff74.appspot.com',
    iosBundleId: 'com.example.todoApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBGWY9WzgovpTfk1B2HyxGIRwDmX48Aqeo',
    appId: '1:953822619021:web:b8a7d248307e53bec849c4',
    messagingSenderId: '953822619021',
    projectId: 'todo-assignment-4ff74',
    authDomain: 'todo-assignment-4ff74.firebaseapp.com',
    storageBucket: 'todo-assignment-4ff74.appspot.com',
    measurementId: 'G-SD3T9XZZN2',
  );
}
