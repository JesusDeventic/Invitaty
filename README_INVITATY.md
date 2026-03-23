# Invitaty (clon desde proyecto base)

Proyecto Flutter con paquete Dart **`invitaty`**.

## API / backend WordPress

- **URL base en la app:** `lib/api/invitaty_api.dart` → `invitatyBaseUrl`  
  Por defecto: `https://TU-DOMINIO/wp-json/invitaty/v1`
- **Namespace REST en PHP:** todos los `register_rest_route` usan **`invitaty/v1`**.

## wp-config.php (constantes nuevas)

Define en **`wp-config.php`** (antes de `require wp-settings.php`):

```php
define('INVITATY_FIREBASE_PROJECT_ID', 'invitaty');
define('INVITATY_FIREBASE_SERVICE_ACCOUNT_PATH', ABSPATH . 'wp-content/invitaty-firebase-adminsdk.json');
define('INVITATY_RECAPTCHA_SECRET_KEY', 'tu_secret_recaptcha_v3');
```

(Ajusta rutas y valores a tu entorno; el nombre del JSON de service account es el que subas desde Firebase.)

## Firebase (app)

- Android: `android/app/google-services.json`
- iOS: `ios/Runner/GoogleService-Info.plist`
- Web: `lib/api/firebase_web_config.dart` + `webVapidKey`

## Otros

- Tras editar ARBs: `dart run intl_utils:generate`
- Deep links de ejemplo: `app.invitaty.com` (Android manifest + iOS associated domains)
- Preferencias locales: claves `invitaty_*` en `user_preferences` / `secure_storage` (no comparten datos con el proyecto base)

Los **metadatos de usuario en WordPress** (p. ej. `invitaty_language`, tablas `wp_invitaty_*`, etc.) se esperan con el prefijo nuevo en PHP.
