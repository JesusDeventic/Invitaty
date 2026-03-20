import 'dart:io';

import 'package:filmaniak/api/filmaniak_api.dart';
import 'package:filmaniak/api/firebase_web_config.dart';
import 'package:filmaniak/core/global_variables.dart';
import 'package:intl/intl.dart';
import 'package:filmaniak/core/secure_storage.dart';
import 'package:filmaniak/core/user_preferences.dart';
import 'package:filmaniak/generated/l10n.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:filmaniak/main.dart';
import 'package:filmaniak/providers/language_provider.dart';
final _secureStorage = FilmaniakSecureStorage();

Future<void> loadAppVersion() async {
  final info = await PackageInfo.fromPlatform();
  globalCurrentVersionApp = info.version;
}

void unFocusGlobal() {
  FocusManager.instance.primaryFocus?.unfocus();
}

Future<void> logoutUser() async {
  // Borrar token FCM para desuscribirse de notificaciones
  if (kIsWeb || Platform.isAndroid || Platform.isIOS) {
    try {
      await FirebaseMessaging.instance.deleteToken();
    } catch (_) {
      // ignorar errores de FCM en logout
    }
  }
  await FilmaniakApi.logoutAndClear();
  await UserPreferences().clearCachedUser();
}

/// Intenta restaurar sesión leyendo el token del secure storage y validándolo con /auth/me.
Future<bool> loginUser() async {
  final token = await _secureStorage.getToken();
  if (token == null || token.isEmpty) return false;
  try {
    final user = await FilmaniakApi.validateToken(token);
    if (user == null) return false;
    globalUserToken = token;
    globalCurrentUser = user;
    await UserPreferences().setCachedUser(user);
    await syncPushConfig();
    return true;
  } catch (_) {
    // Sin conexión u otro error de red: no se puede validar, ir a login
    return false;
  }
}

/// Sincroniza la configuración push del usuario actual:
/// - registra/actualiza el token FCM en backend (WP)
/// - suscribe a topic por idioma (solo Android/iOS)
Future<void> syncPushConfig() async {
  if (!(kIsWeb || Platform.isAndroid || Platform.isIOS)) return;
  if (globalUserToken.isEmpty) return;
  try {
    final ctx = navigatorKey.currentContext;
    String langCode = 'en';
    String? previousLangCode;
    if (ctx != null) {
      final lp = Provider.of<LanguageProvider>(ctx, listen: false);
      langCode = lp.currentLanguage;
      previousLangCode = lp.previousLanguage;
    }
    final fcm = FirebaseMessaging.instance;
    final fcmToken = kIsWeb
        ? await fcm.getToken(vapidKey: FilmaniakFirebaseWebConfig.webVapidKey)
        : await fcm.getToken();
    if (fcmToken == null || fcmToken.isEmpty) return;

    final ok = await FilmaniakApi.registerPushToken(
      token: globalUserToken,
      fcmToken: fcmToken,
    );
    debugPrint('Registro token push backend: $ok');

    // Topics: solo Android/iOS (en web no aplica)
    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
      if (previousLangCode != null &&
          previousLangCode.isNotEmpty &&
          previousLangCode != langCode) {
        try {
          await fcm.unsubscribeFromTopic(previousLangCode);
        } catch (_) {
          // ignorar
        }
      }
      await fcm.subscribeToTopic(langCode);
    }
  } catch (e) {
    debugPrint('Error sincronizando push (token/topic): $e');
  }
}

/// Compara dos versiones tipo "1.0.1" devolviendo:
/// -1 si v1 < v2, 0 si iguales, 1 si v1 > v2.
int compareVersions(String version1, String version2) {
  int extractNumber(String version) {
    return int.tryParse(version.replaceAll(RegExp(r'\D'), '')) ?? 0;
  }

  final num1 = extractNumber(version1);
  final num2 = extractNumber(version2);
  return num1.compareTo(num2);
}

/// Nombre del idioma según el locale actual (para el desplegable).
String getLanguageName(String code) {
  switch (code) {
    case 'ar':
      return S.current.languageArabic;
    case 'ca':
      return S.current.languageCatalan;
    case 'de':
      return S.current.languageGerman;
    case 'en':
      return S.current.languageEnglish;
    case 'es':
      return S.current.languageSpanish;
    case 'fr':
      return S.current.languageFrench;
    case 'hi':
      return S.current.languageHindi;
    case 'it':
      return S.current.languageItalian;
    case 'ja':
      return S.current.languageJapanese;
    case 'ko':
      return S.current.languageKorean;
    case 'nl':
      return S.current.languageDutch;
    case 'pl':
      return S.current.languagePolish;
    case 'pt':
      return S.current.languagePortuguese;
    case 'ro':
      return S.current.languageRomanian;
    case 'ru':
      return S.current.languageRussian;
    case 'sv':
      return S.current.languageSwedish;
    case 'tr':
      return S.current.languageTurkish;
    case 'uk':
      return S.current.languageUkrainian;
    case 'zh':
      return S.current.languageChinese;
    default:
      return code;
  }
}

