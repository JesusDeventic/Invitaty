import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class VideoModule extends StatelessWidget {
  final Map<String, dynamic> data;

  const VideoModule({super.key, required this.data});

  void _openVideo(String url) async {
    final uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final videos = List<Map<String, dynamic>>.from(data["videos"] ?? []);

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: videos.map((video) {
          final title = video["title"] ?? "Vídeo";
          final url = video["url"];

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: const Icon(Icons.play_circle),
              title: Text(title),
              trailing: ElevatedButton(
                onPressed: () => _openVideo(url),
                child: const Text("Ver"),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
