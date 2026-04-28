import 'package:flutter/material.dart';
import '../invitation_theme.dart';

/// 💍 THEME: ELEGANT
///
/// 👉 Pensado para bodas
/// 👉 Estilo suave, romántico, limpio
///
/// 🎯 Objetivo:
/// - Colores pastel
/// - Fondo claro
/// - Sensación elegante/minimalista
class ElegantTheme {
  /// 🆔 ID que se usará en el JSON
  /// {
  ///   "theme": "elegant"
  /// }
  static const String id = "elegant";

  static const InvitationTheme theme = InvitationTheme(
    id: id,

    /// 🌸 Fondo general
    backgroundColor: Color(0xFFFFF8F6),

    /// 🎀 Color principal (títulos)
    primaryColor: Color(0xFFD8A7A7),

    /// 🌹 Acento (botones, iconos)
    accentColor: Color(0xFFC48B8B),

    /// 🆕 COLOR DE TEXTO
    /// 👉 Más oscuro para buena legibilidad sobre fondo claro
    textColor: Color(0xFF4A3F3F),

    /// 🔤 Tipografía elegante
    fontFamily: "Playfair",

    /// 🆕 TAMAÑOS BASE
    /// 👉 Ajustados a estilo elegante (más aire, más jerarquía)
    titleFontSize: 24,
    bodyFontSize: 16,
  );
}
