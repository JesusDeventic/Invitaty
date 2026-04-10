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

  @override
  void initState() {
    super.initState();

    final data = widget.section["data"] ?? {};

    titleController = TextEditingController(text: data["title"] ?? "Agenda");

    items = List<Map<String, dynamic>>.from(data["items"] ?? []);
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  // ➕ AÑADIR EVENTO
  void _addItem() {
    setState(() {
      items.add({"time": "", "title": "", "description": ""});
    });
  }

  // ❌ ELIMINAR EVENTO
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
      "data": {"title": titleController.text, "items": items},
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
    final item = items[index];

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            // 🔹 HEADER CON DELETE
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

            const SizedBox(height: 8),

            // 🔹 HORA
            TextField(
              controller: TextEditingController(text: item["time"]),
              decoration: const InputDecoration(labelText: "Hora (ej: 18:00)"),
              onChanged: (value) {
                item["time"] = value;
              },
            ),

            const SizedBox(height: 8),

            // 🔹 TÍTULO
            TextField(
              controller: TextEditingController(text: item["title"]),
              decoration: const InputDecoration(labelText: "Título"),
              onChanged: (value) {
                item["title"] = value;
              },
            ),

            const SizedBox(height: 8),

            // 🔹 DESCRIPCIÓN
            TextField(
              controller: TextEditingController(text: item["description"]),
              decoration: const InputDecoration(labelText: "Descripción"),
              maxLines: 2,
              onChanged: (value) {
                item["description"] = value;
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
          IconButton(icon: const Icon(Icons.delete), onPressed: _deleteModule),
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
              decoration: const InputDecoration(labelText: "Título"),
            ),

            const SizedBox(height: 16),

            // 🔹 LISTA
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
