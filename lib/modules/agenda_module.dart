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
    // Cada item: { time, title, description }
    final items = List<Map<String, dynamic>>.from(data["items"] ?? []);

    // 🔤 fuente global (theme base)
    final font = theme.fontFamily;

    // 🎨 colores base del timeline
    final titleColor = theme.primaryColor;
    final textColor = theme.textColor;
    final accentColor = theme.accentColor;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      padding: const EdgeInsets.all(20),

      /// 🎨 fondo basado en theme (coherencia global)
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
              fontSize: 24,
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
                  // 🧵 línea vertical de la agenda
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

                      // 🧠 CAMPOS DEL EVENTO (backend-ready)
                      final time = (item["time"] ?? "").toString();
                      final itemTitle = (item["title"] ?? "").toString();
                      final description = (item["description"] ?? "")
                          .toString();

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 24),

                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 🔴 marcador del evento
                            SizedBox(
                              width: 40,
                              child: Center(
                                child: Container(
                                  width: 12,
                                  height: 12,

                                  /// 🎨 marcador con color del theme
                                  decoration: BoxDecoration(
                                    color: accentColor,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(width: 12),

                            // 📝 contenido del evento
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (time.isNotEmpty)
                                    Text(
                                      time,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
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
                                        fontSize: 17,
                                        fontFamily: font,
                                        color: textColor,
                                      ),
                                    ),

                                  const SizedBox(height: 4),

                                  if (description.isNotEmpty)
                                    Text(
                                      description,
                                      style: TextStyle(
                                        fontSize: 14,
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
}
