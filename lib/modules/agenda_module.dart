import 'package:flutter/material.dart';
import 'package:invitaty/generated/l10n.dart';
import 'package:invitaty/themes/invitation_theme.dart';

class AgendaModule extends StatelessWidget {
  final Map<String, dynamic> data;

  /// 🎨 THEME GLOBAL DE LA INVITACIÓN
  /// 👉 Base visual del módulo (no reemplaza datos del backend)
  final InvitationTheme theme;

  const AgendaModule({super.key, required this.data, required this.theme});

  @override
  Widget build(BuildContext context) {
    // 🧠 TITULO DEL MÓDULO (fallback internacionalizado)
    final title = (data["title"] ?? S.of(context).moduleNameAgenda).toString();

    // 📦 ITEMS DEL BACKEND (lista de eventos)
    final items = List<Map<String, dynamic>>.from(data["items"] ?? []);

    /// 🔤 PRIORIDAD: data > theme
    final font = (data["font"] as String?)?.isNotEmpty == true
        ? data["font"]
        : theme.fontFamily;

    /// 🎨 COLORS (data > theme)
    final textColor = _hexToColor(data["textColor"]) ?? theme.textColor;

    final accentColor = _hexToColor(data["accentColor"]) ?? theme.accentColor;

    final titleColor = _hexToColor(data["titleColor"]) ?? theme.primaryColor;

    /// 📏 SIZES (CONSISTENTE CON COVERMODULE)
    /// 🧠 sin hardcode, todo viene de theme o override futuro
    final titleSize =
        (data["titleFontSize"] as num?)?.toDouble() ?? theme.titleFontSize;

    final bodySize =
        (data["bodyFontSize"] as num?)?.toDouble() ?? theme.bodyFontSize;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      padding: const EdgeInsets.all(20),

      /// 🎨 fondo global del theme
      decoration: BoxDecoration(
        color: theme.backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 🧾 TITULO PRINCIPAL DEL MÓDULO
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

          const SizedBox(height: 24),

          // 📍 CONTENEDOR CENTRADO (limita ancho para legibilidad)
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),

              // 🧭 TIMELINE VISUAL
              child: Stack(
                children: [
                  // 🧵 línea vertical
                  Positioned(
                    left: 20,
                    top: 0,
                    bottom: 0,
                    child: Container(
                      width: 2,
                      color: accentColor.withValues(alpha: 0.3),
                    ),
                  ),

                  Column(
                    children: List.generate(items.length, (index) {
                      final item = items[index];

                      // 🧠 CAMPOS BACKEND-READY
                      final time = (item["time"] ?? "").toString();
                      final itemTitle = (item["title"] ?? "").toString();
                      final description = (item["description"] ?? "")
                          .toString();

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 24),

                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 🔴 marcador
                            SizedBox(
                              width: 40,
                              child: Center(
                                child: Container(
                                  width: 12,
                                  height: 12,
                                  decoration: BoxDecoration(
                                    color: accentColor,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(width: 12),

                            // 📝 contenido
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (time.isNotEmpty)
                                    Text(
                                      time,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: bodySize - 1,
                                        fontFamily: font,
                                        color: textColor,
                                      ),
                                    ),

                                  const SizedBox(height: 4),

                                  if (itemTitle.isNotEmpty)
                                    Text(
                                      itemTitle,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: bodySize + 2,
                                        fontFamily: font,
                                        color: textColor,
                                      ),
                                    ),

                                  const SizedBox(height: 4),

                                  if (description.isNotEmpty)
                                    Text(
                                      description,
                                      style: TextStyle(
                                        fontSize: bodySize - 2,
                                        fontFamily: font,
                                        color: textColor.withValues(alpha: 0.8),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 🎨 HEX → COLOR (backend-safe igual que CoverModule)
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
