import 'package:firebase_core/firebase_core.dart';

/// Configuración necesaria para que funcionen las notificaciones en Web.
///
/// IMPORTANTE:
/// - Rellena `webFirebaseOptions` con la configuración de tu *Web app* en Firebase.
/// - Rellena `webVapidKey` desde Firebase Console → Cloud Messaging → Web Push certificates.
class FilmaniakFirebaseWebConfig {
  static const FirebaseOptions webFirebaseOptions = FirebaseOptions(
    apiKey: 'AIzaSyBiKIkRHFKH_cr2cwCUHAzu8vWKMtq_EkM',
    appId: '1:344135822235:web:9462fbb5a6d29abf8f4f3e',
    messagingSenderId: '344135822235',
    projectId: 'filmaniak-app',
    authDomain: 'filmaniak-app.firebaseapp.com',
    storageBucket: 'filmaniak-app.firebasestorage.app',
  );

  // Pégala aquí (Firebase Console → Cloud Messaging → Web Push certificates).
  static const String webVapidKey =
      'BC-uxoWgohdFoUKoQumf5qlFQzaA6dpQYB4UcKlCNLl0-uIp1Ey-KuAF7RtAxQrxUSFxTCBxszUocEyUyoPLDSk';
}