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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB-oau8nrkivvwXk4kQ-hR7aVsTh6YmCvo',
    appId: '1:367126395524:android:13b9ace6bd0cdd1715a0d1',
    messagingSenderId: '367126395524',
    projectId: 'bagit-e-commerce-app',
    storageBucket: 'bagit-e-commerce-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAv3JrrYxI1sBINFmCLANiqscUsJFbGLMc',
    appId: '1:367126395524:ios:751ad52c84a79b8b15a0d1',
    messagingSenderId: '367126395524',
    projectId: 'bagit-e-commerce-app',
    storageBucket: 'bagit-e-commerce-app.appspot.com',
    androidClientId: '367126395524-ms18e90f4qnvfrt1rl5vmd620pvs4sse.apps.googleusercontent.com',
    iosBundleId: 'com.example.buyItApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyASP2EPm84EcRg38_UWYQrh1Ys15mVGvS0',
    appId: '1:367126395524:web:a4c23804ae5f31fb15a0d1',
    messagingSenderId: '367126395524',
    projectId: 'bagit-e-commerce-app',
    authDomain: 'bagit-e-commerce-app.firebaseapp.com',
    storageBucket: 'bagit-e-commerce-app.appspot.com',
    measurementId: 'G-2DHQXXVXH2',
  );

}