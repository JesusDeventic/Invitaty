import 'package:flutter/material.dart';
import 'package:invitaty/modules/module_registry.dart';
import 'package:invitaty/modules/module_type.dart';
import 'package:provider/provider.dart';
import 'package:invitaty/providers/invitation_provider.dart';
import 'package:invitaty/generated/l10n.dart';

// 🆕 IMPORT DEL THEME
import 'package:invitaty/themes/theme_registry.dart';

class ViewerScreen extends StatelessWidget {
  const ViewerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final invitationProvider = context.watch<InvitationProvider>();

    /// 📦 SECCIONES DE LA INVITACIÓN
    final sections = invitationProvider.sections;

    /// 🎨 OBTENER THEME DESDE EL JSON
    ///
    /// 🔥 IMPORTANTE:
    /// - El JSON tiene: "theme": "elegant"
    /// - El provider debería exponerlo (si no, ahora lo añadimos luego)
    final themeId = invitationProvider.invitation["theme"];

    /// 🎨 RESOLVER THEME REAL
    final theme = ThemeRegistry.get(themeId);

    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.appName),

        /// 🆕 OPCIONAL (puedes activarlo luego)
        /// 👉 AppBar con color del theme
        // backgroundColor: theme.primaryColor,
      ),

      /// 🎨 FONDO GLOBAL DE LA INVITACIÓN
      ///
      /// 🔥 ESTE ES EL CAMBIO IMPORTANTE
      body: Container(
        color: theme.backgroundColor,

        child: ListView(
          children: sections.map((section) {
            final typeString = section["type"] as String;
            final data = section["data"] as Map<String, dynamic>;

            final type = _parseModuleType(typeString);

            /// 🧩 CONSTRUCCIÓN DEL MÓDULO
            ///
            /// 🔜 FUTURO:
            /// aquí podríamos pasar también el theme al módulo
            return ModuleRegistry.build(type, data, theme);
          }).toList(),
        ),
      ),
    );
  }

  /// 🔄 PARSER STRING → ENUM
  ///
  /// 👉 Convierte:
  /// "cover" → ModuleType.cover
  ModuleType _parseModuleType(String type) {
    switch (type) {
      case "text":
        return ModuleType.text;
      case "cover":
        return ModuleType.cover;
      case "countdown":
        return ModuleType.countdown;
      case "location":
        return ModuleType.location;
      case "rsvp":
        return ModuleType.rsvp;
      case "gallery":
        return ModuleType.gallery;
      case "video":
        return ModuleType.video;
      case "agenda":
        return ModuleType.agenda;
      case "dressCode":
        return ModuleType.dressCode;
      case "gifts":
        return ModuleType.gifts;
      case "music":
        return ModuleType.music;
      default:
        return ModuleType.text; // fallback seguro
    }
  }
}
