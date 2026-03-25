import 'package:flutter/material.dart';

class CountdownModule extends StatelessWidget {
  final Map<String, dynamic> data;

  const CountdownModule({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final title = data["title"] ?? "Cuenta atrás";

    final eventDateTime = DateTime.parse(data["eventDateTime"]);
    final remaining = eventDateTime.difference(DateTime.now());

    final days = remaining.inDays;
    final hours = remaining.inHours % 24;
    final minutes = remaining.inMinutes % 60;

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            "$days días $hours horas $minutes minutos",
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
