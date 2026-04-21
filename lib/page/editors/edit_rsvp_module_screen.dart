import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:invitaty/generated/l10n.dart';
import 'package:invitaty/providers/invitation_provider.dart';

class EditRsvpModuleScreen extends StatefulWidget {
  final int index;
  final Map<String, dynamic> section;

  const EditRsvpModuleScreen({
    super.key,
    required this.index,
    required this.section,
  });

  @override
  State<EditRsvpModuleScreen> createState() => _EditRsvpModuleScreenState();
}

class _EditRsvpModuleScreenState extends State<EditRsvpModuleScreen> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;

  List<Map<String, dynamic>> fields = [];
  bool _didInitLocalizedDefaults = false;

  // ✅ FIX: ahora el catálogo depende de context
  List<Map<String, dynamic>> _getFieldCatalog(BuildContext context) {
    final s = S.of(context);

    return [
      {
        "key": "name",
        "label": s.labelName,
        "type": "text",
        "icon": Icons.person,
      },
      {"key": "email", "label": s.email, "type": "email", "icon": Icons.email},
      {
        "key": "attending",
        "label": s.agreeAttendance,
        "type": "switch",
        "icon": Icons.check_circle,
      },
      {
        "key": "guests",
        "label": s.labelGuests,
        "type": "number",
        "icon": Icons.group,
      },
      {
        "key": "notes",
        "label": s.additionalNotes,
        "type": "textarea",
        "icon": Icons.note,
      },
    ];
  }

  @override
  void initState() {
    super.initState();

    final data = widget.section["data"] ?? {};

    // Don't depend on inherited widgets (like Localizations) in initState.
    titleController = TextEditingController(text: (data["title"] ?? "").toString());

    descriptionController = TextEditingController(
      text: (data["description"] ?? "").toString(),
    );

    final rawFields = data["fields"];
    if (rawFields is List) {
      fields = rawFields
          .whereType<Map>()
          .map((e) => Map<String, dynamic>.from(e))
          .toList();
    } else {
      fields = [];
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_didInitLocalizedDefaults) return;
    _didInitLocalizedDefaults = true;

    // If no title was provided, set a localized default once Localizations is ready.
    if (titleController.text.trim().isEmpty) {
      titleController.text = S.of(context).attendanceConfirmation;
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  // ➕ añadir campo
  void _addField(Map<String, dynamic> field) {
    setState(() {
      fields.add({
        "key": field["key"],
        "type": field["type"],
        "label": field["label"],
        "required": false,
      });
    });
  }

  // ❌ eliminar campo
  void _removeField(int index) {
    setState(() {
      fields.removeAt(index);
    });
  }

  // ✏️ EDITAR CAMPO
  void _editField(int index) {
    final field = fields[index];

    final controller = TextEditingController(text: field["label"]);

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(S.of(context).editField),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(labelText: S.of(context).fieldName),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(S.of(context).buttonCancel),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  fields[index]["label"] = controller.text;
                });
                Navigator.pop(context);
              },
              child: Text(S.of(context).save),
            ),
          ],
        );
      },
    );
  }

  // 💾 guardar
  void _save() {
    final provider = context.read<InvitationProvider>();

    final updatedSection = {
      ...widget.section,
      "data": {
        "title": titleController.text,
        "description": descriptionController.text,
        "fields": fields,
      },
    };

    provider.updateSection(widget.index, updatedSection);
    Navigator.pop(context);
  }

  // 🗑 eliminar módulo
  Future<void> _deleteModule() async {
    final provider = context.read<InvitationProvider>();

    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(S.of(context).deleteRsvp),
          content: Text(S.of(context).deleteModuleConfirmation),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(S.of(context).buttonCancel),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: Text(S.of(context).messagesDelete),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      if (!mounted) return;
      provider.removeSection(widget.index);
      Navigator.pop(context);
    }
  }

  // 🧩 preview campo
  Widget _buildPreviewField(Map<String, dynamic> field) {
    final index = fields.indexOf(field);

    return Card(
      child: ListTile(
        leading: Icon(_getIcon(field["type"] ?? "")),
        title: Text(field["label"] ?? ""),
        subtitle: Text(
          field["required"] == true
              ? S.of(context).fieldRequired
              : S.of(context).labelOptional,
        ),
        onTap: () => _editField(index),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => _editField(index),
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => _removeField(index),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIcon(String type) {
    switch (type) {
      case "text":
        return Icons.text_fields;
      case "email":
        return Icons.email;
      case "number":
        return Icons.onetwothree;
      case "textarea":
        return Icons.notes;
      case "switch":
        return Icons.toggle_on;
      default:
        return Icons.help;
    }
  }

  @override
  Widget build(BuildContext context) {
    final fieldCatalog = _getFieldCatalog(context); // ✅ aquí se usa

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).editRsvp),
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
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: S.of(context).editTitle),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: S.of(context).editDescription,
              ),
              maxLines: 2,
            ),

            const SizedBox(height: 20),

            Text(
              S.of(context).addFieldsRsvp,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Wrap(
              spacing: 8,
              children: fieldCatalog.map((field) {
                return ActionChip(
                  avatar: Icon(field["icon"], size: 18),
                  label: Text(field["label"]),
                  onPressed: () => _addField(field),
                );
              }).toList(),
            ),

            const SizedBox(height: 20),

            Text(
              S.of(context).fieldsAdded,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            ...fields.map(_buildPreviewField),
          ],
        ),
      ),
    );
  }
}
