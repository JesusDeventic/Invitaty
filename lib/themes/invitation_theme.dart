import 'package:flutter/material.dart';
import 'package:invitaty/generated/l10n.dart';

class InvitationTheme {
  final String id;
  final String nameKey;

  final Color backgroundColor;
  final Color primaryColor;
  final Color accentColor;
  final Color textColor;

  final String fontFamily;
  final double titleFontSize;
  final double bodyFontSize;

  const InvitationTheme({
    required this.id,
    required this.nameKey,
    required this.backgroundColor,
    required this.primaryColor,
    required this.accentColor,
    required this.textColor,
    required this.fontFamily,
    required this.titleFontSize,
    required this.bodyFontSize,
  });

  /// 🌍 NOMBRE TRADUCIDO DEL THEME
  String getDisplayName(BuildContext context) {
    final s = S.of(context);

    switch (nameKey) {
      case "theme_elegant":
        return s.themeElegant;
      case "theme_classic":
        return s.themeClassic;
      case "theme_christmas":
        return s.themeChristmas;
      case "theme_fun":
        return s.themeFun;
      case "theme_minimal":
        return s.themeMinimal;
      case "theme_default":
        return s.themeDefault;
      default:
        return nameKey;
    }
  }

  /// 🧠 OVERRIDE DEL THEME (APLICA CUSTOMIZACIÓN DEL USUARIO)
  InvitationTheme copyWithOverride(Map<String, dynamic> override) {
    return InvitationTheme(
      id: id,
      nameKey: nameKey,

      /// 🆕 TODOS LOS CAMPOS SOPORTAN OVERRIDE
      backgroundColor: override["backgroundColor"] != null
          ? Color(override["backgroundColor"])
          : backgroundColor,

      primaryColor: override["primaryColor"] != null
          ? Color(override["primaryColor"])
          : primaryColor,

      accentColor: override["accentColor"] != null
          ? Color(override["accentColor"])
          : accentColor,

      textColor: override["textColor"] != null
          ? Color(override["textColor"])
          : textColor,

      fontFamily: override["fontFamily"] ?? fontFamily,

      titleFontSize: override["titleFontSize"] != null
          ? (override["titleFontSize"] as num).toDouble()
          : titleFontSize,

      bodyFontSize: override["bodyFontSize"] != null
          ? (override["bodyFontSize"] as num).toDouble()
          : bodyFontSize,
    );
  }

  /// 🧪 DEBUG
  @override
  String toString() {
    return 'InvitationTheme(id: $id)';
  }
}
