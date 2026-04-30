import 'package:flutter/material.dart';
import 'package:invitaty/generated/l10n.dart';
import 'package:invitaty/themes/invitation_theme.dart';

/// 🖼️ MÓDULO DE GALERÍA
///
/// 🔹 Muestra imágenes en grid
/// 🔹 Actualmente usa URLs (picsum fake)
/// 🔹 FUTURO:
///    - imágenes subidas por usuario
///    - URLs desde backend (S3 / Firebase / CDN)
class GalleryModule extends StatelessWidget {
  final Map<String, dynamic> data;

  /// 🎨 THEME GLOBAL DE LA INVITACIÓN
  /// 👉 Define estética base del módulo
  final InvitationTheme theme;

  const GalleryModule({super.key, required this.data, required this.theme});

  @override
  Widget build(BuildContext context) {
    /// 🏷️ TÍTULO (backend-safe)
    final title = (data["title"] ?? S.of(context).moduleNameGallery).toString();

    /// 🖼️ IMÁGENES (backend-safe)
    final images = List<String>.from(data["images"] ?? []);

    /// 🔤 FONT (data > theme)
    final font = (data["font"] as String?)?.isNotEmpty == true
        ? data["font"]
        : theme.fontFamily;

    /// 🎨 COLORS (data > theme)
    final titleColor = _hexToColor(data["titleColor"]) ?? theme.primaryColor;

    final textColor = _hexToColor(data["textColor"]) ?? theme.textColor;

    final accentColor = _hexToColor(data["accentColor"]) ?? theme.accentColor;

    /// 📏 SIZES (coherente con resto de módulos)
    final titleSize =
        (data["titleFontSize"] as num?)?.toDouble() ?? theme.titleFontSize;

    final bodySize =
        (data["bodyFontSize"] as num?)?.toDouble() ?? theme.bodyFontSize;

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 8),

      /// 🎨 fondo coherente con el resto de módulos
      decoration: BoxDecoration(
        color: theme.backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 🏷️ TÍTULO
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: titleSize,
              fontWeight: FontWeight.bold,
              fontFamily: font,
              color: titleColor,
            ),
          ),

          const SizedBox(height: 16),

          // 🖼️ GRID / EMPTY STATE
          if (images.isEmpty)
            Text(
              S.of(context).editGalleryNoImages,
              style: TextStyle(
                fontSize: bodySize,
                fontFamily: font,
                color: textColor.withValues(alpha: 0.6),
              ),
            )
          else
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),

              /// 🔢 número de imágenes
              itemCount: images.length,

              /// 📐 layout grid
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 6,
                mainAxisSpacing: 6,
              ),

              /// 🖼️ render imagen
              itemBuilder: (context, index) {
                final imageUrl = images[index];

                return ClipRRect(
                  borderRadius: BorderRadius.circular(10),

                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,

                    /// ⚠️ fallback UX
                    errorBuilder: (_, _, _) => Container(
                      color: accentColor.withValues(alpha: 0.1),
                      child: Icon(Icons.broken_image, color: accentColor),
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }

  /// 🎨 HEX → COLOR (backend-safe estándar del proyecto)
  Color? _hexToColor(dynamic value) {
    if (value == null) return null;

    try {
      String hex = value.toString().trim();

      if (hex.startsWith("#")) hex = hex.substring(1);
      if (hex.startsWith("0x")) hex = hex.substring(2);
      if (hex.length == 6) hex = "FF$hex";

      return Color(int.parse(hex, radix: 16));
    } catch (_) {
      return null;
    }
  }
}
