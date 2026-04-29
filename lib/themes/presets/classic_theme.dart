import 'package:flutter/material.dart';
import '../invitation_theme.dart';

/// 👶 THEME: CLASSIC
///
/// 👉 Pensado para bautizos y comuniones
/// 👉 Estilo limpio, luminoso y ceremonial
///
/// 🎯 Objetivo:
/// - Sensación de pureza e inocencia
/// - Estética religiosa suave (sin recargar)
/// - Colores neutros con acento elegante
class ClassicTheme {
  /// 🆔 ID que se usará en el JSON
  /// {
  ///   "theme": "classic"
  /// }
  static const String id = "classic";

  static const InvitationTheme theme = InvitationTheme(
    id: id,

    /// 🆕 CLAVE DE TRADUCCIÓN DEL NOMBRE DEL THEME
    /// 👉 Usado para mostrar el nombre en UI traducido
    nameKey: "theme_classic",

    /// 🤍 Fondo principal (más “papel” que rosa)
    backgroundColor: Color(0xFFFBFBF7),

    /// 🌿 Color principal (títulos)
    /// suave, frío, limpio (sensación de calma)
    primaryColor: Color(0xFF7FA6A3),

    /// ✨ Acento (detalles / botones)
    /// dorado suave ceremonial
    accentColor: Color(0xFFC8B07A),

    /// 🆕 TEXTO
    /// oscuro pero no negro puro (más suave visualmente)
    textColor: Color(0xFF3F3F3A),

    /// 🔤 Tipografía
    /// más clásica que elegante romántico
    fontFamily: "Playfair",

    /// 🆕 TIPOGRAFÍA BASE
    titleFontSize: 26,
    bodyFontSize: 18,
  );
}
