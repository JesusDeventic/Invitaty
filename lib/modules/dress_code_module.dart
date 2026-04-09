import 'package:flutter/material.dart';

class DressCodeModule extends StatelessWidget {
  final Map<String, dynamic> data;

  const DressCodeModule({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final title = data["title"] ?? "Dress Code";
    final style = data["style"] ?? "";
    final description = data["description"] ?? "";

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 🔹 ICONO
          const Icon(Icons.checkroom, size: 32),

          const SizedBox(height: 8),

          // 🔹 TÍTULO
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 12),

          // 🔹 ESTILO (IMPORTANTE)
          if (style.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                style,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

          // 🔹 DESCRIPCIÓN
          if (description.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(description, textAlign: TextAlign.center),
          ],
        ],
      ),
    );
  }
}
