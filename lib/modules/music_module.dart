import 'package:flutter/material.dart';
import 'package:invitaty/music_controller/music_controller.dart';

class MusicModule extends StatelessWidget {
  final Map<String, dynamic> data;

  const MusicModule({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final title = data["title"] ?? "Música";
    final url = data["url"] as String?;

    final controller = MusicController();

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge, // 👈 usa theme
          ),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: () async {
              try {
                if (url == null || url.isEmpty) {
                  throw Exception("URL inválida");
                }

                if (controller.isPlaying) {
                  await controller.pause();
                } else {
                  await controller.play(url);
                }
              } catch (e) {
                debugPrint("Error audio: $e");

                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("No se pudo reproducir la música"),
                    ),
                  );
                }
              }
            },
            icon: Icon(controller.isPlaying ? Icons.pause : Icons.play_arrow),
            label: Text(controller.isPlaying ? "Pausar" : "Reproducir"),
          ),
        ],
      ),
    );
  }
}
