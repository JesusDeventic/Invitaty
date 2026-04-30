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
    /// 🧠 TITLE (backend-safe + fallback)
    final title = (widget.data["title"] as String?)?.trim().isNotEmpty == true
        ? widget.data["title"].toString().trim()
        : S.of(context).moduleNameMusic;

    /// 🔹 URL (actual backend mock)
    final url = widget.data["url"] as String?;

    /// 🔹 FUTURO BACKEND READY
    final fileId = widget.data["fileId"];
    final streamingUrl = widget.data["streamingUrl"];

    /// 🎯 prioridad backend
    final effectiveUrl = streamingUrl ?? url;

    final isPlaying = controller.isPlaying;

    /// 🎨 FONT (NO HARDCODE)
    final font = widget.theme.fontFamily;

    /// 📏 SIZES (CONSISTENTES CON COVER)
    final titleSize = widget.theme.titleFontSize;
    final buttonFontSize = widget.theme.bodyFontSize;

    /// 🎨 COLORS
    final titleColor = widget.theme.primaryColor;
    final textColor = widget.theme.textColor;
    final accentColor = widget.theme.accentColor;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      padding: const EdgeInsets.all(20),

      /// 🎨 fondo estándar (igual que Cover / RSVP)
      decoration: BoxDecoration(
        color: widget.theme.backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: titleColor.withValues(alpha: 0.15)),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// 🎵 ICONO
          Icon(Icons.music_note, size: 40, color: titleColor),

          const SizedBox(height: 8),

          /// 🏷️ TITLE
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: titleSize,
              fontWeight: FontWeight.bold,
              fontFamily: font,
              color: titleColor,
            ),
          ),

          const SizedBox(height: 16),

          /// 🎧 BOTÓN PLAY / PAUSE
          ElevatedButton.icon(
            onPressed: () async {
              try {
                /// 🔹 VALIDACIÓN
                if (effectiveUrl == null || effectiveUrl.isEmpty) {
                  throw Exception("URL inválida");
                }

                /// 🔹 CONTROL PLAYBACK (NO TOCAR)
                if (controller.isPlaying) {
                  await controller.pause();
                } else {
                  /// 🔥 FUTURO BACKEND:
                  /// - fileId → resolución backend
                  /// - streamingUrl → CDN firmado
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

            style: ElevatedButton.styleFrom(backgroundColor: accentColor),

            label: Text(
              isPlaying ? S.of(context).actionPause : S.of(context).actionPlay,
              style: TextStyle(fontFamily: font, fontSize: buttonFontSize),
            ),
          ),
        ],
      ),
    );
  }
}
