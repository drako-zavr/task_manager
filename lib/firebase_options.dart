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
    apiKey: 'AIzaSyC4dNUph9ZCKUf15lwlxcWN7hsAmmTb1Zk',
    appId: '1:264988181204:web:0c6d9ce2dcc5e9f3a23141',
    messagingSenderId: '264988181204',
    projectId: 'flutter-tasker-14781',
    authDomain: 'flutter-tasker-14781.firebaseapp.com',
    storageBucket: 'flutter-tasker-14781.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBs2V1ShDIZtYAUlB693UJ8LdLdxMzAhcw',
    appId: '1:264988181204:android:15c68a2fe66abfc5a23141',
    messagingSenderId: '264988181204',
    projectId: 'flutter-tasker-14781',
    storageBucket: 'flutter-tasker-14781.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA5TJ65lhzKZrBGK0iRupIuSXOczaUGosQ',
    appId: '1:264988181204:ios:f46a64de1a2fe099a23141',
    messagingSenderId: '264988181204',
    projectId: 'flutter-tasker-14781',
    storageBucket: 'flutter-tasker-14781.appspot.com',
    iosBundleId: 'com.example.taskManager',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA5TJ65lhzKZrBGK0iRupIuSXOczaUGosQ',
    appId: '1:264988181204:ios:f46a64de1a2fe099a23141',
    messagingSenderId: '264988181204',
    projectId: 'flutter-tasker-14781',
    storageBucket: 'flutter-tasker-14781.appspot.com',
    iosBundleId: 'com.example.taskManager',
  );
}
