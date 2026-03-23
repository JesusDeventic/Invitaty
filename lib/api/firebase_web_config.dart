import 'package:firebase_core/firebase_core.dart';

/// Solo Web necesita `FirebaseOptions` explícitas; iOS/Android usan
/// `GoogleService-Info.plist` / `google-services.json` (y en iOS `FirebaseApp.configure()`).
///
/// Clave VAPID: Firebase Console → Project settings → Cloud Messaging →
/// Web Push certificates → Key pair (la pública empieza por `B` o `BC`).
class InvitatyFirebaseWebConfig {
  static const FirebaseOptions webFirebaseOptions = FirebaseOptions(
    apiKey: 'AIzaSyCnd4j4JaQuei9yL-JoUTwEZ9gXFbL9Nq0',
    appId: '1:819871040897:web:08821cf7f781becca2d480',
    messagingSenderId: '819871040897',
    projectId: 'invitaty',
    authDomain: 'invitaty.firebaseapp.com',
    storageBucket: 'invitaty.firebasestorage.app',
  );

  /// Web Push: misma clave que en Firebase → Cloud Messaging → Web Push certificates.
  static const String webVapidKey =
      'BCx6IzS45JM9dfm_EnsLabhc42uwWCXwD2t2oI8_kdXhJNkE4ywuzRNRxWttC05RSYgAXVboFAFzxI4VQnUDmak';
}
