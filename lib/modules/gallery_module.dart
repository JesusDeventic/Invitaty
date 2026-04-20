import 'package:flutter/material.dart';
import 'package:invitaty/generated/l10n.dart';

class GalleryModule extends StatelessWidget {
  final Map<String, dynamic> data;

  const GalleryModule({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final title = data["title"] ?? S.of(context).moduleNameGallery;
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

          // 🖼️ GRID
          if (images.isEmpty)
            Text(
              S.of(context).editGalleryNoImages,
              style: TextStyle(color: Colors.grey),
            )
          else
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: images.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 6,
                mainAxisSpacing: 6,
              ),
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(images[index], fit: BoxFit.cover),
                );
              },
            ),
        ],
      ),
    );
  }
}
