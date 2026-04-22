import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:invitaty/generated/l10n.dart';
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
  // 🧠 TITULO DEL MÓDULO
  late TextEditingController titleController;

  // 📦 LISTA DE EVENTOS (estructura backend-ready)
  List<Map<String, dynamic>> items = [];

  // 🧩 CONTROLADORES UI (sincronizados con items)
  final List<TextEditingController> timeControllers = [];
  final List<TextEditingController> titleControllers = [];
  final List<TextEditingController> descControllers = [];

  @override
  void initState() {
    super.initState();

    final data = widget.section["data"] ?? {};

    // 🧠 título con fallback internacionalizado
    titleController = TextEditingController(
      text: (data["title"] ?? S.of(context).moduleNameAgenda).toString(),
    );

    // 📦 carga de items desde backend
    final rawItems = List<Map<String, dynamic>>.from(data["items"] ?? []);
    items = List<Map<String, dynamic>>.from(rawItems);

    _syncControllers();
  }

  // 🔄 sincroniza UI controllers con modelo de datos
  void _syncControllers() {
    timeControllers.clear();
    titleControllers.clear();
    descControllers.clear();

    for (final item in items) {
      timeControllers.add(
        TextEditingController(text: (item["time"] ?? "").toString()),
      );
      titleControllers.add(
        TextEditingController(text: (item["title"] ?? "").toString()),
      );
      descControllers.add(
        TextEditingController(text: (item["description"] ?? "").toString()),
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

  // ➕ añadir evento (estructura backend consistente)
  void _addItem() {
    setState(() {
      items.add({"time": "", "title": "", "description": ""});
      _syncControllers();
    });
  }

  // ❌ eliminar evento
  void _removeItem(int index) {
    setState(() {
      items.removeAt(index);
      _syncControllers();
    });
  }

  // 💾 guardar en provider (estructura final backend-ready)
  void _save() {
    final provider = context.read<InvitationProvider>();

    final updatedSection = {
      ...widget.section,
      "data": {"title": titleController.text, "items": items},
    };

    provider.updateSection(widget.index, updatedSection);
    Navigator.pop(context);
  }

  // 🗑 eliminar módulo completo
  Future<void> _deleteModule() async {
    final provider = context.read<InvitationProvider>();

    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(S.of(context).deleteAgenda),
        content: Text(S.of(context).deleteModuleConfirmation),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(S.of(context).buttonCancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
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

  // 🧱 UI de cada evento
  Widget _buildItem(int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(12),

        child: Column(
          children: [
            // 🔝 header del item
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  S.of(context).agendaEventNumber(index + 1),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _removeItem(index),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // ⏰ hora del evento
            TextField(
              controller: timeControllers[index],
              decoration: InputDecoration(labelText: S.of(context).editTime),
              onChanged: (value) => items[index]["time"] = value,
            ),

            const SizedBox(height: 12),

            // 📌 título del evento
            TextField(
              controller: titleControllers[index],
              decoration: InputDecoration(labelText: S.of(context).editTitle),
              onChanged: (value) => items[index]["title"] = value,
            ),

            const SizedBox(height: 12),

            // 📝 descripción del evento
            TextField(
              controller: descControllers[index],
              decoration: InputDecoration(
                labelText: S.of(context).editDescription,
              ),
              maxLines: 2,
              onChanged: (value) => items[index]["description"] = value,
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
        title: Text(S.of(context).editAgenda),
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
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            // 🧠 título del módulo
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: S.of(context).editTitle),
            ),

            const SizedBox(height: 20),

            // 📋 lista editable
            Expanded(
              child: ListView(
                children: [
                  ...List.generate(items.length, _buildItem),

                  const SizedBox(height: 12),

                  ElevatedButton.icon(
                    onPressed: _addItem,
                    icon: const Icon(Icons.add),
                    label: Text(S.of(context).addEventAgenda),
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
