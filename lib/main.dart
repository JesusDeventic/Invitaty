import 'dart:io';
import 'package:invitaty/api/invitaty_messaging_service.dart';
import 'package:invitaty/core/global_functions.dart';
import 'package:invitaty/generated/l10n.dart';
import 'package:invitaty/providers/language_provider.dart';
import 'package:invitaty/providers/theme_provider.dart';
import 'package:invitaty/routes/app_router.dart';
import 'package:invitaty/styles/colors.dart';
import 'package:app_links/app_links.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Cargar versiÃ³n de la app SIEMPRE al arrancar,
  // para que estÃ© disponible incluso tras reload en Web.
  await loadAppVersion();
  // Inicializar notificaciones push solo en Android / iOS / Web
  if (kIsWeb || Platform.isAndroid || Platform.isIOS) {
    try {
      final messaging = InvitatyMessagingService();
      await messaging.initialize();
    } catch (e) {
      debugPrint('Error inicializando notificaciones de Firebase: $e');
    }
  }
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
      ],
      child: const InvitatyApp(),
    ),
  );
}

class InvitatyApp extends StatefulWidget {
  const InvitatyApp({super.key});

  @override
  State<InvitatyApp> createState() => _InvitatyAppState();
}

class _InvitatyAppState extends State<InvitatyApp> {
  late final GoRouter _router = createAppRouter(navigatorKey);
  final AppLinks _appLinks = AppLinks();

  Uri? _lastHandledUri;

