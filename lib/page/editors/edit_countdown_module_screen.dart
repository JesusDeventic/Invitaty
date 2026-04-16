import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:invitaty/providers/invitation_provider.dart';

class EditCountdownModuleScreen extends StatefulWidget {
  final int index;
  final Map<String, dynamic> section;

  const EditCountdownModuleScreen({
    super.key,
    required this.index,
    required this.section,
  });

  @override
  State<EditCountdownModuleScreen> createState() =>
      _EditCountdownModuleScreenState();
}

class _EditCountdownModuleScreenState extends State<EditCountdownModuleScreen> {
  late TextEditingController titleController;
  DateTime selectedDateTime = DateTime.now();

  @override
  void initState() {
    super.initState();

    final data = widget.section["data"] ?? {};

    titleController = TextEditingController(
      text: data["title"] ?? "Cuenta atrás",
    );

    final parsed = DateTime.tryParse(data["eventDateTime"] ?? "");
    if (parsed != null) {
      selectedDateTime = parsed;
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  // 💾 SAVE
  void _save() {
    final provider = context.read<InvitationProvider>();

    final updatedSection = {
      ...widget.section,
      "data": {
        "title": titleController.text,
        "eventDateTime": selectedDateTime.toIso8601String(),
      },
    };

    provider.updateSection(widget.index, updatedSection);
    Navigator.pop(context);
  }

  // 🗑 DELETE
  Future<void> _delete() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Eliminar cuenta atrás"),
        content: const Text("¿Seguro que quieres eliminar este módulo?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancelar"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Eliminar"),
          ),
        ],
      ),
    );

    if (confirm == true) {
      context.read<InvitationProvider>().removeSection(widget.index);
      Navigator.pop(context);
    }
  }

  // 📅 PICK DATE
  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDateTime,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (picked == null) return;

    setState(() {
      selectedDateTime = DateTime(
        picked.year,
        picked.month,
        picked.day,
        selectedDateTime.hour,
        selectedDateTime.minute,
      );
    });
  }

  // ⏰ PICK TIME
  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(selectedDateTime),
    );

    if (picked == null) return;

    setState(() {
      selectedDateTime = DateTime(
        selectedDateTime.year,
        selectedDateTime.month,
        selectedDateTime.day,
        picked.hour,
        picked.minute,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final dateText =
        "${selectedDateTime.day}/${selectedDateTime.month}/${selectedDateTime.year}";
    final timeText =
        "${selectedDateTime.hour.toString().padLeft(2, '0')}:${selectedDateTime.minute.toString().padLeft(2, '0')}";

    final diff = selectedDateTime.difference(DateTime.now());
    final safe = diff.isNegative ? Duration.zero : diff;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar cuenta atrás"),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: "Título"),
              onChanged: (_) => setState(() {}),
            ),

            const SizedBox(height: 16),

            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: const Text("Fecha"),
              subtitle: Text(dateText),
              onTap: _pickDate,
            ),

            ListTile(
              leading: const Icon(Icons.access_time),
              title: const Text("Hora"),
              subtitle: Text(timeText),
              onTap: _pickTime,
            ),

            const SizedBox(height: 24),

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
                  Text(
                    titleController.text,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "${safe.inDays}d ${safe.inHours % 24}h ${safe.inMinutes % 60}m",
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
