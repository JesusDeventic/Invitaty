import 'package:flutter/material.dart';

class CountdownModule extends StatelessWidget {
  final Map<String, dynamic> data;

  const CountdownModule({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final title = data["title"] ?? "Cuenta atrás";

    // 🛡️ PROTECCIÓN CONTRA NULL
    final eventString = data["eventDateTime"];

    DateTime? eventDateTime;

    if (eventString != null && eventString is String) {
      try {
        eventDateTime = DateTime.parse(eventString);
      } catch (e) {
        eventDateTime = null;
      }
    }

    // 🛑 SI NO HAY FECHA → NO CRASHEA
    if (eventDateTime == null) {
      return Container(
        padding: const EdgeInsets.all(16),
        child: const Text("Fecha no definida"),
      );
    }

    final now = DateTime.now();
    final difference = eventDateTime.difference(now);

    final days = difference.inDays;
    final hours = difference.inHours % 24;
    final minutes = difference.inMinutes % 60;

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text("$days días $hours horas $minutes minutos"),
        ],
      ),
    );
  }
}
