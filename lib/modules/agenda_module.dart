import 'package:flutter/material.dart';

class AgendaModule extends StatelessWidget {
  final Map<String, dynamic> data;

  const AgendaModule({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final title = data["title"] ?? "Agenda";
    final items = List<Map<String, dynamic>>.from(data["items"] ?? []);

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),

          ...items.map((item) {
            final time = item["time"] ?? "";
            final itemTitle = item["title"] ?? "";
            final description = item["description"] ?? "";

            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Hora
                  SizedBox(
                    width: 70,
                    child: Text(
                      time,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),

                  // Contenido
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          itemTitle,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(description),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
