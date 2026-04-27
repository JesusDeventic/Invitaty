import 'package:flutter/material.dart';
import 'package:invitaty/themes/invitation_theme.dart';

class CoverModule extends StatelessWidget {
  // 📦 DATA dinámica (vendrá del backend en el futuro)
  final Map<String, dynamic> data;

  const CoverModule({
    super.key,
    required this.data,
    required InvitationTheme theme,
  });

  @override
  Widget build(BuildContext context) {
    // 🧠 NORMALIZACIÓN DE DATOS (muy importante para backend)
    final title = (data["title"] ?? "").toString();
    final subtitle = (data["subtitle"] ?? "").toString();
    final imageUrl = (data["imageUrl"] ?? "").toString();

    final font = (data["font"] ?? "Poppins").toString();

    final titleSize = (data["fontSizeTitle"] ?? 28).toDouble();
    final subtitleSize = (data["fontSizeSubtitle"] ?? 18).toDouble();

    final textColorHex = data["textColor"] ?? "#FFFFFF";
    final textColor = _hexToColor(textColorHex);

    return Container(
      height: 300,
      width: double.infinity,

      // 🎨 FONDO: imagen o fallback con gradiente
      decoration: BoxDecoration(
        image: imageUrl.isNotEmpty
            ? DecorationImage(
                image: NetworkImage(
                  imageUrl,
                ), // 🔥 FUTURO: vendrá del backend/CDN
                fit: BoxFit.cover,
              )
            : null,

        gradient: imageUrl.isEmpty
            ? const LinearGradient(
                colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
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
  Color _hexToColor(dynamic value) {
    try {
      String hex = value.toString().replaceAll("#", "");

      if (hex.startsWith("0x")) {
        hex = hex.substring(2);
      }

      if (hex.length == 6) {
        hex = "FF$hex";
      }

      return Color(int.parse(hex, radix: 16));
    } catch (_) {
      return Colors.white;
    }
  }
}
