import 'package:flutter/material.dart';
import 'package:invitaty/generated/l10n.dart';
import 'package:invitaty/themes/invitation_theme.dart';

/// 🖼️ MÓDULO DE GALERÍA
///
/// 🔹 Muestra imágenes en grid
/// 🔹 Actualmente usa URLs (picsum fake)
/// 🔹 FUTURO:
///    - imágenes subidas por usuario
///    - URLs desde backend (S3 / Firebase / CDN)
class GalleryModule extends StatelessWidget {
  final Map<String, dynamic> data;

  const GalleryModule({
    super.key,
    required this.data,
    required InvitationTheme theme,
  });

  @override
  Widget build(BuildContext context) {
    /// 🏷️ Título configurable
    final title = data["title"] ?? S.of(context).moduleNameGallery;

    /// 🖼️ Lista de imágenes (siempre lista segura)
    final images = List<String>.from(data["images"] ?? []);

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 8),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 🏷️ TÍTULO
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 16),

          // 🖼️ GRID / EMPTY STATE
          if (images.isEmpty)
            Text(
              S.of(context).editGalleryNoImages,
              style: TextStyle(color: Colors.grey),
            )
          else
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),

              /// 🔢 Número de imágenes
              itemCount: images.length,

              /// 📐 Layout del grid
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 6,
                mainAxisSpacing: 6,
              ),

              /// 🖼️ Render imagen
              itemBuilder: (context, index) {
                final imageUrl = images[index];

                return ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,

                    /// ⚠️ Mejora UX (fallback básico)
                    errorBuilder: (_, __, ___) => Container(
                      color: Colors.grey.shade300,
                      child: const Icon(Icons.broken_image),
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
