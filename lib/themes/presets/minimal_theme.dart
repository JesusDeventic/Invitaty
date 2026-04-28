import 'package:flutter/material.dart';
import '../invitation_theme.dart';

/// 🧊 THEME: MINIMAL
///
/// 👉 Pensado para cenas, eventos modernos, fiestas elegantes
/// 👉 Estilo limpio, sobrio y sin ruido visual
///
/// 🎯 Objetivo:
/// - Pocos colores
/// - Mucho espacio visual
/// - Elegancia moderna
class MinimalTheme {
  /// 🆔 ID usado en JSON
  static const String id = "minimal";

  static const InvitationTheme theme = InvitationTheme(
    id: id,

    /// ⚪ Fondo limpio
    backgroundColor: Color(0xFFF9F9F9),

    /// 🩶 Color principal (títulos)
    primaryColor: Color(0xFF444444),

    /// 🪶 Acento sutil (botones)
    accentColor: Color(0xFF9E9E9E),

    /// ✏️ Texto (máxima legibilidad)
    textColor: Color(0xFF2B2B2B),

    /// 🔤 Tipografía
    fontFamily: "Poppins",

    /// 📏 Tamaños contenidos
    titleFontSize: 22,
    bodyFontSize: 15,
  );
}
