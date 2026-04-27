import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:invitaty/providers/invitation_provider.dart';
import 'package:invitaty/generated/l10n.dart';

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

  /// 🕒 Estado principal (fuente de verdad)
  DateTime selectedDateTime = DateTime.now();

  @override
  void initState() {
    super.initState();

    final data = widget.section["data"] ?? {};

    /// 🔹 INIT TITLE (normalizado)
    titleController = TextEditingController(
      text: (data["title"] ?? S.of(context).moduleNameCountdown).toString(),
    );

    /// 🔹 INIT FECHA DESDE BACKEND (ISO STRING)
    final parsed = DateTime.tryParse(data["eventDateTime"]?.toString() ?? "");
    if (parsed != null) {
      selectedDateTime = parsed;
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  // 💾 GUARDAR (backend-ready)
  void _save() {
    final provider = context.read<InvitationProvider>();

    final updatedSection = {
      ...widget.section,
      "data": {
        "title": titleController.text,

        /// 🔥 CLAVE: ISO STRING → estándar backend
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
        title: Text(S.of(context).deleteCountdown),
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

  // 📅 SELECTOR DE FECHA
  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDateTime,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (picked == null) return;

    /// 🔁 Mantiene la hora actual
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

  // ⏰ SELECTOR DE HORA
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
    /// 🔹 FORMATO VISUAL (UI)
    final dateText =
        "${selectedDateTime.day}/${selectedDateTime.month}/${selectedDateTime.year}";

    final timeText =
        "${selectedDateTime.hour.toString().padLeft(2, '0')}:${selectedDateTime.minute.toString().padLeft(2, '0')}";

    /// 🔹 PREVIEW (misma lógica que módulo)
    final diff = selectedDateTime.difference(DateTime.now());
    final safe = diff.isNegative ? Duration.zero : diff;

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).editCountdown),
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
            /// 🔹 TÍTULO
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: S.of(context).editTitle),
              onChanged: (_) => setState(() {}), // refresca preview
            ),

            const SizedBox(height: 16),

            /// 📅 FECHA
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: Text(S.of(context).dateCountdown),
              subtitle: Text(dateText),
              onTap: _pickDate,
            ),

            /// ⏰ HORA
            ListTile(
              leading: const Icon(Icons.access_time),
              title: Text(S.of(context).timeCountdown),
              subtitle: Text(timeText),
              onTap: _pickTime,
            ),

            const SizedBox(height: 24),

            /// 🔍 PREVIEW
            Text(
              S.of(context).actionPreview,
              style: const TextStyle(fontWeight: FontWeight.bold),
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
                  /// 🔹 TÍTULO PREVIEW
                  Text(
                    titleController.text,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  /// 🔹 CONTADOR PREVIEW
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
