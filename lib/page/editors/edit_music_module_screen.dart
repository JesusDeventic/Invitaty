import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:invitaty/providers/invitation_provider.dart';

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

  // 💾 GUARDAR
  void _save() {
    final provider = context.read<InvitationProvider>();

    final updatedSection = {
      ...widget.section,
      "data": {"title": titleController.text, "url": urlController.text},
    };

    provider.updateSection(widget.index, updatedSection);
    Navigator.pop(context);
  }

  // ❌ ELIMINAR
  void _delete() async {
    final provider = context.read<InvitationProvider>();

    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Eliminar música"),
          content: const Text("¿Seguro que quieres eliminar este módulo?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text("Eliminar"),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      provider.removeSection(widget.index);
      Navigator.pop(context);
    }
  }

  // 🔗 VALIDACIÓN SIMPLE
  bool _isValidUrl(String url) {
    final uri = Uri.tryParse(url);
    return uri != null && uri.hasAbsolutePath;
  }

  @override
  Widget build(BuildContext context) {
    final url = urlController.text;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar música"),
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

        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔹 TÍTULO
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: "Título"),
                onChanged: (_) => setState(() {}),
              ),

              const SizedBox(height: 16),

              // 🔹 URL
              TextField(
                controller: urlController,
                decoration: const InputDecoration(
                  labelText: "URL de la música",
                  hintText: "https://...",
                ),
                onChanged: (_) => setState(() {}),
              ),

              const SizedBox(height: 8),

              if (url.isNotEmpty && !_isValidUrl(url))
                const Text("URL inválida", style: TextStyle(color: Colors.red)),

              const SizedBox(height: 24),

              // 🔹 PREVIEW
              const Text(
                "Vista previa",
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
                          ? "Título de música"
                          : titleController.text,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 12),

                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.play_arrow),
                      label: const Text("Reproducir"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
