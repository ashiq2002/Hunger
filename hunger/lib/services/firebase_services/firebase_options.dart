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
    apiKey: 'AIzaSyCaXEBtrCC4T0qeOVnniaymC4bUmh4CmnQ',
    appId: '1:1059729313593:web:a9fa4c8c9bf4bc05dd22e8',
    messagingSenderId: '1059729313593',
    projectId: 'userauth-52d4d',
    authDomain: 'userauth-52d4d.firebaseapp.com',
    storageBucket: 'userauth-52d4d.appspot.com',
    measurementId: 'G-95ETYF9QDD',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDWuETmqosxAGBGrLzYI3FeIoblrVMIxkQ',
    appId: '1:1059729313593:android:1690986639eeaa8fdd22e8',
    messagingSenderId: '1059729313593',
    projectId: 'userauth-52d4d',
    storageBucket: 'userauth-52d4d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB5i9wAi9nqTtP5hT7Nr2nhGKZotOjZm4k',
    appId: '1:1059729313593:ios:69f9fd982cc5cf21dd22e8',
    messagingSenderId: '1059729313593',
    projectId: 'userauth-52d4d',
    storageBucket: 'userauth-52d4d.appspot.com',
    iosClientId: '1059729313593-v22rl6j815mis2ksq4cv65ovnvp3terr.apps.googleusercontent.com',
    iosBundleId: 'com.example.hunger',
  );
}
