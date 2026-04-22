import 'package:flutter/material.dart';

class TextModule extends StatelessWidget {
  final Map<String, dynamic> data;

  const TextModule({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    // 🧠 CONTENIDO PRINCIPAL (si no viene → vacío)
    final title = (data["title"] ?? "").toString();
    final body = (data["body"] ?? "").toString();

    // 🎨 CONFIGURACIÓN DE ESTILO (backend-ready)
    final font = (data["font"] ?? "Poppins").toString();
    final fontSize = (data["fontSize"] ?? 16).toDouble();

    // 🎨 color seguro (string HEX desde backend)
    final color = _parseColor(data["color"]) ?? Colors.black;

    return Padding(
      padding: const EdgeInsets.all(16.0),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 🔹 TÍTULO (opcional)
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

          // 🔹 CUERPO (opcional)
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

  /// 🎨 Convierte valores del backend a Color seguro
  /// Soporta:
  /// - "#RRGGBB"
  /// - "0xFFRRGGBB"
  /// - "RRGGBB"
  Color? _parseColor(dynamic value) {
    if (value == null) return null;

    try {
      String hex = value.toString().trim();

      if (hex.startsWith("#")) {
        hex = hex.substring(1);
      }

      if (hex.length == 6) {
        hex = "FF$hex";
      }

      if (hex.startsWith("0x")) {
        hex = hex.substring(2);
      }

      return Color(int.parse(hex, radix: 16));
    } catch (_) {
      return Colors.black;
    }
  }
}
