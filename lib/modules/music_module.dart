import 'package:flutter/material.dart';
import 'package:invitaty/generated/l10n.dart';

import 'package:invitaty/music_controller/music_controller.dart';
import 'package:invitaty/themes/invitation_theme.dart';

class MusicModule extends StatefulWidget {
  final Map<String, dynamic> data;

  const MusicModule({
    super.key,
    required this.data,
    required InvitationTheme theme,
  });

  @override
  State<MusicModule> createState() => _MusicModuleState();
}

class _MusicModuleState extends State<MusicModule> {
  final MusicController controller = MusicController();

  @override
  Widget build(BuildContext context) {
    /// 🔹 BACKEND READY:
    /// url → actualmente link externo
    /// futuro → URL firmada o endpoint backend (ej: /media/{id})
    final title = widget.data["title"] ?? S.of(context).moduleNameMusic;
    final url = widget.data["url"] as String?;

    /// 🔹 FUTURO BACKEND (no rompe nada actual)
    /// Permite evolucionar a:
    /// - fileId → referencia en backend
    /// - streamingUrl → generado dinámicamente
    final fileId = widget.data["fileId"]; // opcional futuro
    final streamingUrl = widget.data["streamingUrl"]; // opcional futuro

    final effectiveUrl = streamingUrl ?? url;

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
          const Icon(Icons.music_note, size: 40),

          const SizedBox(height: 8),

          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 16),

          ElevatedButton.icon(
            onPressed: () async {
              try {
                /// 🔹 VALIDACIÓN ROBUSTA
                if (effectiveUrl == null || effectiveUrl.isEmpty) {
                  throw Exception("URL inválida");
                }

                /// 🔹 CONTROL PLAY / PAUSE
                if (controller.isPlaying) {
                  await controller.pause();
                } else {
                  /// 🔥 IMPORTANTE:
                  /// En backend aquí se usará:
                  /// - URL normalizada (mp3 convertido)
                  /// - streaming compatible multiplataforma
                  await controller.play(effectiveUrl);
                }

                if (mounted) {
                  setState(() {});
                }
              } catch (e) {
                debugPrint("Error audio: $e");

                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(S.of(context).musicErrorPlay)),
                  );
                }
              }
            },
            icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
            label: Text(
              isPlaying ? S.of(context).actionPause : S.of(context).actionPlay,
            ),
          ),
        ],
      ),
    );
  }
}
