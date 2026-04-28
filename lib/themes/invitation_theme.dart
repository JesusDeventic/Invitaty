import 'package:flutter/material.dart';

/// 🎨 MODELO DE TEMA DE INVITACIÓN
///
/// 👉 Define el estilo global de TODA la invitación
/// 👉 NO afecta a la app (eso es ThemeProvider)
class InvitationTheme {
  /// 🔹 Nombre interno (ej: elegant, modern...)
  final String id;

  /// 🎨 COLORES
  final Color backgroundColor;

  /// 🎨 COLOR PRINCIPAL
  /// 👉 Títulos, elementos destacados
  final Color primaryColor;

  /// 🎨 COLOR SECUNDARIO / ACENTO
  /// 👉 Botones, detalles, iconos
  final Color accentColor;

  /// 🆕 COLOR DE TEXTO GLOBAL
  final Color textColor;

  /// 🔤 TIPOGRAFÍA
  final String fontFamily;

  /// 🆕 TAMAÑOS BASE
  final double titleFontSize;
  final double bodyFontSize;

  const InvitationTheme({
    required this.id,
    required this.backgroundColor,
    required this.primaryColor,
    required this.accentColor,

    /// 🆕 NUEVOS CAMPOS
    required this.textColor,
    required this.fontFamily,
    required this.titleFontSize,
    required this.bodyFontSize,
  });

  /// 🧪 DEBUG
  @override
  String toString() {
    return 'InvitationTheme(id: $id)';
  }
}
