import 'package:flutter/material.dart';
import 'package:invitaty/themes/invitation_theme.dart';

class CoverModule extends StatelessWidget {
  final Map<String, dynamic> data;

  // 🎨 THEME GLOBAL DE LA INVITACIÓN
  // 👉 Base visual de toda la invitación
  final InvitationTheme theme;

  const CoverModule({super.key, required this.data, required this.theme});

  @override
  Widget build(BuildContext context) {
    // 🧠 NORMALIZACIÓN DE DATOS (backend-safe)
    final title = (data["title"] ?? "").toString();
    final subtitle = (data["subtitle"] ?? "").toString();

    // 🖼️ Imagen de fondo (futuro: CDN / backend storage)
    final imageUrl = (data["imageUrl"] ?? "").toString();

    /// 🔤 PRIORIDAD: data > theme
    final font = (data["font"] as String?)?.isNotEmpty == true
        ? data["font"]
        : theme.fontFamily;

    /// 📏 PRIORIDAD: data > theme
    final titleSize =
        (data["fontSizeTitle"] as num?)?.toDouble() ?? theme.titleFontSize;

    final subtitleSize =
        (data["fontSizeSubtitle"] as num?)?.toDouble() ?? theme.bodyFontSize;

    /// 🎨 PRIORIDAD: data > theme
    final textColor = _hexToColor(data["textColor"]) ?? theme.textColor;

    return Container(
      height: 300,
      width: double.infinity,

      // 🎨 FONDO: imagen o fallback con gradiente
      decoration: BoxDecoration(
        image: imageUrl.isNotEmpty
            ? DecorationImage(image: NetworkImage(imageUrl), fit: BoxFit.cover)
            : null,

        // 🌈 fallback visual si no hay imagen
        gradient: imageUrl.isEmpty
            ? LinearGradient(
                colors: [theme.primaryColor, theme.accentColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
      ),

      child: Container(
        padding: const EdgeInsets.all(20),
        alignment: Alignment.center,

        // 🔹 CONTENIDO TEXTO
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 🏷️ TÍTULO
            if (title.isNotEmpty)
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: titleSize,
                  fontWeight: FontWeight.bold,
                  fontFamily: font,
                  color: textColor,
                ),
              ),

            const SizedBox(height: 10),

            // 📝 SUBTÍTULO
            if (subtitle.isNotEmpty)
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: subtitleSize,
                  fontFamily: font,
                  color: textColor,
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// 🎨 CONVERSIÓN SEGURA HEX → COLOR
  /// Soporta:
  /// - "#RRGGBB"
  /// - "RRGGBB"
  /// - "0xFFRRGGBB"
  Color? _hexToColor(dynamic value) {
    if (value == null) return null;

    try {
      String hex = value.toString().trim();

      if (hex.startsWith("#")) hex = hex.substring(1);
      if (hex.startsWith("0x")) hex = hex.substring(2);
      if (hex.length == 6) hex = "FF$hex";

      return Color(int.parse(hex, radix: 16));
    } catch (_) {
      // ⚠️ fallback seguro (evita crash visual)
      return null;
    }
  }
}
