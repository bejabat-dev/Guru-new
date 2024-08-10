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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyDkhYw4d4ZovKlhXQLnUFImzdvaTdCcyXM',
    appId: '1:842214022631:web:12f71c03f4175861163142',
    messagingSenderId: '842214022631',
    projectId: 'guru-booking',
    authDomain: 'guru-booking.firebaseapp.com',
    databaseURL: 'https://guru-booking-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'guru-booking.appspot.com',
    measurementId: 'G-13QDS5LLVL',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBfNfrr9SvTr9ttHfMGmQDVTVTbmqzcbRk',
    appId: '1:842214022631:android:64b8ea07d593ece4163142',
    messagingSenderId: '842214022631',
    projectId: 'guru-booking',
    databaseURL: 'https://guru-booking-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'guru-booking.appspot.com',
  );

}