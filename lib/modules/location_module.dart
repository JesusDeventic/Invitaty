import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LocationModule extends StatelessWidget {
  final Map<String, dynamic> data;

  const LocationModule({super.key, required this.data});

  void _openMap(String url) async {
    final uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final name = data["name"] ?? "Ubicación";
    final address = data["address"] ?? "";
    final mapsUrl = data["mapsUrl"];

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          Text(
            name,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(address),
          const SizedBox(height: 12),
          if (mapsUrl != null)
            ElevatedButton(
              onPressed: () => _openMap(mapsUrl),
              child: const Text("Ver en Google Maps"),
            ),
        ],
      ),
    );
  }
}
