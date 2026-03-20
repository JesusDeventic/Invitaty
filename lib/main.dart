import 'dart:io';
import 'package:filmaniak/api/filmaniak_messaging_service.dart';
import 'package:filmaniak/core/global_functions.dart';
import 'package:filmaniak/generated/l10n.dart';
import 'package:filmaniak/providers/language_provider.dart';
import 'package:filmaniak/providers/theme_provider.dart';
import 'package:filmaniak/routes/app_router.dart';
import 'package:filmaniak/styles/colors.dart';
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
  // Cargar versión de la app SIEMPRE al arrancar (como en Fitcron),
  // para que esté disponible incluso tras reload en Web.
  await loadAppVersion();
  // Inicializar notificaciones push solo en Android / iOS / Web
  if (kIsWeb || Platform.isAndroid || Platform.isIOS) {
    try {
      final messaging = FilmaniakMessagingService();
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
      child: const FilmaniakApp(),
    ),
  );
}

class FilmaniakApp extends StatefulWidget {
  const FilmaniakApp({super.key});

  @override
  State<FilmaniakApp> createState() => _FilmaniakAppState();
}

class _FilmaniakAppState extends State<FilmaniakApp> {
  late final GoRouter _router = createAppRouter(navigatorKey);
  final AppLinks _appLinks = AppLinks();

  Uri? _lastHandledUri;

  @override
  void initState() {
    super.initState();

    // `app_links` no está implementado en Windows.
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
//      - `bundle_id` en `ios/Runner/GoogleService-Info.plist`
//
// 3) Firebase (nuevo proyecto)
//    - Reemplazar:
//      - `android/app/google-services.json`
//      - `ios/Runner/GoogleService-Info.plist`
//    - Web:
//      - Actualizar `lib/api/firebase_web_config.dart` (`apiKey`, `appId`,
//        `projectId`, `messagingSenderId`, etc.)
//      - Actualizar `webVapidKey`
//
// 4) Backend WordPress / REST
//    - Cambiar `filmaniakBaseUrl` en `lib/api/filmaniak_api.dart`.
//    - Revisar rutas/prefijos en `wordpress_backend/*.php`:
//      - Namespace REST (`filmaniak/v1/...`)
//      - Funciones/prefijos (`filmaniak_...`) si quieres renombrar.
//
// 5) Secretos y configuracion sensible (wp-config.php)
//    - NO hardcodear claves en snippets o plugins.
//    - Definir en `wp-config.php` al menos:
//      - `FILMANIAK_FIREBASE_PROJECT_ID`
//      - `FILMANIAK_FIREBASE_SERVICE_ACCOUNT_PATH`
//      - `FILMANIAK_RECAPTCHA_SECRET_KEY`
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
// 7) Push y notificaciones
//    - Revisar `wordpress_backend/notificaciones.php` y
//      `wordpress_backend/WebPage_NotificacionesPush.php`.
//    - Confirmar que tokens FCM, envio push y textos traducidos funcionen en
//      todos los idiomas activos.
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
