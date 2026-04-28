import 'package:flutter/material.dart';
import 'package:invitaty/generated/l10n.dart';
import 'package:invitaty/music_controller/music_controller.dart';
import 'package:invitaty/themes/invitation_theme.dart';

class MusicModule extends StatefulWidget {
  final Map<String, dynamic> data;

  /// 🎨 Tema global de la invitación
  final InvitationTheme theme;

  const MusicModule({super.key, required this.data, required this.theme});

  @override
  State<MusicModule> createState() => _MusicModuleState();
}

class _MusicModuleState extends State<MusicModule> {
  final MusicController controller = MusicController();

  @override
  Widget build(BuildContext context) {
    /// 🧠 CONTENIDO (backend-safe)
    final title = (widget.data["title"] as String?)?.trim().isNotEmpty == true
        ? widget.data["title"].toString().trim()
        : S.of(context).moduleNameMusic;

    /// 🔹 BACKEND READY:
    /// url → actualmente link externo
    /// futuro → URL firmada o endpoint backend (ej: /media/{id})
    final url = widget.data["url"] as String?;

    /// 🔹 FUTURO BACKEND (no rompe nada actual)
    /// Permite evolucionar a:
    /// - fileId → referencia en backend (almacenamiento interno)
    /// - streamingUrl → generado dinámicamente (CDN / signed URL)
    final fileId = widget.data["fileId"]; // opcional futuro
    final streamingUrl = widget.data["streamingUrl"]; // opcional futuro

    /// 🎯 prioridad backend
    final effectiveUrl = streamingUrl ?? url;

    final isPlaying = controller.isPlaying;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      padding: const EdgeInsets.all(20),

      /// 🎨 THEME BASE
      decoration: BoxDecoration(
        color: widget.theme.backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.music_note, size: 40, color: widget.theme.primaryColor),

          const SizedBox(height: 8),

          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              fontFamily: widget.theme.fontFamily,
              color: widget.theme.primaryColor,
            ),
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
                  /// 🔥 FUTURO BACKEND:
                  /// - fileId → resuelve a streamingUrl en API
                  /// - streamingUrl → CDN optimizado
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

            icon: Icon(
              isPlaying ? Icons.pause : Icons.play_arrow,
              color: Colors.white,
            ),

            style: ElevatedButton.styleFrom(
              backgroundColor: widget.theme.accentColor,
            ),

            label: Text(
              isPlaying ? S.of(context).actionPause : S.of(context).actionPlay,
              style: TextStyle(fontFamily: widget.theme.fontFamily),
            ),
          ),
        ],
      ),
    );
  }
}
