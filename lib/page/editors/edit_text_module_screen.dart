import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:invitaty/providers/invitation_provider.dart';

class EditTextModuleScreen extends StatefulWidget {
  final int index;
  final Map<String, dynamic> section;

  const EditTextModuleScreen({
    super.key,
    required this.index,
    required this.section,
  });

  @override
  State<EditTextModuleScreen> createState() => _EditTextModuleScreenState();
}

class _EditTextModuleScreenState extends State<EditTextModuleScreen> {
  late TextEditingController titleController;
  late TextEditingController bodyController;

  @override
  void initState() {
    super.initState();

    final data = widget.section["data"];

    titleController = TextEditingController(text: data["title"]);
    bodyController = TextEditingController(text: data["body"]);
  }

  @override
  void dispose() {
    titleController.dispose();
    bodyController.dispose();
    super.dispose();
  }

  void _save() {
    final provider = context.read<InvitationProvider>();

    final updatedSection = {
      ...widget.section,
      "data": {"title": titleController.text, "body": bodyController.text},
    };

    provider.updateSection(widget.index, updatedSection);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar texto"),
        actions: [IconButton(icon: const Icon(Icons.save), onPressed: _save)],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: "Título"),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: bodyController,
              decoration: const InputDecoration(labelText: "Contenido"),
              maxLines: 4,
            ),
          ],
        ),
      ),
    );
  }
}
