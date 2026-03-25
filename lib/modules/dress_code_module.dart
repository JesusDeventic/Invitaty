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
          const SizedBox(height: 8),
          Text(
            style,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          if (description.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(description),
          ],
        ],
      ),
    );
  }
}
