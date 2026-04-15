import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class VideoModule extends StatelessWidget {
  final Map<String, dynamic> data;

  const VideoModule({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final title = data["title"] ?? "Vídeos";
    final videos = List<Map<String, dynamic>>.from(data["videos"] ?? []);

    if (videos.isEmpty) return const SizedBox();

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
          // 🔹 TÍTULO
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 16),

          ...videos.map((video) {
            final url = video["url"] as String?;
            final videoTitle = video["title"] ?? "Vídeo";

            final videoId = _extractYoutubeId(url);
            final thumbnail = videoId != null
                ? "https://img.youtube.com/vi/$videoId/0.jpg"
                : null;

            return Container(
              margin: const EdgeInsets.only(bottom: 20),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // 🔹 TÍTULO DEL VIDEO
                  Text(
                    videoTitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 8),

                  // 🔹 PREVIEW
                  if (thumbnail != null)
                    Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: 300, // 🔥 tamaño controlado
                        ),
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

                                const Icon(
                                  Icons.play_circle_fill,
                                  size: 50,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  else
                    ElevatedButton.icon(
                      onPressed: () => _openVideo(context, url),
                      icon: const Icon(Icons.play_arrow),
                      label: const Text("Ver vídeo"),
                    ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  void _openVideo(BuildContext context, String? url) async {
    if (url == null || url.isEmpty) return;

    final uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No se pudo abrir el vídeo")),
      );
    }
  }

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
