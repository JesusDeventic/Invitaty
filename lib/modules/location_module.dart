import 'package:flutter/material.dart';
import 'package:invitaty/themes/invitation_theme.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:invitaty/generated/l10n.dart';

class LocationModule extends StatelessWidget {
  final Map<String, dynamic> data;

  /// 🆕 THEME GLOBAL DE LA INVITACIÓN
  final InvitationTheme theme;

  const LocationModule({super.key, required this.data, required this.theme});

  /// 🔧 PARSER SEGURO DE FECHA (backend-ready)
  DateTime? _parseDate(dynamic value) {
    if (value == null) return null;

    try {
      return DateTime.tryParse(value.toString());
    } catch (_) {
      return null;
    }
  }

  /// 🔧 Abre URL de mapas de forma segura
  Future<void> _openMap(String url) async {
    final uri = Uri.tryParse(url);

    if (uri == null) return;

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    // 🧠 NORMALIZACIÓN BACKEND-SAFE
    final name = (data["name"] as String?)?.trim().isNotEmpty == true
        ? data["name"].toString().trim()
        : S.of(context).moduleNameLocation;

    final address = (data["address"] as String?)?.trim() ?? "";

    final mapsUrl = (data["mapsUrl"] as String?)?.trim().isNotEmpty == true
        ? data["mapsUrl"].toString().trim()
        : null;

    /// 🆕 FECHA DEL EVENTO
    final eventDateTime = _parseDate(data["eventDateTime"]);

    // 🎨 OVERRIDES (MISMO PATRÓN QUE COVER)
    final font = (data["font"] as String?)?.isNotEmpty == true
        ? data["font"]
        : theme.fontFamily;

    final titleSize =
        (data["fontSizeTitle"] as num?)?.toDouble() ?? theme.titleFontSize;

    final bodySize =
        (data["fontSizeBody"] as num?)?.toDouble() ?? theme.bodyFontSize;

    final textColor = _hexToColor(data["textColor"]) ?? theme.textColor;

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),

      /// 🎨 THEME BASE (igual que Cover / otros módulos)
      decoration: BoxDecoration(
        color: theme.backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),

      /// 🔹 UI limpia y consistente
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 🏷️ NOMBRE DEL LUGAR
          Text(
            name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: titleSize,
              fontWeight: FontWeight.bold,
              fontFamily: font,
              color: theme.primaryColor,
            ),
          ),

          const SizedBox(height: 8),

          // 📍 DIRECCIÓN
          if (address.isNotEmpty)
            Text(
              address,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: bodySize,
                fontFamily: font,
                color: textColor.withValues(alpha: 0.8),
              ),
            ),

          const SizedBox(height: 12),

          // 📅 FECHA DEL EVENTO
          if (eventDateTime != null)
            Text(
              /// 🔹 Formato simple (luego puedes mejorar con intl DateFormat)
              "${eventDateTime.day}/${eventDateTime.month}/${eventDateTime.year} "
              "${eventDateTime.hour.toString().padLeft(2, '0')}:${eventDateTime.minute.toString().padLeft(2, '0')}",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: bodySize,
                fontWeight: FontWeight.w500,
                fontFamily: font,
                color: textColor,
              ),
            ),

          if (eventDateTime != null) const SizedBox(height: 12),

          // 🔗 BOTÓN MAPS
          if (mapsUrl != null)
            ElevatedButton.icon(
              onPressed: () => _openMap(mapsUrl),
              icon: const Icon(Icons.map, color: Colors.white),

              /// 🎨 BOTÓN CON COLOR DEL THEME
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.accentColor,
              ),

              label: Text(
                S.of(context).openMaps,
                style: TextStyle(fontFamily: font, fontSize: bodySize),
              ),
            ),
        ],
      ),
    );
  }

  /// 🎨 HEX → COLOR (CONSISTENTE CON COVER)
  Color? _hexToColor(dynamic value) {
    if (value == null) return null;

    try {
      String hex = value.toString().trim();

      if (hex.startsWith("#")) hex = hex.substring(1);
      if (hex.startsWith("0x")) hex = hex.substring(2);
      if (hex.length == 6) hex = "FF$hex";

      return Color(int.parse(hex, radix: 16));
    } catch (_) {
      return null;
    }
  }
}
