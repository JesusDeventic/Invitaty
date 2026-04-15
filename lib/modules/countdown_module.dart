import 'package:flutter/material.dart';

class CountdownModule extends StatelessWidget {
  final Map<String, dynamic> data;

  const CountdownModule({super.key, required this.data});

  DateTime? _parseDate(dynamic value) {
    if (value == null) return null;
    return DateTime.tryParse(value.toString());
  }

  @override
  Widget build(BuildContext context) {
    final title = data["title"] ?? "Cuenta atrás";
    final eventDateTime = _parseDate(data["eventDateTime"]);

    if (eventDateTime == null) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Text("Fecha no definida"),
      );
    }

    final now = DateTime.now();
    final difference = eventDateTime.difference(now);

    final isPast = difference.isNegative;

    final safeDifference = isPast ? Duration.zero : difference;

    final days = safeDifference.inDays;
    final hours = safeDifference.inHours % 24;
    final minutes = safeDifference.inMinutes % 60;

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
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),

          Text(
            isPast
                ? "El evento ya ha comenzado"
                : "$days días · $hours horas · $minutes minutos",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              color: isPast ? Colors.redAccent : Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
