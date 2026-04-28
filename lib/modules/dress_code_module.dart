import 'package:flutter/material.dart';
import 'package:invitaty/generated/l10n.dart';
import 'package:invitaty/themes/invitation_theme.dart';

class DressCodeModule extends StatelessWidget {
  final Map<String, dynamic> data;

  /// 🎨 THEME GLOBAL DE LA INVITACIÓN
  /// 👉 Define base visual del módulo
  final InvitationTheme theme;

  const DressCodeModule({super.key, required this.data, required this.theme});

  @override
  Widget build(BuildContext context) {
    // 🧠 NORMALIZACIÓN (evita errores de tipo desde backend)
    final title = (data["title"] ?? S.of(context).moduleNameDressCode)
        .toString();

    final style = (data["style"] ?? "").toString();
    final description = (data["description"] ?? "").toString();

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),

      /// 🎨 fondo consistente con theme global
      decoration: BoxDecoration(
        color: theme.backgroundColor,
        border: Border.all(color: theme.primaryColor.withValues(alpha: 0.2)),
        borderRadius: BorderRadius.circular(12),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 👕 ICONO VISUAL DEL MÓDULO
          Icon(Icons.checkroom, size: 32, color: theme.primaryColor),

          const SizedBox(height: 8),

          // 🏷️ TÍTULO DEL MÓDULO
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: theme.fontFamily,
              color: theme.primaryColor,
            ),
          ),

          const SizedBox(height: 12),

          // 🎯 ESTILO PRINCIPAL (CLAVE IMPORTANTE)
          // 🔥 IMPORTANTE BACKEND:
          // - style es una CLAVE ("formal", "casual"...)
          // - NO es texto traducido
          // - el backend guarda la clave, no el label
          if (style.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),

              decoration: BoxDecoration(
                color: theme.accentColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(20),
              ),

              child: Text(
                style,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: theme.fontFamily,
                  color: theme.primaryColor,
                ),
              ),
            ),

          // 📝 DESCRIPCIÓN OPCIONAL
          if (description.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: theme.fontFamily,
                color: theme.textColor.withValues(alpha: 0.9),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
