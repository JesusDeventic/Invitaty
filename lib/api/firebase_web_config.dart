import 'package:firebase_core/firebase_core.dart';

/// Configuración necesaria para que funcionen las notificaciones en Web.
///
/// IMPORTANTE:
/// - Rellena `webFirebaseOptions` con la configuración de tu *Web app* en Firebase.
/// - Rellena `webVapidKey` desde Firebase Console → Cloud Messaging → Web Push certificates.
class FilmaniakFirebaseWebConfig {
  static const FirebaseOptions webFirebaseOptions = FirebaseOptions(
    apiKey: 'AIzaSyArj4AzEjey5UYyAXQ7xjL_pSVmIEy0uGg',
    appId: '1:838782505944:web:5770cb4b5282361df518ad',
    messagingSenderId: '838782505944',
    projectId: 'filmaniak',
    authDomain: 'filmaniak.firebaseapp.com',
    storageBucket: 'filmaniak.firebasestorage.app',
  );

  // Pégala aquí (Firebase Console → Cloud Messaging → Web Push certificates).
  static const String webVapidKey =
      'BJDCWbrSVTOVqZi7xN7Z_4LzmZuutRvp0xQO6L3fN7mTsB3cru--E2yBaKCHAPyhwFh7IU0rnQM-TOLg-6urij0';
}