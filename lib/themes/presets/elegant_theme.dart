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

  /// 🎨 DEFINICIÓN DEL THEME
  static const InvitationTheme theme = InvitationTheme(
    id: id,

    /// 🌸 Fondo general de la invitación
    /// 👉 Color crema / rosado muy suave
    backgroundColor: Color(0xFFFFF8F6),

    /// 🎀 Color principal
    /// 👉 Usado para títulos, elementos importantes
    primaryColor: Color(0xFFD8A7A7),

    /// 🌹 Color secundario (acento)
    /// 👉 Botones, iconos, detalles
    accentColor: Color(0xFFC48B8B),

    /// 🔤 Tipografía elegante (ya la tienes en assets)
    fontFamily: "Playfair",
  );
}