  @override
  void initState() {
    super.initState();

    // `app_links` no estÃ¡ implementado en Windows.
    // Para deep links nativos solo lo activamos en Android/iOS.
    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
      _handleInitialUri();
      _appLinks.uriLinkStream.listen((uri) {
        _handleIncomingUri(uri);
      });
    }
  }

  Future<void> _handleInitialUri() async {
    try {
      final uri = await _appLinks.getInitialLink();
      if (uri != null) _handleIncomingUri(uri);
    } catch (_) {
      // Ignoramos errores de deep link silenciosamente para no romper el arranque.
    }
  }

  void _handleIncomingUri(Uri uri) {
    if (!mounted) return;
    if (_lastHandledUri == uri) return;
    _lastHandledUri = uri;

    final path = uri.path;
    if (path.startsWith('/user/')) {
      final ctx = navigatorKey.currentContext;
      if (ctx == null) return;
      ctx.go(path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeProvider, LanguageProvider>(
      builder: (context, themeProvider, languageProvider, _) {
        return MaterialApp.router(
          routerConfig: _router,
          scaffoldMessengerKey: scaffoldMessengerKey,
          debugShowCheckedModeBanner: false,
          onGenerateTitle: (context) => S.current.appName,
          theme: themeProvider.isDarkMode ? darkTheme : lightTheme,
          locale: Locale(languageProvider.currentLanguage),
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
        );
      },
    );
  }
}




// ============================================================================
// GUIA DE COMANDOS
// ============================================================================
// Regenerar archivos de idiomas
// dart run intl_utils:generate



// ============================================================================
// GUIA PARA REUTILIZAR ESTE PROYECTO (FLUTTER + WORDPRESS)
// ============================================================================
// Si usas este repo como base para otra app, revisa este checklist:
//
// 1) Identidad visual y branding
//    - Sustituir `assets/logo.png` y los recursos de marca.
//    - Regenerar iconos con `flutter_launcher_icons`:
//      `dart run flutter_launcher_icons`
//    - Revisar icono push Android:
//      `android/app/src/main/res/drawable/ic_notification.png`
//    - Revisar textos de marca en `lib/l10n/*.arb` (ej: `appName`).
//
// 2) Identificadores de app (Android/iOS)
//    - Android:
//      - `applicationId` en `android/app/build.gradle(.kts)`
//      - `package_name` en `android/app/google-services.json`
//    - iOS:
//      - `PRODUCT_BUNDLE_IDENTIFIER` en Xcode (Runner)
//      - `BUNDLE_ID` en `ios/Runner/GoogleService-Info.plist` (debe coincidir)
//
// 3) Firebase (nuevo proyecto en console.firebase.google.com)
//    - Descargar y colocar:
//      - `android/app/google-services.json`
//      - `ios/Runner/GoogleService-Info.plist`
//    - iOS (imprescindible para que arranque y haya push):
//      - En Xcode, el `GoogleService-Info.plist` debe estar en el target Runner
//        (Build Phases â†’ Copy Bundle Resources). Si solo estÃ¡ en disco, falla
//        `FirebaseApp.configure()` en `ios/Runner/AppDelegate.swift`.
//      - `ios/Runner/Runner.entitlements`: `aps-environment` (development en
//        debug; production para TestFlight/App Store).
//      - En Firebase Console â†’ Project settings â†’ Cloud Messaging â†’ Apple:
//        subir la clave APNs (.p8) de Apple Developer (Keys). Una misma clave
//        vale para varias apps del mismo equipo; sirve para que FCM envÃ­e a
//        Apple (no sustituye al plist en la app).
//    - Web: `lib/api/firebase_web_config.dart` (FirebaseOptions + `webVapidKey`).
//    - Android/iOS en Dart: `Firebase.initializeApp()` sin opciones; el plist
//      y `google-services.json` bastan. `AppDelegate` llama `FirebaseApp.configure()`.
//    - `ios/Podfile`: `platform :ios` acorde a Firebase (p. ej. 15+) y
//      `use_modular_headers!` en el target Runner si usas los pods actuales.
//
// 4) Backend WordPress / REST
//    - Cambiar `invitatyBaseUrl` en `lib/api/invitaty_api.dart`.
//    - Revisar rutas/prefijos en `wordpress_backend/*.php`:
//      - Namespace REST (`invitaty/v1/...`)
//      - Funciones/prefijos (`invitaty_...` en PHP: internas; usermeta sigue igual salvo que migres BD).
//
// 5) Secretos y configuracion sensible (wp-config.php)
//    - NO hardcodear claves en snippets o plugins.
//    - Definir en `wp-config.php` al menos:
//      - `INVITATY_FIREBASE_PROJECT_ID`
//      - `INVITATY_FIREBASE_SERVICE_ACCOUNT_PATH`
//      - `INVITATY_RECAPTCHA_SECRET_KEY`
//    - Verificar que `wordpress_backend/recaptcha.php` y `notificaciones.php`
//      lean esas constantes.
//
// 6) CORS (recomendado: una sola capa)
//    - Evitar CORS duplicado entre WordPress y Nginx.
//    - Si centralizas en Nginx:
//      - En WP, desactivar CORS REST nativo (ver `wordpress_backend/apirest-cors.php`).
//      - En Nginx Proxy Manager, aplicar CORS en Custom Location (no en Advanced
//        global si tu plantilla no aplica `add_header` ahi).
//
// 7) Push y notificaciones (WordPress + FCM)
//    - Backend: `wordpress_backend/notificaciones.php`,
//      `wordpress_backend/WebPage_NotificacionesPush.php`.
//    - Tras cambiar bundle ID / Firebase, comprobar registro de token en BD y
//      envÃ­o por idioma (topics). En iOS, si no hay token, revisar plist en el
//      target, entitlements APNs y clave .p8 en la consola de Firebase.
//
// 8) Localizacion y generacion de codigo
//    - Tras editar ARB, regenerar l10n:
//      `dart run intl_utils:generate`
//
// 9) URLs y contenido externo
//    - Revisar enlaces de soporte/redes/contacto, por ejemplo en:
//      - `lib/page/users/contact_page.dart`
//      - cualquier otro punto con dominios legacy.
//
// Con esto, el proyecto queda listo como plantilla base reutilizable para apps
// Flutter + WordPress con backend propio.
