import 'package:flutter/material.dart';

class GalleryModule extends StatelessWidget {
  final Map<String, dynamic> data;

  const GalleryModule({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final images = List<String>.from(data["images"] ?? []);

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: images.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 columnas
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemBuilder: (context, index) {
          final imageUrl = images[index];

          return ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(imageUrl, fit: BoxFit.cover),
          );
        },
      ),
    );
  }
}
