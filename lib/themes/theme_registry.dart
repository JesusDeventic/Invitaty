import 'package:invitaty/themes/presets/christmas_theme.dart';
import 'package:invitaty/themes/presets/default_theme.dart';
import 'package:invitaty/themes/presets/fun_theme.dart';
import 'package:invitaty/themes/presets/minimal_theme.dart';

import 'invitation_theme.dart';
import 'presets/elegant_theme.dart';
import 'presets/classic_theme.dart';

/// 📦 REGISTRO GLOBAL DE THEMES
/// Centraliza todos los themes disponibles en la app
class ThemeRegistry {
  static final Map<String, InvitationTheme> _themes = {
    ElegantTheme.id: ElegantTheme.theme,
    ClassicTheme.id: ClassicTheme.theme,
    ChristmasTheme.id: ChristmasTheme.theme,
    FunTheme.id: FunTheme.theme,
    MinimalTheme.id: MinimalTheme.theme,
    DefaultTheme.id: DefaultTheme.theme,
  };

  /// 🔎 Obtener theme por ID (fallback seguro)
  static InvitationTheme get(String? id) {
    return _themes[id] ?? DefaultTheme.theme;
  }

  /// 📋 Lista de themes (para futuro selector UI)
  static List<InvitationTheme> getAll() => _themes.values.toList();
}
