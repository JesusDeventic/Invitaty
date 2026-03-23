import 'dart:convert';

import 'package:invitaty/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Preferencias locales: tema (por dispositivo) y cachÃ© de usuario para uso offline.
/// Idioma, weekStart y dateFormat vienen del backend (usuario) y se cachean con el usuario.
class UserPreferences {
  static const _keyTheme = 'invitaty_theme_dark';
  static const _keyLanguage = 'invitaty_language';
  static const _keyCachedUser = 'invitaty_cached_user';

  Future<SharedPreferences> get _prefs async =>
      await SharedPreferences.getInstance();

  Future<void> setThemeApp(bool isDark) async {
    final prefs = await _prefs;
    await prefs.setBool(_keyTheme, isDark);
  }

  Future<bool?> getThemeApp() async {
    final prefs = await _prefs;
    return prefs.getBool(_keyTheme);
  }

  Future<void> setLanguage(String languageCode) async {
    final prefs = await _prefs;
    await prefs.setString(_keyLanguage, languageCode);
  }

  Future<String?> getLanguage() async {
    final prefs = await _prefs;
    return prefs.getString(_keyLanguage);
  }

  /// Guarda el usuario en cachÃ© para uso offline (se restaura al iniciar si hay token).
  Future<void> setCachedUser(InvitatyUser user) async {
    final prefs = await _prefs;
    await prefs.setString(_keyCachedUser, jsonEncode(_userToJson(user)));
  }

  /// Obtiene el usuario cacheado (null si no hay).
  Future<InvitatyUser?> getCachedUser() async {
    final prefs = await _prefs;
    final json = prefs.getString(_keyCachedUser);
    if (json == null || json.isEmpty) return null;
    try {
      final map = jsonDecode(json) as Map<String, dynamic>;
      return InvitatyUser.fromJson(map);
    } catch (_) {
      return null;
    }
  }

  Future<void> clearCachedUser() async {
    final prefs = await _prefs;
    await prefs.remove(_keyCachedUser);
  }

  Map<String, dynamic> _userToJson(InvitatyUser u) => {
        'id': u.id,
        'username': u.username,
        'user_email': u.email,
        'display_name': u.displayName,
        'description': u.description,
        'avatar_url': u.avatarUrl,
        'language': u.language,
        'date_format': u.dateFormat,
        'start_day_week': u.weekStart,
        'country': u.country,
        'birthdate': u.birthdate,
        'invitaty_retroteca_vip': u.isRetrotecaVip,
        'marketing_consent': u.marketingConsent,
      };
}
