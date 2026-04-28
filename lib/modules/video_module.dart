import 'package:flutter/material.dart';
import 'package:invitaty/themes/invitation_theme.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:invitaty/generated/l10n.dart';

class VideoModule extends StatelessWidget {
  final Map<String, dynamic> data;

  /// 🎨 THEME GLOBAL DE LA INVITACIÓN
  /// 👉 Define estética base del módulo
  final InvitationTheme theme;

  const VideoModule({super.key, required this.data, required this.theme});

  @override
  Widget build(BuildContext context) {
    final title = (data["title"] ?? S.of(context).moduleNameVideo).toString();

    // 🔥 FUTURO BACKEND:
    // ahora: lista de links (YouTube o externos)
    // después: lista de vídeos subidos (mp4 en storage propio)
    final videos = List<Map<String, dynamic>>.from(data["videos"] ?? []);

    if (videos.isEmpty) return const SizedBox();

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      padding: const EdgeInsets.all(20),

      /// 🎨 fondo coherente con el sistema global
      decoration: BoxDecoration(
        color: theme.backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.primaryColor.withValues(alpha: 0.15)),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 🎬 TÍTULO
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              fontFamily: theme.fontFamily,
              color: theme.primaryColor,
            ),
          ),

          const SizedBox(height: 16),

          // 🎥 LISTA DE VIDEOS
          ...videos.map((video) {
            final url = video["url"] as String?;
            final videoTitle = video["title"] ?? S.of(context).moduleNameVideo;

            final videoId = _extractYoutubeId(url);

            // 🔥 SOLO PARA YOUTUBE (preview thumbnail)
            // FUTURO: si es mp4 propio -> usar VideoPlayer (type check)
            final thumbnail = videoId != null
                ? "https://img.youtube.com/vi/$videoId/0.jpg"
                : null;

            return Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // 🏷️ título del video
                  Text(
                    videoTitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: theme.fontFamily,
                      color: theme.textColor,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // 🎬 PREVIEW YOUTUBE
                  if (thumbnail != null)
                    Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 320),

                        child: GestureDetector(
                          onTap: () => _openVideo(context, url),

                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),

                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                AspectRatio(
                                  aspectRatio: 16 / 9,
                                  child: Image.network(
                                    thumbnail,
                                    fit: BoxFit.cover,
                                  ),
                                ),

                                Icon(
                                  Icons.play_circle_fill,
                                  size: 50,
                                  color: theme.accentColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  // 🔥 FUTURO BACKEND:
                  // aquí irá el reproductor REAL de mp4 subido
                  // (video_player / chewie / better_player)
                  else
                    ElevatedButton.icon(
                      onPressed: () => _openVideo(context, url),

                      /// 🎨 botón coherente con el theme
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.accentColor,
                      ),

                      icon: const Icon(Icons.play_arrow),
                      label: Text(
                        S.of(context).actionPlayVideo,
                        style: TextStyle(fontFamily: theme.fontFamily),
                      ),
                    ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  /// 🌐 ABRIR VIDEO EXTERNO
  void _openVideo(BuildContext context, String? url) async {
    if (url == null || url.isEmpty) return;

    final uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(S.of(context).errorVideoPlay)));
    }
  }

  /// 🔍 EXTRAE ID DE YOUTUBE
  /// SOLO PARA PREVIEW (NO PARA FUTURO BACKEND)
  String? _extractYoutubeId(String? url) {
    if (url == null) return null;

    final uri = Uri.tryParse(url);
    if (uri == null) return null;

    if (uri.host.contains("youtube.com")) {
      return uri.queryParameters["v"];
    }

    if (uri.host.contains("youtu.be")) {
      return uri.pathSegments.isNotEmpty ? uri.pathSegments.first : null;
    }

    return null;
  }
}
