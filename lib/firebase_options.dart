// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;
import 'package:flutter_dotenv/flutter_dotenv.dart';

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
  static String apiKeyAndroid = dotenv.env['API_KEY_ANDROID'] ?? '';
  static String apiKeyIosAndMacOS = dotenv.env['API_KEY_IOS'] ?? '';
  static String apiKeyWinAndWeb = dotenv.env['API_KEY_WEB'] ?? '';

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
    apiKey: 'AIzaSyB2GqtLS3mzmiBEaXmD5Xtrk4xtmPcl6-E',
    appId: '1:800493126494:web:9b578064997a5c22cb45cf',
    messagingSenderId: '800493126494',
    projectId: 'amas-spotify',
    authDomain: 'amas-spotify.firebaseapp.com',
    storageBucket: 'amas-spotify.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDVKCk93LkaqngQyM4LHpfqmFqowkR56UU',
    appId: '1:800493126494:android:d8581f7d06620b80cb45cf',
    messagingSenderId: '800493126494',
    projectId: 'amas-spotify',
    storageBucket: 'amas-spotify.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDxA1tjvYXWbvlKlVw5tQjoViLzgGTtAh0',
    appId: '1:800493126494:ios:f776d1d6919748f9cb45cf',
    messagingSenderId: '800493126494',
    projectId: 'amas-spotify',
    storageBucket: 'amas-spotify.firebasestorage.app',
    iosBundleId: 'mg.amas.spotify',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDxA1tjvYXWbvlKlVw5tQjoViLzgGTtAh0',
    appId: '1:800493126494:ios:f776d1d6919748f9cb45cf',
    messagingSenderId: '800493126494',
    projectId: 'amas-spotify',
    storageBucket: 'amas-spotify.firebasestorage.app',
    iosBundleId: 'mg.amas.spotify',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyB2GqtLS3mzmiBEaXmD5Xtrk4xtmPcl6-E',
    appId: '1:800493126494:web:a50c94e2f326d0d5cb45cf',
    messagingSenderId: '800493126494',
    projectId: 'amas-spotify',
    authDomain: 'amas-spotify.firebaseapp.com',
    storageBucket: 'amas-spotify.firebasestorage.app',
  );
}
