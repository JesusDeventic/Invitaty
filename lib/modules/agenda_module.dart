import 'package:flutter/material.dart';

class AgendaModule extends StatelessWidget {
  final Map<String, dynamic> data;

  const AgendaModule({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final title = data["title"] ?? "Agenda";
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
          // 🔹 TÍTULO CENTRADO
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24, // 🔥 más grande
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          // 🔹 LISTA
          ...List.generate(items.length, (index) {
            final item = items[index];

            final time = item["time"] ?? "";
            final itemTitle = item["title"] ?? "";
            final description = item["description"] ?? "";

            final isLast = index == items.length - 1;

            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔹 TIMELINE
                Column(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                    ),

                    if (!isLast)
                      Container(
                        width: 2,
                        height: 70,
                        color: Colors.grey.shade300,
                      ),
                  ],
                ),

                const SizedBox(width: 16),

                // 🔹 CONTENIDO
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 260),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Hora
                      if (time.isNotEmpty)
                        Text(
                          time,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),

                      const SizedBox(height: 4),

                      // Título evento
                      if (itemTitle.isNotEmpty)
                        Text(
                          itemTitle,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18, // 🔥 más grande
                          ),
                        ),

                      const SizedBox(height: 4),

                      // Descripción
                      if (description.isNotEmpty)
                        Text(
                          description,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey.shade700,
                          ),
                        ),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}
