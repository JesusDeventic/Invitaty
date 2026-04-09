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
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔹 TÍTULO
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 16),

          // 🔹 LISTA DE EVENTOS
          ...List.generate(items.length, (index) {
            final item = items[index];

            final time = item["time"] ?? "";
            final itemTitle = item["title"] ?? "";
            final description = item["description"] ?? "";

            final isLast = index == items.length - 1;

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔹 TIMELINE (punto + línea)
                Column(
                  children: [
                    // Punto
                    Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                    ),

                    // Línea
                    if (!isLast)
                      Container(
                        width: 2,
                        height: 60,
                        color: Colors.grey.shade300,
                      ),
                  ],
                ),

                const SizedBox(width: 12),

                // 🔹 CONTENIDO
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Hora + título
                        Row(
                          children: [
                            Text(
                              time,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                itemTitle,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 4),

                        // Descripción
                        if (description.isNotEmpty)
                          Text(
                            description,
                            style: TextStyle(color: Colors.grey.shade700),
                          ),
                      ],
                    ),
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
