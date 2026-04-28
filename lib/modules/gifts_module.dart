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
    /// 🧠 DATOS PRINCIPALES DEL MÓDULO
    /// Se leen desde el JSON del backend/local storage
    final title = (data["title"] ?? S.of(context).moduleNameGifts).toString();
    final message = (data["message"] ?? "").toString();
    final iban = data["iban"];
    final bizum = data["bizum"];
    final link = data["link"];

    /// 📋 LISTA DE IDEAS DE REGALO
    final items = List<String>.from(data["items"] ?? []);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      padding: const EdgeInsets.all(16),

      /// 🎨 fondo coherente con el sistema de invitación
      decoration: BoxDecoration(
        color: theme.backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.primaryColor.withValues(alpha: 0.15)),
      ),

      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// 🎁 ICONO PRINCIPAL DEL MÓDULO
              Icon(Icons.card_giftcard, size: 32, color: theme.primaryColor),

              const SizedBox(height: 8),

              /// 🏷️ TÍTULO DEL MÓDULO
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: theme.fontFamily,
                  color: theme.primaryColor,
                ),
              ),

              /// 💬 MENSAJE OPCIONAL
              if (message.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: theme.fontFamily,
                    color: theme.textColor,
                  ),
                ),
              ],

              const SizedBox(height: 16),

              /// 🏦 IBAN (SI EXISTE)
              if (iban != null && iban.toString().isNotEmpty)
                _buildCopyBox(
                  context,
                  S.of(context).labelIban,
                  iban.toString(),
                ),

              /// 📱 BIZUM (SI EXISTE)
              if (bizum != null && bizum.toString().isNotEmpty)
                _buildCopyBox(
                  context,
                  S.of(context).labelBizum,
                  bizum.toString(),
                ),

              /// 🔗 LINK EXTERNO
              if (link != null && link.toString().isNotEmpty) ...[
                const SizedBox(height: 12),
                ElevatedButton.icon(
                  onPressed: () async {
                    final uri = Uri.parse(link.toString());
                    await launchUrl(uri);
                  },

                  /// 🎨 botón coherente con el theme
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.accentColor,
                  ),

                  icon: const Icon(Icons.open_in_new),
                  label: Text(
                    S.of(context).giftsList,
                    style: TextStyle(fontFamily: theme.fontFamily),
                  ),
                ),
              ],

              /// 🎁 LISTA DE IDEAS DE REGALO
              if (items.isNotEmpty) ...[
                const SizedBox(height: 16),

                Text(
                  S.of(context).editGiftIdeas,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: theme.fontFamily,
                    color: theme.primaryColor,
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
                              fontFamily: theme.fontFamily,
                              color: theme.textColor,
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

  /// 📋 WIDGET AUXILIAR: BLOQUE COPIABLE
  /// Se usa para IBAN y Bizum
  /// Incluye botón de copiar al portapapeles
  Widget _buildCopyBox(BuildContext context, String label, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),

      /// 🎨 caja adaptada al theme
      decoration: BoxDecoration(
        color: theme.backgroundColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: theme.primaryColor.withValues(alpha: 0.2)),
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// Texto centrado con etiqueta + valor
          Expanded(
            child: Text(
              "$label: $value",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: theme.fontFamily,
                color: theme.textColor,
              ),
            ),
          ),

          /// 📋 COPIAR AL PORTAPAPELES
          IconButton(
            icon: Icon(Icons.copy, color: theme.primaryColor),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: value));
            },
          ),
        ],
      ),
    );
  }
}
