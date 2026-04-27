import 'invitation_theme.dart';
import 'presets/elegant_theme.dart';

/// 📦 REGISTRO GLOBAL DE THEMES
///
/// 👉 Aquí se centralizan TODOS los themes disponibles
/// 👉 Evita usar if/switch por toda la app
///
/// 💡 Idea clave:
/// "elegant" → ElegantTheme.theme
///
/// 👉 Escalable:
/// - añadir nuevos themes sin tocar lógica
/// - conectar con backend en futuro
class ThemeRegistry {
  /// 🗂️ MAPA DE THEMES DISPONIBLES
  ///
  /// 🔹 key → id del JSON
  /// 🔹 value → objeto InvitationTheme
  static final Map<String, InvitationTheme> _themes = {
    ElegantTheme.id: ElegantTheme.theme,

    // 🔜 FUTURO:
    // "modern": ModernTheme.theme,
    // "minimal": MinimalTheme.theme,
  };

  /// 🔎 OBTENER THEME POR ID
  ///
  /// 👉 Se usa en:
  /// - viewer_screen
  /// - editor (preview)
  ///
  /// ⚠️ IMPORTANTE:
  /// Siempre devuelve algo (fallback)
  static InvitationTheme get(String? id) {
    if (id == null) return ElegantTheme.theme;

    return _themes[id] ?? ElegantTheme.theme;
  }

  /// 📋 LISTA DE THEMES DISPONIBLES
  ///
  /// 👉 Útil para:
  /// - selector de temas (futuro)
  static List<InvitationTheme> getAll() {
    return _themes.values.toList();
  }
}
