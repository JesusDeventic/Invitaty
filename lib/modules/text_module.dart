import 'package:flutter/material.dart';
import 'package:invitaty/themes/invitation_theme.dart';

class TextModule extends StatelessWidget {
  final Map<String, dynamic> data;

  /// 🎨 Tema global de la invitación
  final InvitationTheme theme;

  const TextModule({super.key, required this.data, required this.theme});

  @override
  Widget build(BuildContext context) {
    // 🧠 CONTENIDO
    final title = (data["title"] ?? "").toString();
    final body = (data["body"] ?? "").toString();

    /// 🎨 CONFIGURACIÓN CON PRIORIDAD CORRECTA

    // 🔹 FUENTE
    // 1. Usuario
    // 2. Tema
    // 3. Fallback
    final font = (data["font"] as String?) ?? theme.fontFamily;

    // 🔹 TAMAÑO
    final fontSize =
        (data["fontSize"] as num?)?.toDouble() ?? theme.bodyFontSize;

    // 🔹 COLOR
    final color = _parseColor(data["color"]) ?? theme.textColor;

    return Padding(
      padding: const EdgeInsets.all(16.0),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 🔹 TÍTULO
          if (title.isNotEmpty)
            Text(
              title,
              textAlign: TextAlign.center,

              /// 🔥 AQUÍ el tema también influye
              style: TextStyle(
                fontSize: (theme.titleFontSize),
                fontWeight: FontWeight.bold,
                fontFamily: font,
                color: color,
              ),
            ),

          const SizedBox(height: 8),

          // 🔹 CUERPO
          if (body.isNotEmpty)
            Text(
              body,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fontSize,
                fontFamily: font,
                color: color,
              ),
            ),
        ],
      ),
    );
  }

  /// 🎨 PARSER COLOR BACKEND-SAFE
  Color? _parseColor(dynamic value) {
    if (value == null) return null;

    try {
      String hex = value.toString().trim();

      if (hex.startsWith("#")) {
        hex = hex.substring(1);
      }

      if (hex.length == 6) {
        hex = "FF$hex";
      }

      if (hex.startsWith("0x")) {
        hex = hex.substring(2);
      }

      return Color(int.parse(hex, radix: 16));
    } catch (_) {
      return null;
    }
  }
}
