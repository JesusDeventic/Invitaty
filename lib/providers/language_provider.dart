import 'package:filmoly/api/filmoly_api.dart';
import 'package:filmoly/core/global_functions.dart';
import 'package:filmoly/core/global_variables.dart';
import 'package:filmoly/core/user_preferences.dart';
import 'package:filmoly/generated/l10n.dart';
import 'package:filmoly/model/user_model.dart';
import 'package:flutter/material.dart';

/// Idioma de la app: SharedPreferences es la fuente de verdad (como Fitcron).
/// El backend solo se usa para guardar el idioma del usuario (notificaciones, etc.).
class LanguageProvider extends ChangeNotifier {
  static const String defaultLanguage = 'en';

  String _currentLanguage = defaultLanguage;
  String? _previousLanguage;

  String get currentLanguage => _currentLanguage;
  String? get previousLanguage => _previousLanguage;

  final UserPreferences _prefs = UserPreferences();

  LanguageProvider() {
    _loadLanguage();
  }

  Future<void> _loadLanguage() async {
    final saved = await _prefs.getLanguage();
    if (saved != null && saved.isNotEmpty && languageKeys.contains(saved)) {
      _currentLanguage = saved;
    } else {
      // Sin idioma guardado: usar el del sistema (como Fitcron)
      final systemLocale = WidgetsBinding.instance.platformDispatcher.locale;
      if (S.delegate.supportedLocales
          .any((locale) => locale.languageCode == systemLocale.languageCode)) {
        _currentLanguage = systemLocale.languageCode;
      } else {
        _currentLanguage = defaultLanguage;
      }
      await _prefs.setLanguage(_currentLanguage);
    }
    await _loadS(_currentLanguage);
    notifyListeners();
  }

  Future<void> _loadS(String languageCode) async {
    try {
      await S.load(Locale(languageCode));
    } catch (_) {
      _currentLanguage = defaultLanguage;
      await S.load(const Locale('en'));
    }
  }

  /// Cambia el idioma: guarda en SharedPreferences (fuente de verdad) y en backend si hay sesión.
  Future<void> changeLanguage(String newLanguage) async {
    if (_currentLanguage == newLanguage) return;
    if (!languageKeys.contains(newLanguage)) return;
    _previousLanguage = _currentLanguage;
    _currentLanguage = newLanguage;
    await _prefs.setLanguage(newLanguage);
    try {
      await _loadS(_currentLanguage);
    } catch (_) {
      _currentLanguage = defaultLanguage;
      await S.load(const Locale('en'));
    }
    notifyListeners();

    // Persistir en backend para notificaciones (si hay sesión)
    if (globalUserToken.isNotEmpty && globalCurrentUser.username.isNotEmpty) {
      final result = await FilmolyApi.updateUser(
        userEmail: globalCurrentUser.email,
        language: _currentLanguage,
        dateFormat: globalCurrentUser.dateFormat,
        weekStart: globalCurrentUser.weekStart,
      );
      if (result['success'] == true) {
        final userJson = result['user'];
        if (userJson is Map<String, dynamic>) {
          globalCurrentUser = FilmolyUser.fromJson(userJson);
          await _prefs.setCachedUser(globalCurrentUser);
        }
      }
    }

    // ignore: discarded_futures
    syncPushConfig();
  }
}
