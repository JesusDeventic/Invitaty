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
  /// 📝 Controllers principales del formulario del editor (título y descripción del módulo RSVP)
  late TextEditingController titleController;
  late TextEditingController descriptionController;

  /// 📦 Lista dinámica de campos del formulario (estructura editable del RSVP)
  List<Map<String, dynamic>> fields = [];

  /// 🌍 Flag para inicializar valores por defecto solo una vez tras cargar localización
  bool _didInitLocalizedDefaults = false;

  // ============================
  // 👁️ PREVIEW SYSTEM (NUEVO)
  // ============================

  /// 🧪 Form key para validar el formulario de preview (simulación real del usuario final)
  final _previewFormKey = GlobalKey<FormState>();

  /// 🧠 Controllers del preview (solo para simulación visual del formulario final)
  final Map<String, TextEditingController> previewControllers = {};

  /// 🔁 Valores reactivos (especialmente para switches)
  final Map<String, dynamic> previewValues = {};

  /// 📋 Catálogo de campos disponibles para añadir al RSVP
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

    /// 📥 Cargamos datos existentes del módulo desde el provider
    final data = widget.section["data"] ?? {};

    /// 📝 Inicialización de título del módulo
    titleController = TextEditingController(
      text: (data["title"] ?? "").toString(),
    );

    /// 📝 Inicialización de descripción del módulo
    descriptionController = TextEditingController(
      text: (data["description"] ?? "").toString(),
    );

    /// 📦 Carga de campos previamente configurados (si existen)
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

    /// 🌍 Evita re-inicialización múltiple tras cambios de idioma
    if (_didInitLocalizedDefaults) return;
    _didInitLocalizedDefaults = true;

    /// 🧠 Valor por defecto del título si no existe
    if (titleController.text.trim().isEmpty) {
      titleController.text = S.of(context).attendanceConfirmation;
    }
  }

  @override
  void dispose() {
    /// 🧹 Liberación de memoria de controllers principales
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  // ============================
  // 👁️ PREVIEW LOGIC
  // ============================

  /// 🔄 Inicializa controllers del preview según los campos actuales del formulario
  /// (esto simula cómo se comportará el formulario en la vista final del usuario)
  void _initPreviewControllers() {
    previewControllers.clear();
    previewValues.clear();

    for (final field in fields) {
      final key = field["key"] ?? "";

      if (field["type"] == "switch") {
        previewValues[key] = false;
      } else {
        previewControllers[key] = TextEditingController();
      }
    }
  }

  // ============================
  // ➕ CRUD CAMPOS
  // ============================

  /// ➕ Añadir nuevo campo al formulario RSVP
  void _addField(Map<String, dynamic> field) {
    setState(() {
      fields.add({
        "key": field["key"],
        "type": field["type"],
        "label": field["label"],
        "required": false,
        "placeholder": "",
      });
    });
  }

  /// ❌ Eliminar campo del formulario
  void _removeField(int index) {
    setState(() {
      fields.removeAt(index);
    });
  }

  /// ✏️ Editar configuración de un campo (label, placeholder, required)
  void _editField(int index) {
    final field = fields[index];

    final labelController = TextEditingController(text: field["label"] ?? "");
    final placeholderController = TextEditingController(
      text: field["placeholder"] ?? "",
    );

    bool isRequired = field["required"] ?? false;

    showDialog(
      context: context,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return AlertDialog(
              title: Text(S.of(context).editField),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// 🏷️ Nombre del campo
                    TextField(
                      controller: labelController,
                      decoration: InputDecoration(
                        labelText: S.of(context).fieldName,
                      ),
                    ),
                    const SizedBox(height: 12),

                    /// 📝 Placeholder del campo
                    TextField(
                      controller: placeholderController,
                      decoration: InputDecoration(
                        labelText: S.of(context).placeholderText,
                      ),
                    ),
                    const SizedBox(height: 12),

                    /// 🔒 Campo obligatorio
                    SwitchListTile(
                      value: isRequired,
                      onChanged: (value) {
                        setModalState(() {
                          isRequired = value;
                        });
                      },
                      title: Text(S.of(context).fieldMandatory),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(S.of(context).buttonCancel),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      fields[index]["label"] = labelController.text;
                      fields[index]["placeholder"] = placeholderController.text;
                      fields[index]["required"] = isRequired;
                    });

                    Navigator.pop(context);
                  },
                  child: Text(S.of(context).labelSave),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // ============================
  // 💾 SAVE + DELETE
  // ============================

  /// 💾 Guardar cambios en provider (persistencia del módulo RSVP)
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

  /// 🗑️ Eliminar módulo completo RSVP
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

  // ============================
  // 👁️ PREVIEW FIELD BUILDER
  // ============================

  /// 🧩 Renderiza cada campo en modo preview (simulación del formulario final)
  Widget _buildPreviewField(Map<String, dynamic> field) {
    final type = field["type"];
    final key = field["key"] ?? "";
    final label = field["label"] ?? "";
    final placeholder = field["placeholder"] ?? "";
    final required = field["required"] ?? false;

    switch (type) {
      case "text":
      case "email":
      case "number":
        return TextFormField(
          controller: previewControllers[key],
          decoration: InputDecoration(labelText: label, hintText: placeholder),
          keyboardType: type == "email"
              ? TextInputType.emailAddress
              : type == "number"
              ? TextInputType.number
              : TextInputType.text,
          validator: (value) {
            if (required && (value == null || value.trim().isEmpty)) {
              return "Campo obligatorio";
            }
            if (type == "email" &&
                value != null &&
                value.isNotEmpty &&
                !value.contains("@")) {
              return "Email inválido";
            }
            return null;
          },
        );

      case "textarea":
        return TextFormField(
          controller: previewControllers[key],
          maxLines: 3,
          decoration: InputDecoration(labelText: label, hintText: placeholder),
          validator: (value) {
            if (required && (value == null || value.trim().isEmpty)) {
              return "Campo obligatorio";
            }
            return null;
          },
        );

      case "switch":
        return SwitchListTile(
          title: Text(label),
          value: previewValues[key] ?? false,
          onChanged: (value) {
            setState(() {
              previewValues[key] = value;
            });
          },
        );

      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    final fieldCatalog = _getFieldCatalog(context);

    /// 🔄 Re-inicializa preview cada build (temporalmente válido para prototipo)
    _initPreviewControllers();

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
            /// 📝 TÍTULO DEL MÓDULO
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: S.of(context).editTitle),
            ),

            const SizedBox(height: 12),

            /// 📝 DESCRIPCIÓN DEL MÓDULO
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: S.of(context).editDescription,
              ),
              maxLines: 2,
            ),

            const SizedBox(height: 20),

            /// ➕ SECCIÓN: añadir campos al formulario
            Text(
              S.of(context).addFieldsRsvp,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            /// 🧩 catálogo de campos disponibles
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

            /// 📦 campos ya añadidos
            Text(
              S.of(context).fieldsAdded,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            ...fields.map((field) {
              final index = fields.indexOf(field);

              return Card(
                child: ListTile(
                  leading: Icon(_getIcon(field["type"] ?? "")),
                  title: Text(field["label"] ?? ""),
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
            }),

            const SizedBox(height: 20),

            /// 👁️ PREVIEW FINAL DEL FORMULARIO
            Text(
              "Preview",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Form(
              key: _previewFormKey,
              child: Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      /// 🧠 preview título dinámico
                      Text(
                        titleController.text,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      /// 🧠 preview descripción dinámica
                      if (descriptionController.text.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Text(
                          descriptionController.text,
                          textAlign: TextAlign.center,
                        ),
                      ],

                      const SizedBox(height: 16),

                      /// 🧩 preview campos dinámicos
                      ...fields.map(
                        (f) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: _buildPreviewField(f),
                        ),
                      ),

                      const SizedBox(height: 10),

                      /// 📤 botón simulación envío
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (!_previewFormKey.currentState!.validate())
                              return;

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Formulario válido"),
                              ),
                            );
                          },
                          child: const Text("Enviar"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 🎯 helper iconos por tipo de campo
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
}
