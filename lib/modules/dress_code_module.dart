import 'package:flutter/material.dart';
import 'package:invitaty/generated/l10n.dart';
import 'package:invitaty/themes/invitation_theme.dart';

class DressCodeModule extends StatelessWidget {
  final Map<String, dynamic> data;

  /// 🎨 THEME GLOBAL DE LA INVITACIÓN
  /// 👉 Define base visual del módulo
  final InvitationTheme theme;

  const DressCodeModule({super.key, required this.data, required this.theme});

  @override
  Widget build(BuildContext context) {
    // 🧠 NORMALIZACIÓN (backend-safe)
    final title = (data["title"] ?? S.of(context).moduleNameDressCode)
        .toString();

    final style = (data["style"] ?? "").toString();
    final description = (data["description"] ?? "").toString();

    /// 🔤 FONT (data > theme)
    final font = (data["font"] as String?)?.isNotEmpty == true
        ? data["font"]
        : theme.fontFamily;

    /// 🎨 COLORS (data > theme)
    final titleColor = _hexToColor(data["titleColor"]) ?? theme.primaryColor;

    final textColor = _hexToColor(data["textColor"]) ?? theme.textColor;

    final accentColor = _hexToColor(data["accentColor"]) ?? theme.accentColor;

    /// 📏 SIZES (consistente con resto de módulos)
    final titleSize =
        (data["titleFontSize"] as num?)?.toDouble() ?? theme.titleFontSize;

    final bodySize =
        (data["bodyFontSize"] as num?)?.toDouble() ?? theme.bodyFontSize;

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),

      /// 🎨 fondo consistente con theme global
      decoration: BoxDecoration(
        color: theme.backgroundColor,
        border: Border.all(color: accentColor.withValues(alpha: 0.2)),
        borderRadius: BorderRadius.circular(12),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 👕 ICONO VISUAL DEL MÓDULO
          Icon(Icons.checkroom, size: 32, color: titleColor),

          const SizedBox(height: 8),

          // 🏷️ TÍTULO DEL MÓDULO
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

          const SizedBox(height: 12),

          // 🎯 ESTILO PRINCIPAL (CLAVE BACKEND)
          // 🔥 IMPORTANTE:
          // - NO es texto traducido
          // - es clave lógica ("formal", "casual", etc.)
          if (style.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),

              decoration: BoxDecoration(
                color: accentColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(20),
              ),

              child: Text(
                style,
                style: TextStyle(
                  fontSize: bodySize,
                  fontWeight: FontWeight.w600,
                  fontFamily: font,
                  color: titleColor,
                ),
              ),
            ),

          // 📝 DESCRIPCIÓN OPCIONAL
          if (description.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: bodySize - 1,
                fontFamily: font,
                color: textColor.withValues(alpha: 0.9),
              ),
            ),
          ],
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
