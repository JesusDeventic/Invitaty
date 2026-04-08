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

    // 🔥 IMPORTANTE: evitar crash
    if (data["eventDateTime"] != null) {
      selectedDateTime =
          DateTime.tryParse(data["eventDateTime"]) ?? DateTime.now();
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  // 📅 SELECCIONAR FECHA
  Future<void> _pickDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDateTime,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          selectedDateTime.hour,
          selectedDateTime.minute,
        );
      });
    }
  }

  // ⏰ SELECCIONAR HORA
  Future<void> _pickTime() async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(selectedDateTime),
    );

    if (pickedTime != null) {
      setState(() {
        selectedDateTime = DateTime(
          selectedDateTime.year,
          selectedDateTime.month,
          selectedDateTime.day,
          pickedTime.hour,
          pickedTime.minute,
        );
      });
    }
  }

  // 💾 GUARDAR
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

  // ❌ ELIMINAR (con confirmación)
  Future<void> _delete() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Eliminar cuenta atrás"),
          content: const Text("¿Seguro que quieres eliminar este módulo?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text("Cancelar"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text("Eliminar"),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      final provider = context.read<InvitationProvider>();
      provider.removeSection(widget.index);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateText =
        "${selectedDateTime.day}/${selectedDateTime.month}/${selectedDateTime.year}";

    final timeText =
        "${selectedDateTime.hour.toString().padLeft(2, '0')}:${selectedDateTime.minute.toString().padLeft(2, '0')}";

    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar cuenta atrás"),
        actions: [
          IconButton(icon: const Icon(Icons.delete), onPressed: _delete),
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

            const SizedBox(height: 24),

            // 🔹 FECHA
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: const Text("Fecha"),
              subtitle: Text(dateText),
              onTap: _pickDate,
            ),

            // 🔹 HORA
            ListTile(
              leading: const Icon(Icons.access_time),
              title: const Text("Hora"),
              subtitle: Text(timeText),
              onTap: _pickTime,
            ),

            const SizedBox(height: 24),

            // 🔹 PREVIEW SIMPLE
            const Text(
              "Vista previa",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text(
                    titleController.text,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text("$dateText - $timeText"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
