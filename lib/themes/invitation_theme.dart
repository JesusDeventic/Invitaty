import 'package:flutter/material.dart';

/// 🎨 MODELO BASE DE THEME DE INVITACIÓN
///
/// ⚠️ IMPORTANTE:
/// - NO es el ThemeData de Flutter
/// - NO afecta a la app (light/dark)
/// - SOLO afecta a cómo se ve la invitación
///
/// 👉 Se usará en:
/// - viewer_screen (visualización final)
/// - editor (preview en tiempo real)
///
/// 👉 Viene desde JSON:
/// {
///   "theme": "elegant"
/// }
///
/// 👉 Y se convierte en:
/// InvitationTheme
class InvitationTheme {
  /// 🆔 ID del theme (ej: "elegant", "minimal", etc.)
  final String id;

  /// 🎨 COLOR DE FONDO PRINCIPAL
  /// 👉 Fondo de toda la invitación
  final Color backgroundColor;

  /// 🎨 COLOR PRINCIPAL
  /// 👉 Títulos, elementos destacados
  final Color primaryColor;

  /// 🎨 COLOR SECUNDARIO / ACENTO
  /// 👉 Botones, detalles, iconos
  final Color accentColor;

  /// 🔤 TIPOGRAFÍA (opcional)
  /// 👉 Ej: PlayfairDisplay (boda elegante)
  final String? fontFamily;

  /// 📦 CONSTRUCTOR
  const InvitationTheme({
    required this.id,
    required this.backgroundColor,
    required this.primaryColor,
    required this.accentColor,
    this.fontFamily,
  });

  /// 🧪 DEBUG
  @override
  String toString() {
    return 'InvitationTheme(id: $id)';
  }
}
