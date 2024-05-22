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
    apiKey: 'AIzaSyBHvsAtTlNtZYv9YyumVnzTQZWIzbuswr8',
    appId: '1:269649906130:web:005d8fc72c329688f5600b',
    messagingSenderId: '269649906130',
    projectId: 'chat-app-5bb28',
    authDomain: 'chat-app-5bb28.firebaseapp.com',
    storageBucket: 'chat-app-5bb28.appspot.com',
    measurementId: 'G-E4VD8ZC8HP',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBX3dGvT4Kr4IUsgGN7RgxCFZlnw8kxnYQ',
    appId: '1:269649906130:android:3739735fded6c34df5600b',
    messagingSenderId: '269649906130',
    projectId: 'chat-app-5bb28',
    storageBucket: 'chat-app-5bb28.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyChNdSvzDxv45hUmdq22SO1tzCDvpTAhN8',
    appId: '1:269649906130:ios:f7b74c1456736209f5600b',
    messagingSenderId: '269649906130',
    projectId: 'chat-app-5bb28',
    storageBucket: 'chat-app-5bb28.appspot.com',
    iosBundleId: 'com.example.chatApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyChNdSvzDxv45hUmdq22SO1tzCDvpTAhN8',
    appId: '1:269649906130:ios:f7b74c1456736209f5600b',
    messagingSenderId: '269649906130',
    projectId: 'chat-app-5bb28',
    storageBucket: 'chat-app-5bb28.appspot.com',
    iosBundleId: 'com.example.chatApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBHvsAtTlNtZYv9YyumVnzTQZWIzbuswr8',
    appId: '1:269649906130:web:96fb992ae1a25ab3f5600b',
    messagingSenderId: '269649906130',
    projectId: 'chat-app-5bb28',
    authDomain: 'chat-app-5bb28.firebaseapp.com',
    storageBucket: 'chat-app-5bb28.appspot.com',
    measurementId: 'G-JD0965V6KL',
  );
}
