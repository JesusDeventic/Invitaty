import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:invitaty/generated/l10n.dart';

import 'package:invitaty/providers/invitation_provider.dart';

class EditVideoModuleScreen extends StatefulWidget {
  final int index;
  final Map<String, dynamic> section;

  const EditVideoModuleScreen({
    super.key,
    required this.index,
    required this.section,
  });

  @override
  State<EditVideoModuleScreen> createState() => _EditVideoModuleScreenState();
}

class _EditVideoModuleScreenState extends State<EditVideoModuleScreen> {
  late TextEditingController titleController;

  List<Map<String, dynamic>> videos = [];

  @override
  void initState() {
    super.initState();

    final data = widget.section["data"] ?? {};

    titleController = TextEditingController(
      text: data["title"] ?? S.of(context).moduleNameVideo,
    );

    // 🔥 COPIA MUTABLE (evita error unmodifiable map)
    videos = (data["videos"] as List? ?? [])
        .map((v) => Map<String, dynamic>.from(v))
        .toList();
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  // ➕ AÑADIR VIDEO
  void _addVideo() {
    setState(() {
      videos.add({"title": "", "url": ""});
    });
  }

  // ❌ ELIMINAR VIDEO
  void _removeVideo(int index) {
    setState(() {
      videos.removeAt(index);
    });
  }

  // 💾 GUARDAR
  void _save() {
    final provider = context.read<InvitationProvider>();

    final updatedSection = {
      ...widget.section,
      "data": {"title": titleController.text, "videos": videos},
    };

    provider.updateSection(widget.index, updatedSection);
    Navigator.pop(context);
  }

  // ❌ ELIMINAR MÓDULO
  void _deleteModule() async {
    final provider = context.read<InvitationProvider>();

    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(S.of(context).deleteVideo),
        content: Text(S.of(context).deleteModuleConfirmation),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(S.of(context).buttonCancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(S.of(context).messagesDelete),
          ),
        ],
      ),
    );

    if (confirm == true) {
      provider.removeSection(widget.index);
      Navigator.pop(context);
    }
  }

  // 🧠 EXTRAER ID YOUTUBE
  String? _getYoutubeId(String url) {
    if (url.contains("youtu.be/")) {
      return url.split("youtu.be/").last.split("?").first;
    } else if (url.contains("youtube.com/watch?v=")) {
      return url.split("v=").last.split("&").first;
    }
    return null;
  }

  // 🎨 ITEM VIDEO
  Widget _buildVideoItem(int index) {
    final video = videos[index];

    final url = video["url"] ?? "";
    final videoId = _getYoutubeId(url);

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            // 🔹 HEADER
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  S.of(context).moduleNameVideo,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _removeVideo(index),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // 🔹 TÍTULO
            TextFormField(
              initialValue: video["title"],
              decoration: InputDecoration(labelText: S.of(context).editTitle),
              onChanged: (value) {
                video["title"] = value;
              },
            ),

            const SizedBox(height: 8),

            // 🔹 URL
            TextFormField(
              initialValue: video["url"],
              decoration: const InputDecoration(
                labelText: "URL (YouTube / Vimeo)",
              ),
              onChanged: (value) {
                video["url"] = value;
                setState(() {}); // 🔥 refresca preview
              },
            ),

            const SizedBox(height: 12),

            // 🔹 PREVIEW
            if (videoId != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Container(
                    color: Colors.black,
                    child: Image.network(
                      "https://img.youtube.com/vi/$videoId/0.jpg",
                      fit: BoxFit.contain, // 🔥 FIX ZOOM
                    ),
                  ),
                ),
              )
            else if (url.isNotEmpty)
              const Text(
                "Preview no disponible",
                style: TextStyle(color: Colors.grey),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).editVideo),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: _deleteModule,
          ),
          IconButton(icon: const Icon(Icons.save), onPressed: _save),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            // 🔹 TÍTULO
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: S.of(context).editTitle),
            ),

            const SizedBox(height: 16),

            // 🔹 LISTA
            Expanded(
              child: ListView(
                children: [
                  ...List.generate(
                    videos.length,
                    (index) => _buildVideoItem(index),
                  ),

                  const SizedBox(height: 12),

                  ElevatedButton.icon(
                    onPressed: _addVideo,
                    icon: const Icon(Icons.add),
                    label: Text(S.of(context).addVideo),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
