import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:invitaty/providers/invitation_provider.dart';

class EditGiftsModuleScreen extends StatefulWidget {
  final int index;
  final Map<String, dynamic> section;

  const EditGiftsModuleScreen({
    super.key,
    required this.index,
    required this.section,
  });

  @override
  State<EditGiftsModuleScreen> createState() => _EditGiftsModuleScreenState();
}

class _EditGiftsModuleScreenState extends State<EditGiftsModuleScreen> {
  late TextEditingController titleController;
  late TextEditingController messageController;
  late TextEditingController ibanController;
  late TextEditingController bizumController;
  late TextEditingController linkController;

  List<String> items = [];

  @override
  void initState() {
    super.initState();

    final data = widget.section["data"] ?? {};

    titleController = TextEditingController(text: data["title"] ?? "Regalos");

    messageController = TextEditingController(text: data["message"] ?? "");

    ibanController = TextEditingController(text: data["iban"] ?? "");

    bizumController = TextEditingController(text: data["bizum"] ?? "");

    linkController = TextEditingController(text: data["link"] ?? "");

    items = List<String>.from(data["items"] ?? []);
  }

  @override
  void dispose() {
    titleController.dispose();
    messageController.dispose();
    ibanController.dispose();
    bizumController.dispose();
    linkController.dispose();
    super.dispose();
  }

  // ➕ AÑADIR ITEM
  void _addItem() {
    setState(() {
      items.add("");
    });
  }

  // ❌ ELIMINAR ITEM
  void _removeItem(int index) {
    setState(() {
      items.removeAt(index);
    });
  }

  // 💾 GUARDAR
  void _save() {
    final provider = context.read<InvitationProvider>();

    final updatedSection = {
      ...widget.section,
      "data": {
        "title": titleController.text,
        "message": messageController.text,
        "iban": ibanController.text,
        "bizum": bizumController.text,
        "link": linkController.text,
        "items": items.where((e) => e.trim().isNotEmpty).toList(),
      },
    };

    provider.updateSection(widget.index, updatedSection);
    Navigator.pop(context);
  }

  // ❌ ELIMINAR MÓDULO
  void _deleteModule() async {
    final provider = context.read<InvitationProvider>();

    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Eliminar módulo de regalos"),
          content: const Text(
            "¿Estás seguro de que quieres eliminar este módulo? Esta acción no se puede deshacer.",
          ),
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

  // 🔹 ITEM
  Widget _buildItem(int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            const Icon(Icons.card_giftcard),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                controller: TextEditingController(text: items[index]),
                decoration: const InputDecoration(labelText: "Regalo"),
                onChanged: (value) {
                  items[index] = value;
                },
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => _removeItem(index),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar regalos"),
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
        child: ListView(
          children: [
            const SizedBox(height: 8),
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: "Título"),
            ),
            const SizedBox(height: 12),

            TextField(
              controller: messageController,
              decoration: const InputDecoration(labelText: "Mensaje"),
            ),

            _sectionTitle("Opciones de regalo"),

            TextField(
              controller: ibanController,
              decoration: const InputDecoration(labelText: "IBAN"),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: bizumController,
              decoration: const InputDecoration(labelText: "Bizum"),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: linkController,
              decoration: const InputDecoration(labelText: "Link"),
            ),

            _sectionTitle("Ideas de regalo (Lista manual)"),

            ...List.generate(items.length, _buildItem),

            ElevatedButton.icon(
              onPressed: _addItem,
              icon: const Icon(Icons.add),
              label: const Text("Añadir regalo"),
            ),
          ],
        ),
      ),
    );
  }
}
