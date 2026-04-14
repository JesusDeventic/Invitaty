import 'package:flutter/material.dart';

class GalleryModule extends StatelessWidget {
  final Map<String, dynamic> data;

  const GalleryModule({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final title = data["title"] ?? "Galería";
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
            const Text("No hay imágenes", style: TextStyle(color: Colors.grey))
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
