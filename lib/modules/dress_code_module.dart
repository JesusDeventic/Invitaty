import 'package:flutter/material.dart';
import 'package:invitaty/generated/l10n.dart';
import 'package:invitaty/themes/invitation_theme.dart';

class DressCodeModule extends StatelessWidget {
  final Map<String, dynamic> data;

  const DressCodeModule({
    super.key,
    required this.data,
    required InvitationTheme theme,
  });

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
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 👕 ICONO VISUAL DEL MÓDULO
          const Icon(Icons.checkroom, size: 32),

          const SizedBox(height: 8),

          // 🏷️ TÍTULO DEL MÓDULO
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                style, // 👉 aquí podrías mapear a traducción si quisieras en el futuro
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

          // 📝 DESCRIPCIÓN OPCIONAL
          if (description.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(description, textAlign: TextAlign.center),
          ],
        ],
      ),
    );
  }
}
