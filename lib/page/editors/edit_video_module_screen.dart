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

  /// 🔥 lista mutable de videos
  List<Map<String, dynamic>> videos = [];
  bool _didInitLocalizedDefaults = false;

  @override
  void initState() {
    super.initState();

    final data = widget.section["data"] ?? {};

    titleController = TextEditingController(
      // ⚠️ No usar S.of(context) en initState (puede crashear).
      text: (data["title"] ?? "").toString(),
    );

    // 🔥 importante: copia profunda mutable
    videos = (data["videos"] as List? ?? [])
        .map((v) => Map<String, dynamic>.from(v))
        .toList();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // ✅ Localizations seguro aquí.
    if (!_didInitLocalizedDefaults) {
      _didInitLocalizedDefaults = true;

      if (titleController.text.trim().isEmpty) {
        titleController.text = S.of(context).moduleNameVideo;
      }
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  /// ➕ añadir video
  void _addVideo() {
    setState(() {
      videos.add({
        "title": "",
        "url": "",
        "type": "youtube", // 🔥 FUTURO: youtube | mp4 | upload
      });
    });
  }

  /// ❌ eliminar video
  void _removeVideo(int index) {
    setState(() {
      videos.removeAt(index);
    });
  }

  /// 💾 guardar
  void _save() {
    final provider = context.read<InvitationProvider>();

    final updatedSection = {
      ...widget.section,
      "data": {"title": titleController.text, "videos": videos},
    };

    provider.updateSection(widget.index, updatedSection);
    Navigator.pop(context);
  }

  /// 🗑 eliminar módulo
  Future<void> _deleteModule() async {
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
          ElevatedButton(
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

  /// 🎬 preview youtube id
  String? _getYoutubeId(String url) {
    if (url.contains("youtu.be/")) {
      return url.split("youtu.be/").last.split("?").first;
    } else if (url.contains("youtube.com/watch?v=")) {
      return url.split("v=").last.split("&").first;
    }
    return null;
  }

  Widget _buildVideoItem(int index) {
    final video = videos[index];

    final url = video["url"] ?? "";
    final title = video["title"] ?? "";

    final videoId = _getYoutubeId(url);

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            // 🧾 header
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

            // 🏷️ title
            TextFormField(
              initialValue: title,
              decoration: InputDecoration(labelText: S.of(context).editTitle),
              onChanged: (value) => video["title"] = value,
            ),

            const SizedBox(height: 8),

            // 🔗 url
            TextFormField(
              initialValue: url,
              decoration: const InputDecoration(labelText: "URL"),
              onChanged: (value) {
                video["url"] = value;

                // 🔥 refresco preview
                setState(() {});
              },
            ),

            const SizedBox(height: 12),

            // 🎥 preview
            if (videoId != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.network(
                    "https://img.youtube.com/vi/$videoId/0.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
              )
            else if (url.isNotEmpty)
              const Text(
                "Preview no disponible (futuro MP4 backend)",
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
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: S.of(context).editTitle),
            ),

            const SizedBox(height: 16),

            Expanded(
              child: ListView(
                children: [
                  ...List.generate(videos.length, _buildVideoItem),

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
