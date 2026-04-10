import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

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
    final items = List<String>.from(data["items"] ?? []);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 🔹 TÍTULO
          const Icon(Icons.card_giftcard, size: 32),

          const SizedBox(height: 8),

          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          // 🔹 MENSAJE
          if (message.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(message, textAlign: TextAlign.center),
          ],

          const SizedBox(height: 16),

          // 🔹 IBAN
          if (iban != null && iban.toString().isNotEmpty)
            _buildCopyRow(context, "IBAN", iban),

          // 🔹 BIZUM
          if (bizum != null && bizum.toString().isNotEmpty)
            _buildCopyRow(context, "Bizum", bizum),

          // 🔹 LINK
          if (link != null && link.toString().isNotEmpty) ...[
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () async {
                final uri = Uri.parse(link);
                await launchUrl(uri);
              },
              icon: const Icon(Icons.open_in_new),
              label: const Text("Ver lista de regalos"),
            ),
          ],

          // 🔹 LISTA MANUAL
          if (items.isNotEmpty) ...[
            const SizedBox(height: 16),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Ideas de regalo",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 8),

            ...items.map(
              (item) => Row(
                children: [
                  const Text("• "),
                  Expanded(child: Text(item)),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildCopyRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),

      child: Row(
        children: [
          Expanded(child: Text("$label: $value")),
          IconButton(
            icon: const Icon(Icons.copy),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: value));

              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text("$label copiado")));
            },
          ),
        ],
      ),
    );
  }
}
