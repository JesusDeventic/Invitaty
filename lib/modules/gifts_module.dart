import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:invitaty/themes/invitation_theme.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:invitaty/generated/l10n.dart';

/// 📦 GIFT MODULE
/// Muestra la sección de regalos en la invitación.
/// Soporta:
/// - Mensaje personalizado
/// - IBAN / Bizum con copia
/// - Enlace externo
/// - Lista de ideas de regalo
class GiftsModule extends StatelessWidget {
  final Map<String, dynamic> data;

  /// 🎨 THEME GLOBAL DE LA INVITACIÓN
  /// 👉 Define estética base del módulo
  final InvitationTheme theme;

  const GiftsModule({super.key, required this.data, required this.theme});

  @override
  Widget build(BuildContext context) {
    /// 🧠 DATOS PRINCIPALES (backend-safe)
    final title = (data["title"] ?? S.of(context).moduleNameGifts).toString();

    final message = (data["message"] ?? "").toString();

    final iban = data["iban"];
    final bizum = data["bizum"];
    final link = data["link"];

    /// 📋 LISTA DE IDEAS DE REGALO
    final items = List<String>.from(data["items"] ?? []);

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
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      padding: const EdgeInsets.all(16),

      /// 🎨 fondo coherente con el sistema de invitación
      decoration: BoxDecoration(
        color: theme.backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accentColor.withValues(alpha: 0.15)),
      ),

      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// 🎁 ICONO PRINCIPAL
              Icon(Icons.card_giftcard, size: 32, color: titleColor),

              const SizedBox(height: 8),

              /// 🏷️ TÍTULO
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

              /// 💬 MENSAJE OPCIONAL
              if (message.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: bodySize,
                    fontFamily: font,
                    color: textColor,
                  ),
                ),
              ],

              const SizedBox(height: 16),

              /// 🏦 IBAN
              if (iban != null && iban.toString().isNotEmpty)
                _buildCopyBox(
                  context,
                  S.of(context).labelIban,
                  iban.toString(),
                  font,
                  textColor,
                  accentColor,
                ),

              /// 📱 BIZUM
              if (bizum != null && bizum.toString().isNotEmpty)
                _buildCopyBox(
                  context,
                  S.of(context).labelBizum,
                  bizum.toString(),
                  font,
                  textColor,
                  accentColor,
                ),

              /// 🔗 LINK EXTERNO
              if (link != null && link.toString().isNotEmpty) ...[
                const SizedBox(height: 12),
                ElevatedButton.icon(
                  onPressed: () async {
                    final uri = Uri.parse(link.toString());
                    await launchUrl(uri);
                  },

                  style: ElevatedButton.styleFrom(backgroundColor: accentColor),

                  icon: const Icon(Icons.open_in_new),
                  label: Text(
                    S.of(context).giftsList,
                    style: TextStyle(fontFamily: font),
                  ),
                ),
              ],

              /// 🎁 LISTA DE IDEAS
              if (items.isNotEmpty) ...[
                const SizedBox(height: 16),

                Text(
                  S.of(context).editGiftIdeas,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: bodySize,
                    fontWeight: FontWeight.bold,
                    fontFamily: font,
                    color: titleColor,
                  ),
                ),

                const SizedBox(height: 8),

                Column(
                  children: items
                      .where((e) => e.trim().isNotEmpty)
                      .map(
                        (item) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Text(
                            "• $item",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: bodySize - 1,
                              fontFamily: font,
                              color: textColor,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  /// 📋 BLOQUE COPIABLE (refactor consistente)
  Widget _buildCopyBox(
    BuildContext context,
    String label,
    String value,
    String font,
    Color textColor,
    Color accentColor,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),

      /// 🎨 caja adaptada al theme
      decoration: BoxDecoration(
        color: theme.backgroundColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: accentColor.withValues(alpha: 0.2)),
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// Texto centrado con etiqueta + valor
          Expanded(
            child: Text(
              "$label: $value",
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: font, color: textColor),
            ),
          ),

          /// 📋 COPIAR AL PORTAPAPELES
          IconButton(
            icon: Icon(Icons.copy, color: accentColor),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: value));
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
