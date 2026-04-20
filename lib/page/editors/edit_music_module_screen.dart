import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:invitaty/providers/invitation_provider.dart';
import 'package:invitaty/generated/l10n.dart';

class EditMusicModuleScreen extends StatefulWidget {
  final int index;
  final Map<String, dynamic> section;

  const EditMusicModuleScreen({
    super.key,
    required this.index,
    required this.section,
  });

  @override
  State<EditMusicModuleScreen> createState() => _EditMusicModuleScreenState();
}

class _EditMusicModuleScreenState extends State<EditMusicModuleScreen> {
  late TextEditingController titleController;
  late TextEditingController urlController;

  bool isPlaying = false;

  @override
  void initState() {
    super.initState();

    final data = widget.section["data"] ?? {};

    titleController = TextEditingController(text: data["title"] ?? "");
    urlController = TextEditingController(text: data["url"] ?? "");
  }

  @override
  void dispose() {
    titleController.dispose();
    urlController.dispose();
    super.dispose();
  }

  void _save() {
    final provider = context.read<InvitationProvider>();

    final updatedSection = {
      ...widget.section,
      "data": {"title": titleController.text, "url": urlController.text},
    };

    provider.updateSection(widget.index, updatedSection);
    Navigator.pop(context);
  }

  Future<void> _delete() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(S.of(context).deleteMusic),
        content: Text(S.of(context).deleteModuleConfirmation),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(S.of(context).buttonCancel),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.pop(context, true),
            child: Text(S.of(context).messagesDelete),
          ),
        ],
      ),
    );

    if (confirm == true) {
      context.read<InvitationProvider>().removeSection(widget.index);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final url = urlController.text;

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).editMusic),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: _delete,
          ),
          IconButton(icon: const Icon(Icons.save), onPressed: _save),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // 🔥 FIX
          children: [
            TextField(
              controller: titleController,
              textAlign: TextAlign.left,
              decoration: InputDecoration(labelText: S.of(context).editTitle),
              onChanged: (_) => setState(() {}),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: urlController,
              textAlign: TextAlign.left,
              decoration: const InputDecoration(labelText: "URL"),
              onChanged: (_) => setState(() {}),
            ),

            const SizedBox(height: 24),

            Text(
              S.of(context).actionPreview,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  const Icon(Icons.music_note, size: 40),

                  const SizedBox(height: 8),

                  Text(
                    titleController.text.isEmpty
                        ? S.of(context).editTitle
                        : titleController.text,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  ElevatedButton.icon(
                    onPressed: url.isEmpty ? null : () {},
                    icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                    label: Text(
                      isPlaying
                          ? S.of(context).actionPause
                          : S.of(context).actionPlay,
                    ),
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
