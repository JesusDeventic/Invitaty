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

    /// 🆕 CLAVE DE TRADUCCIÓN DEL NOMBRE DEL THEME
    /// 👉 Usado para mostrar el nombre en UI traducido
    nameKey: "theme_elegant",

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
    fontFamily: "GreatVibes",

    /// 🆕 TAMAÑOS BASE
    /// 👉 Ajustados a estilo elegante (más aire, más jerarquía)
    titleFontSize: 32,
    bodyFontSize: 18,
  );
}
