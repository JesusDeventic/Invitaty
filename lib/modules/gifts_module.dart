import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:invitaty/generated/l10n.dart';

class GiftsModule extends StatelessWidget {
  final Map<String, dynamic> data;

  const GiftsModule({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final title = data["title"] ?? S.of(context).moduleNameGifts;
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

      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.card_giftcard, size: 32),

              const SizedBox(height: 8),

              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              if (message.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text(message, textAlign: TextAlign.center),
              ],

              const SizedBox(height: 16),

              if (iban != null && iban.toString().isNotEmpty)
                _buildCopyBox(context, S.of(context).labelIban, iban),

              if (bizum != null && bizum.toString().isNotEmpty)
                _buildCopyBox(context, S.of(context).labelBizum, bizum),

              if (link != null && link.toString().isNotEmpty) ...[
                const SizedBox(height: 12),
                ElevatedButton.icon(
                  onPressed: () async {
                    final uri = Uri.parse(link);
                    await launchUrl(uri);
                  },
                  icon: const Icon(Icons.open_in_new),
                  label: Text(S.of(context).giftsList),
                ),
              ],

              if (items.isNotEmpty) ...[
                const SizedBox(height: 16),

                Text(
                  S.of(context).editGiftIdeas,
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 8),

                Column(
                  children: items
                      .map(
                        (item) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Text("• $item", textAlign: TextAlign.center),
                        ),
                      )
                      .toList(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCopyBox(BuildContext context, String label, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text("$label: $value", textAlign: TextAlign.center)),
          IconButton(
            icon: const Icon(Icons.copy),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: value));
            },
          ),
        ],
      ),
    );
  }
}
