import 'package:flutter/material.dart';
import 'package:invitaty/generated/l10n.dart';
import 'package:invitaty/themes/invitation_theme.dart';

class AgendaModule extends StatelessWidget {
  final Map<String, dynamic> data;

  const AgendaModule({
    super.key,
    required this.data,
    required InvitationTheme theme,
  });

  @override
  Widget build(BuildContext context) {
    // 🧠 TITULO DEL MÓDULO (fallback internacionalizado)
    final title = (data["title"] ?? S.of(context).moduleNameAgenda).toString();

    // 📦 ITEMS DEL BACKEND (lista de eventos)
    // Cada item: { time, title, description }
    final items = List<Map<String, dynamic>>.from(data["items"] ?? []);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 🧾 TITULO PRINCIPAL DEL MÓDULO
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                    child: Container(width: 2, color: Colors.grey.shade300),
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
                                  decoration: const BoxDecoration(
                                    color: Colors.black,
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
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),

                                  const SizedBox(height: 4),

                                  if (itemTitle.isNotEmpty)
                                    Text(
                                      itemTitle,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                      ),
                                    ),

                                  const SizedBox(height: 4),

                                  if (description.isNotEmpty)
                                    Text(
                                      description,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey.shade700,
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
