import 'package:flutter/material.dart';

class CoverModule extends StatelessWidget {
  final Map<String, dynamic> data;

  const CoverModule({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final title = data["title"] ?? "";
    final subtitle = data["subtitle"] ?? "";
    final imageUrl = data["imageUrl"] ?? "";

    final font = data["font"] ?? "Poppins";
    final titleSize = (data["fontSizeTitle"] ?? 28).toDouble();
    final subtitleSize = (data["fontSizeSubtitle"] ?? 18).toDouble();

    final textColorHex = data["textColor"] ?? "#FFFFFF";
    final textColor = _hexToColor(textColorHex);

    return Container(
      height: 300,
      width: double.infinity,

      decoration: BoxDecoration(
        image: imageUrl.isNotEmpty
            ? DecorationImage(image: NetworkImage(imageUrl), fit: BoxFit.cover)
            : null,

        gradient: imageUrl.isEmpty
            ? const LinearGradient(
                colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
      ),

      child: Container(
        padding: const EdgeInsets.all(20),
        alignment: Alignment.center,

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: titleSize,
                fontWeight: FontWeight.bold,
                fontFamily: font,
                color: textColor,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: subtitleSize,
                fontFamily: font,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🎨 HEX → COLOR
  Color _hexToColor(String hex) {
    hex = hex.replaceAll("#", "");
    if (hex.length == 6) hex = "FF$hex";
    return Color(int.parse(hex, radix: 16));
  }
}
