import 'package:flutter/material.dart';
import 'package:invitaty/themes/invitation_theme.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:invitaty/generated/l10n.dart';

class LocationModule extends StatelessWidget {
  final Map<String, dynamic> data;

  /// 🆕 THEME GLOBAL DE LA INVITACIÓN
  final InvitationTheme theme;

  const LocationModule({super.key, required this.data, required this.theme});

  /// 🔧 Abre URL de mapas de forma segura (preparado backend)
  Future<void> _openMap(String url) async {
    final uri = Uri.tryParse(url);

    if (uri == null) return;

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    /// 🔹 NORMALIZACIÓN (backend-safe)
    final name = (data["name"] as String?)?.trim().isNotEmpty == true
        ? data["name"].toString().trim()
        : S.of(context).moduleNameLocation;

    final address = (data["address"] as String?)?.trim() ?? "";

    final mapsUrl = (data["mapsUrl"] as String?)?.trim().isNotEmpty == true
        ? data["mapsUrl"].toString().trim()
        : null;

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),

      /// 🎨 USO DEL THEME
      decoration: BoxDecoration(
        color: theme.backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),

      /// 🔹 UI limpia y consistente
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 🏷️ NOMBRE
          Text(
            name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: theme.primaryColor,
              fontFamily: theme.fontFamily,
            ),
          ),

          const SizedBox(height: 8),

          // 📍 DIRECCIÓN
          if (address.isNotEmpty)
            Text(
              address,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: theme.primaryColor.withValues(alpha: 0.8),
              ),
            ),

          const SizedBox(height: 12),

          // 🔗 BOTÓN MAPS
          if (mapsUrl != null)
            ElevatedButton.icon(
              onPressed: () => _openMap(mapsUrl),
              icon: Icon(Icons.map, color: Colors.white),

              /// 🎨 BOTÓN CON COLOR DEL THEME
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.accentColor,
              ),

              label: Text(
                S.of(context).openMaps,
                style: TextStyle(fontFamily: theme.fontFamily),
              ),
            ),
        ],
      ),
    );
  }
}
