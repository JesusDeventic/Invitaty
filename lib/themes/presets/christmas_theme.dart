import 'package:flutter/material.dart';
import '../invitation_theme.dart';

/// 🎄 THEME: CHRISTMAS
///
/// 👉 Felicitaciones navideñas y eventos estacionales
/// 👉 Estilo festivo, cálido y elegante
///
/// 🎯 Objetivo:
/// - Sensación de Navidad clásica
/// - Colores tradicionales (rojo/verde)
/// - Fondo limpio tipo nieve
class ChristmasTheme {
  /// 🆔 ID usado en JSON
  static const String id = "christmas";

  static const InvitationTheme theme = InvitationTheme(
    id: id,

    /// 🆕 CLAVE DE TRADUCCIÓN DEL NOMBRE DEL THEME
    /// 👉 Usado para mostrar el nombre en UI traducido
    nameKey: "theme_christmas",

    /// ❄️ Fondo nieve / invierno
    backgroundColor: Color(0xFFFFFBF7),

    /// 🎅 Rojo navideño principal
    primaryColor: Color(0xFFC62828),

    /// 🎄 Verde pino como acento
    accentColor: Color(0xFF2E7D32),

    /// 📝 Texto legible oscuro (no negro puro)
    textColor: Color(0xFF2F2F2F),

    /// 🔤 Tipografía elegante (mantiene consistencia sistema)
    fontFamily: "Playfair",

    /// 📏 Jerarquía ligeramente más festiva (un poco más grande)
    titleFontSize: 32,
    bodyFontSize: 20,
  );
}
