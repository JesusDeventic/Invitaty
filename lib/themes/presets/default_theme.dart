import 'package:flutter/material.dart';
import '../invitation_theme.dart';

/// 🧩 THEME: DEFAULT
///
/// 👉 Tema neutro del sistema
/// 👉 Usado cuando la plantilla es totalmente personalizable
/// 👉 Fallback final de seguridad
class DefaultTheme {
  /// 🆔 ID del theme
  static const String id = "default";

  static const InvitationTheme theme = InvitationTheme(
    id: id,

    /// 🎨 Fondo neutro absoluto
    backgroundColor: Colors.white,

    /// 🧱 Color principal (texto/títulos)
    primaryColor: Color(0xFF2E2E2E),

    /// 🎯 Acento mínimo (UI actions)
    accentColor: Color(0xFF6B6B6B),

    /// 📝 Texto base
    textColor: Color(0xFF2E2E2E),

    /// 🔤 Tipografía estándar del sistema
    fontFamily: "Roboto",

    /// 📏 Escala base conservadora
    titleFontSize: 22,
    bodyFontSize: 15,
  );
}
