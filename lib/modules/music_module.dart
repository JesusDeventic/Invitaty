import 'dart:async';

import 'package:flutter/material.dart';
import 'package:invitaty/music_controller/music_controller.dart';

class MusicModule extends StatefulWidget {
  final Map<String, dynamic> data;

  const MusicModule({super.key, required this.data});

  @override
  State<MusicModule> createState() => _MusicModuleState();
}

class _MusicModuleState extends State<MusicModule> {
  final controller = MusicController();

  late final StreamSubscription _sub;

  @override
  void initState() {
    super.initState();

    // 🔥 Listener controlado (evita leaks)
    _sub = controller.player.playerStateStream.listen((state) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.data["title"] ?? "Música";
    final url = widget.data["url"] as String?;

    final isPlaying = controller.isPlaying;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 🎵 ICONO
          const Icon(Icons.music_note, size: 40),

          const SizedBox(height: 8),

          // 🔹 TÍTULO
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 16),

          // 🔹 BOTÓN
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

                setState(() {}); // 🔥 refresco inmediato botón
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
            icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
            label: Text(isPlaying ? "Pausar" : "Reproducir"),
          ),
        ],
      ),
    );
  }
}
