import 'package:flutter/material.dart';
import 'package:invitaty/themes/invitation_theme.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:invitaty/generated/l10n.dart';

class VideoModule extends StatelessWidget {
  final Map<String, dynamic> data;

  /// 🎨 THEME GLOBAL DE LA INVITACIÓN
  final InvitationTheme theme;

  const VideoModule({super.key, required this.data, required this.theme});

  @override
  Widget build(BuildContext context) {
    /// 🧠 TÍTULO (backend-safe)
    final title = (data["title"] ?? S.of(context).moduleNameVideo).toString();

    /// 🎥 VIDEOS (backend-safe)
    final videos = List<Map<String, dynamic>>.from(data["videos"] ?? []);

    if (videos.isEmpty) return const SizedBox();

    /// 🔤 FONT (data > theme)
    final font = (data["font"] as String?)?.isNotEmpty == true
        ? data["font"]
        : theme.fontFamily;

    /// 🎨 COLORS (data > theme)
    final titleColor = _hexToColor(data["titleColor"]) ?? theme.primaryColor;

    final textColor = _hexToColor(data["textColor"]) ?? theme.textColor;

    final accentColor = _hexToColor(data["accentColor"]) ?? theme.accentColor;

    /// 📏 SIZES
    final titleSize =
        (data["titleFontSize"] as num?)?.toDouble() ?? theme.titleFontSize;

    final bodySize =
        (data["bodyFontSize"] as num?)?.toDouble() ?? theme.bodyFontSize;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      padding: const EdgeInsets.all(20),

      /// 🎨 fondo consistente global
      decoration: BoxDecoration(
        color: theme.backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: titleColor.withValues(alpha: 0.15)),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// 🎬 TÍTULO
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

          /// 🎥 LISTA DE VIDEOS
          ...videos.map((video) {
            final url = video["url"] as String?;
            final videoTitle = (video["title"] ?? title).toString();

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
                  /// 🏷️ TÍTULO VIDEO
                  Text(
                    videoTitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: bodySize,
                      fontWeight: FontWeight.bold,
                      fontFamily: font,
                      color: textColor,
                    ),
                  ),

                  const SizedBox(height: 8),

                  /// 🎬 PREVIEW YOUTUBE
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
                                  color: accentColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  /// 🔥 fallback (no youtube preview)
                  else
                    ElevatedButton.icon(
                      onPressed: () => _openVideo(context, url),

                      style: ElevatedButton.styleFrom(
                        backgroundColor: accentColor,
                      ),

                      icon: const Icon(Icons.play_arrow),
                      label: Text(
                        S.of(context).actionPlayVideo,
                        style: TextStyle(fontFamily: font),
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

  /// 🎨 HEX → COLOR (backend-safe estándar del proyecto)
  Color? _hexToColor(dynamic value) {
    if (value == null) return null;

    try {
      String hex = value.toString().trim();

      if (hex.startsWith("#")) hex = hex.substring(1);
      if (hex.startsWith("0x")) hex = hex.substring(2);
      if (hex.length == 6) hex = "FF$hex";

      return Color(int.parse(hex, radix: 16));
    } catch (_) {
      return null;
    }
  }
}
