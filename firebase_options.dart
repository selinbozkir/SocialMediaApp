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
    apiKey: 'AIzaSyCQAAFqurkE2wUnFmpTdYJhRVpC-6Z2-9U',
    appId: '1:869829125207:web:e293b491dccf5bd038ef12',
    messagingSenderId: '869829125207',
    projectId: 'son-proje-694c0',
    authDomain: 'son-proje-694c0.firebaseapp.com',
    storageBucket: 'son-proje-694c0.appspot.com',
    measurementId: 'G-C0P21SGMX6',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB08Efr0WCB-VvUlkTbk4rzf3PaoOPw-2w',
    appId: '1:869829125207:android:3437b8cd8d2070ba38ef12',
    messagingSenderId: '869829125207',
    projectId: 'son-proje-694c0',
    storageBucket: 'son-proje-694c0.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDDm5MuuxLdkQXRTu4C5XNzj4K_09s9R5M',
    appId: '1:869829125207:ios:06eab2819b6d519738ef12',
    messagingSenderId: '869829125207',
    projectId: 'son-proje-694c0',
    storageBucket: 'son-proje-694c0.appspot.com',
    iosClientId: '869829125207-jfi38mv7iih11t7ghbva6r1vq307nt09.apps.googleusercontent.com',
    iosBundleId: 'com.example.sonProje',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDDm5MuuxLdkQXRTu4C5XNzj4K_09s9R5M',
    appId: '1:869829125207:ios:06eab2819b6d519738ef12',
    messagingSenderId: '869829125207',
    projectId: 'son-proje-694c0',
    storageBucket: 'son-proje-694c0.appspot.com',
    iosClientId: '869829125207-jfi38mv7iih11t7ghbva6r1vq307nt09.apps.googleusercontent.com',
    iosBundleId: 'com.example.sonProje',
  );
}