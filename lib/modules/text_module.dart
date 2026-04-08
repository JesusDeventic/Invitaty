import 'package:flutter/material.dart';

class TextModule extends StatelessWidget {
  final Map<String, dynamic> data;

  const TextModule({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final title = data["title"] ?? "";
    final body = data["body"] ?? "";

    final font = data["font"] ?? "Poppins";
    final fontSize = (data["fontSize"] ?? 16).toDouble();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (title.isNotEmpty)
            Text(
              title,
              style: TextStyle(
                fontSize: fontSize + 4,
                fontWeight: FontWeight.bold,
                fontFamily: font,
              ),
            ),
          const SizedBox(height: 8),
          if (body.isNotEmpty)
            Text(
              body,
              style: TextStyle(fontSize: fontSize, fontFamily: font),
            ),
        ],
      ),
    );
  }
}
