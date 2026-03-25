import 'package:flutter/material.dart';

class TextModule extends StatelessWidget {
  final Map<String, dynamic> data;

  const TextModule({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final title = data["title"] ?? "";
    final body = data["body"] ?? "";

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (title.isNotEmpty)
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          const SizedBox(height: 8),
          if (body.isNotEmpty) Text(body, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
