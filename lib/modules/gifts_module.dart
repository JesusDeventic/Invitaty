import 'package:flutter/material.dart';

class GiftsModule extends StatelessWidget {
  final Map<String, dynamic> data;

  const GiftsModule({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final title = data["title"] ?? "Regalos";
    final message = data["message"] ?? "";
    final iban = data["iban"];
    final bizum = data["bizum"];
    final link = data["link"];

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          if (message.isNotEmpty) ...[const SizedBox(height: 8), Text(message)],

          if (iban != null) ...[const SizedBox(height: 8), Text("IBAN: $iban")],

          if (bizum != null) ...[
            const SizedBox(height: 8),
            Text("Bizum: $bizum"),
          ],

          if (link != null) ...[
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {},
              child: const Text("Ver lista de regalos"),
            ),
          ],
        ],
      ),
    );
  }
}
