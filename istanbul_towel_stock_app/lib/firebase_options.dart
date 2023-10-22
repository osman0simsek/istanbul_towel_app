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
    apiKey: 'AIzaSyCP_04iCSANE9maHdemRrcaH5oSB7HXhho',
    appId: '1:956684889108:web:c82e8a7af75d5451a14b01',
    messagingSenderId: '956684889108',
    projectId: 'istanbul-towel-stock-4616d',
    authDomain: 'istanbul-towel-stock-4616d.firebaseapp.com',
    storageBucket: 'istanbul-towel-stock-4616d.appspot.com',
    measurementId: 'G-ETCN6BBYPV',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBWhMsGTHNfVmnxZ5xU6vyIKLB1H6Puw6A',
    appId: '1:956684889108:android:943a6f6c98fb6ed1a14b01',
    messagingSenderId: '956684889108',
    projectId: 'istanbul-towel-stock-4616d',
    storageBucket: 'istanbul-towel-stock-4616d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCIu_pmJJaMtmuU18UUAVpCnnmBMOww6b0',
    appId: '1:956684889108:ios:30724ce0ddd89551a14b01',
    messagingSenderId: '956684889108',
    projectId: 'istanbul-towel-stock-4616d',
    storageBucket: 'istanbul-towel-stock-4616d.appspot.com',
    iosBundleId: 'com.example.istanbulTowelStockApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCIu_pmJJaMtmuU18UUAVpCnnmBMOww6b0',
    appId: '1:956684889108:ios:b4d9f3dc425804b4a14b01',
    messagingSenderId: '956684889108',
    projectId: 'istanbul-towel-stock-4616d',
    storageBucket: 'istanbul-towel-stock-4616d.appspot.com',
    iosBundleId: 'com.example.istanbulTowelStockApp.RunnerTests',
  );
}