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
    apiKey: 'AIzaSyAj98RZNyiPmthYThPD5PFznxve9c1lcD0',
    appId: '1:207996285308:web:a3b973649ef03fd67034f9',
    messagingSenderId: '207996285308',
    projectId: 'devicethread',
    authDomain: 'devicethread.firebaseapp.com',
    storageBucket: 'devicethread.appspot.com',
    measurementId: 'G-1JHQWCM6MS',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD5c9_7IilKpnvVi6Sn7UZI8ol_j_1dAGg',
    appId: '1:207996285308:android:ab58eafd552618eb7034f9',
    messagingSenderId: '207996285308',
    projectId: 'devicethread',
    storageBucket: 'devicethread.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBUALnk2zMrBxDNOMdj8Hq7e8VHYd8WtAk',
    appId: '1:207996285308:ios:cca1b9f3c4c737cf7034f9',
    messagingSenderId: '207996285308',
    projectId: 'devicethread',
    storageBucket: 'devicethread.appspot.com',
    androidClientId: '207996285308-1fouqdvl91f49ui4emsnaucvtv1nii02.apps.googleusercontent.com',
    iosClientId: '207996285308-onvre0tcnrpnl3ipa7taai4vhuujl06f.apps.googleusercontent.com',
    iosBundleId: 'com.example.firebaseProject',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBUALnk2zMrBxDNOMdj8Hq7e8VHYd8WtAk',
    appId: '1:207996285308:ios:cca1b9f3c4c737cf7034f9',
    messagingSenderId: '207996285308',
    projectId: 'devicethread',
    storageBucket: 'devicethread.appspot.com',
    androidClientId: '207996285308-1fouqdvl91f49ui4emsnaucvtv1nii02.apps.googleusercontent.com',
    iosClientId: '207996285308-onvre0tcnrpnl3ipa7taai4vhuujl06f.apps.googleusercontent.com',
    iosBundleId: 'com.example.firebaseProject',
  );
}
