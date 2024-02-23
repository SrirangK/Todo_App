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
    apiKey: 'AIzaSyDCaibeIkRMbTP0-f8NtGxB8KHu3o8_-yY',
    appId: '1:348198895504:web:b72620bea8f75a77eebd15',
    messagingSenderId: '348198895504',
    projectId: 'todo-9f257',
    authDomain: 'todo-9f257.firebaseapp.com',
    storageBucket: 'todo-9f257.appspot.com',
    measurementId: 'G-DM3G0VF04T',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCSl9ICwn48IvdZz43TzbQVmDGjtJ7ukCE',
    appId: '1:348198895504:android:6b0ae65843239bd4eebd15',
    messagingSenderId: '348198895504',
    projectId: 'todo-9f257',
    storageBucket: 'todo-9f257.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCuRxyuFKXiGQNq5pmKxAZFyxevnESCKkk',
    appId: '1:348198895504:ios:524d5e13738ba11beebd15',
    messagingSenderId: '348198895504',
    projectId: 'todo-9f257',
    storageBucket: 'todo-9f257.appspot.com',
    iosBundleId: 'com.example.todoApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCuRxyuFKXiGQNq5pmKxAZFyxevnESCKkk',
    appId: '1:348198895504:ios:ae04b63186fabebdeebd15',
    messagingSenderId: '348198895504',
    projectId: 'todo-9f257',
    storageBucket: 'todo-9f257.appspot.com',
    iosBundleId: 'com.example.todoApp.RunnerTests',
  );
}