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
    if (parsed != null) selectedDateTime = parsed;
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

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

  @override
  Widget build(BuildContext context) {
    final dateText =
        "${selectedDateTime.day}/${selectedDateTime.month}/${selectedDateTime.year}";
    final timeText =
        "${selectedDateTime.hour.toString().padLeft(2, '0')}:${selectedDateTime.minute.toString().padLeft(2, '0')}";

    final previewDiff = selectedDateTime.difference(DateTime.now());
    final safe = previewDiff.isNegative ? Duration.zero : previewDiff;

    return Scaffold(
      appBar: AppBar(title: const Text("Editar cuenta atrás")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // 🔥 FIX
          children: [
            TextField(
              controller: titleController,
              textAlign: TextAlign.left, // 🔥 FIX
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
