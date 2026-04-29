import 'package:flutter/material.dart';
import '../invitation_theme.dart';

/// 🎉 THEME: FUN
///
/// 👉 Pensado para cumpleaños infantiles
/// 👉 Estilo alegre, colorido y dinámico
///
/// 🎯 Objetivo:
/// - Sensación de fiesta
/// - Colores vivos pero controlados
/// - Tipografía divertida (Disney)
class FunTheme {
  /// 🆔 ID usado en JSON
  static const String id = "fun";

  static const InvitationTheme theme = InvitationTheme(
    id: id,

    /// 🆕 CLAVE DE TRADUCCIÓN DEL NOMBRE DEL THEME
    /// 👉 Usado para mostrar el nombre en UI traducido
    nameKey: "theme_fun",

    /// 🎈 Fondo limpio para no saturar
    backgroundColor: Color(0xFFFFFDF7),

    /// 🎨 Color principal (energía / títulos)
    primaryColor: Color(0xFF4A90E2), // azul alegre
    /// 🍭 Acento (botones, detalles)
    accentColor: Color(0xFFFFC107), // amarillo fiesta
    /// ✏️ Texto legible
    textColor: Color(0xFF2F2F2F),

    /// 🎠 Tipografía infantil divertida
    fontFamily: "Disney",

    /// 📏 Escala ligeramente más grande (sensación “infantil”)
    titleFontSize: 32,
    bodyFontSize: 22,
  );
}