/// Solo el nombre nativo (sin paréntesis), como en Fitcron.
String getNativeLanguageName(String code) {
  final fullName = getLanguageName(code);
  final idx = fullName.indexOf('(');
  if (idx != -1) return fullName.substring(0, idx).trim();
  return fullName;
}

/// Emoji de bandera por código de idioma, como en Fitcron.
String getLanguageFlag(String code) {
  switch (code) {
    case 'en':
      return '🇺🇸';
    case 'de':
      return '🇩🇪';
    case 'fr':
      return '🇫🇷';
    case 'it':
      return '🇮🇹';
    case 'pt':
      return '🇵🇹';
    case 'es':
      return '🇪🇸';
    case 'ca':
      return '🏴';
    case 'ar':
      return '🇸🇦';
    case 'zh':
      return '🇨🇳';
    case 'ja':
      return '🇯🇵';
    case 'ko':
      return '🇰🇷';
    case 'hi':
      return '🇮🇳';
    case 'tr':
      return '🇹🇷';
    case 'pl':
      return '🇵🇱';
    case 'ru':
      return '🇷🇺';
    case 'nl':
      return '🇳🇱';
    case 'ro':
      return '🇷🇴';
    case 'sv':
      return '🇸🇪';
    case 'uk':
      return '🇺🇦';
    default:
      return '🌐';
  }
}

/// Convierte una fecha del servidor (UTC) a la hora local del dispositivo.
///
/// Se diseñó para replicar el comportamiento de Fitcron:
/// - Si viene con zona horaria (`Z`, `+00:00`, `-00:00`), respeta esa zona.
/// - Si viene ISO sin zona (`...T...`), asume que es UTC y añade `Z`.
/// - Si viene MySQL `yyyy-MM-dd HH:mm:ss`, la convierte a ISO y asume UTC.
String? convertUtcToLocal(String? dateString) {
  if (dateString == null || dateString.isEmpty) return dateString;

  try {
    DateTime utcDate;
    String dateToParse = dateString;

    if (dateString.endsWith('Z') ||
        dateString.contains('+00:00') ||
        dateString.contains('-00:00')) {
      utcDate = DateTime.parse(dateString).toUtc();
    } else {
      if (dateString.contains('T')) {
        dateToParse = '${dateString}Z';
      } else {
        dateToParse = '${dateString.replaceAll(' ', 'T')}Z';
      }
      utcDate = DateTime.parse(dateToParse).toUtc();
    }

    final localDate = utcDate.toLocal();
    return localDate.toIso8601String();
  } catch (_) {
    return dateString;
  }
}

/// Formatea una fecha al formato del usuario (dd/MM/yyyy, dd-MM-yyyy, etc.).
String formatDate(String inputDate, {bool showTime = false}) {
  if (inputDate.isEmpty) return '';
  final pattern = '${globalCurrentUser.dateFormat}${showTime ? ' HH:mm' : ''}';
  try {
    DateTime date;
    if (RegExp(r'^\d{4}-\d{2}-\d{2}').hasMatch(inputDate)) {
      date = DateTime.parse(inputDate);
    } else {
      date = DateFormat('dd/MM/yyyy').parse(inputDate);
    }
    return DateFormat(pattern).format(date);
  } catch (_) {
    return inputDate;
  }
}

/// Formatea un `DateTime` a:
/// - `HH:mm` si es hoy
/// - `fecha + HH:mm` (según `globalCurrentUser.dateFormat`) si no es hoy
///
/// Comportamiento tipo Fitcron para mensajes privados.
String formatMessageTimestamp(DateTime dt) {
  final localDt = dt.toLocal();
  final now = DateTime.now();

  final isToday = localDt.year == now.year &&
      localDt.month == now.month &&
      localDt.day == now.day;

  final timeStr = DateFormat.Hm().format(localDt);
  if (isToday) return timeStr;

  final datePattern = globalCurrentUser.dateFormat;
  final dateStr = DateFormat(datePattern).format(localDt);
  return '$dateStr $timeStr';
}

/// Calcula la edad desde una fecha de nacimiento (YYYY-MM-DD o dd-MM-yyyy).
String formatAgeFromBirthday(String inputDate, {String? inputFormat}) {
  if (inputDate.isEmpty) return '?';
  try {
    // Réplica de Fitcron:
    // - Si hay `inputFormat`, parseamos con parseLoose.
    // - Si no, asumimos ISO (yyyy-MM-dd).
    final raw = inputDate.trim();
    final DateTime birthDate = inputFormat != null
        ? DateFormat(inputFormat).parseLoose(raw)
        : DateTime.parse(raw);

    final now = DateTime.now();
    int age = now.year - birthDate.year;
    if (now.month < birthDate.month ||
        (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }
    return age > 0 ? age.toString() : '?';
  } catch (_) {
    return '?';
  }
}
