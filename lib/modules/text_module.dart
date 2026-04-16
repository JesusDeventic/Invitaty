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

    final color = _parseColor(data["color"]) ?? Colors.black;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (title.isNotEmpty)
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fontSize + 4,
                fontWeight: FontWeight.bold,
                fontFamily: font,
                color: color,
              ),
            ),

          const SizedBox(height: 8),

          if (body.isNotEmpty)
            Text(
              body,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fontSize,
                fontFamily: font,
                color: color,
              ),
            ),
        ],
      ),
    );
  }

  /// 🔧 Convierte "#RRGGBB" o "0xFFRRGGBB" a Color seguro
  Color? _parseColor(dynamic value) {
    if (value == null) return null;

    try {
      String hex = value.toString().trim();

      // formato #RRGGBB
      if (hex.startsWith("#")) {
        hex = hex.substring(1);
      }

      // si viene solo RRGGBB
      if (hex.length == 6) {
        hex = "FF$hex"; // alpha completo
      }

      // si viene 0xFF...
      if (hex.startsWith("0x")) {
        hex = hex.substring(2);
      }

      return Color(int.parse(hex, radix: 16));
    } catch (_) {
      return Colors.black;
    }
  }
}
