import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:invitaty/providers/invitation_provider.dart';

class EditAgendaModuleScreen extends StatefulWidget {
  final int index;
  final Map<String, dynamic> section;

  const EditAgendaModuleScreen({
    super.key,
    required this.index,
    required this.section,
  });

  @override
  State<EditAgendaModuleScreen> createState() => _EditAgendaModuleScreenState();
}

class _EditAgendaModuleScreenState extends State<EditAgendaModuleScreen> {
  late TextEditingController titleController;

  List<Map<String, dynamic>> items = [];

  final List<TextEditingController> timeControllers = [];
  final List<TextEditingController> titleControllers = [];
  final List<TextEditingController> descControllers = [];

  @override
  void initState() {
    super.initState();

    final data = widget.section["data"] ?? {};

    titleController = TextEditingController(text: data["title"] ?? "Agenda");

    final rawItems = List<Map<String, dynamic>>.from(data["items"] ?? []);
    items = List<Map<String, dynamic>>.from(rawItems);

    _syncControllers();
  }

  void _syncControllers() {
    timeControllers.clear();
    titleControllers.clear();
    descControllers.clear();

    for (final item in items) {
      timeControllers.add(TextEditingController(text: item["time"] ?? ""));
      titleControllers.add(TextEditingController(text: item["title"] ?? ""));
      descControllers.add(
        TextEditingController(text: item["description"] ?? ""),
      );
    }
  }

  @override
  void dispose() {
    titleController.dispose();

    for (final c in timeControllers) c.dispose();
    for (final c in titleControllers) c.dispose();
    for (final c in descControllers) c.dispose();

    super.dispose();
  }

  void _addItem() {
    setState(() {
      items.add({"time": "", "title": "", "description": ""});
      _syncControllers();
    });
  }

  void _removeItem(int index) {
    setState(() {
      items.removeAt(index);
      _syncControllers();
    });
  }

  void _save() {
    final provider = context.read<InvitationProvider>();

    final updatedSection = {
      ...widget.section,
      "data": {"title": titleController.text, "items": items},
    };

    provider.updateSection(widget.index, updatedSection);
    Navigator.pop(context);
  }

  Future<void> _deleteModule() async {
    final provider = context.read<InvitationProvider>();

    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Eliminar agenda"),
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
      ),
    );

    if (confirm == true) {
      provider.removeSection(widget.index);
      Navigator.pop(context);
    }
  }

  Widget _buildItem(int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Evento ${index + 1}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _removeItem(index),
                ),
              ],
            ),

            const SizedBox(height: 12),

            TextField(
              controller: timeControllers[index],
              textAlign: TextAlign.left, // 🔥 FIX
              decoration: const InputDecoration(labelText: "Hora (ej: 18:00)"),
              onChanged: (value) {
                items[index]["time"] = value;
              },
            ),

            const SizedBox(height: 12),

            TextField(
              controller: titleControllers[index],
              textAlign: TextAlign.left, // 🔥 FIX
              decoration: const InputDecoration(labelText: "Título"),
              onChanged: (value) {
                items[index]["title"] = value;
              },
            ),

            const SizedBox(height: 12),

            TextField(
              controller: descControllers[index],
              textAlign: TextAlign.left, // 🔥 FIX
              decoration: const InputDecoration(labelText: "Descripción"),
              maxLines: 2,
              onChanged: (value) {
                items[index]["description"] = value;
              },
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
        title: const Text("Editar agenda"),
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
          crossAxisAlignment: CrossAxisAlignment.start, // 🔥 FIX GLOBAL
          children: [
            TextField(
              controller: titleController,
              textAlign: TextAlign.left, // 🔥 FIX
              decoration: const InputDecoration(labelText: "Título"),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView(
                children: [
                  ...List.generate(items.length, (index) => _buildItem(index)),

                  const SizedBox(height: 12),

                  ElevatedButton.icon(
                    onPressed: _addItem,
                    icon: const Icon(Icons.add),
                    label: const Text("Añadir evento"),
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
