import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:invitaty/providers/invitation_provider.dart';
import 'package:invitaty/generated/l10n.dart';

class EditDressCodeModuleScreen extends StatefulWidget {
  final int index;
  final Map<String, dynamic> section;

  const EditDressCodeModuleScreen({
    super.key,
    required this.index,
    required this.section,
  });

  @override
  State<EditDressCodeModuleScreen> createState() =>
      _EditDressCodeModuleScreenState();
}

class _EditDressCodeModuleScreenState extends State<EditDressCodeModuleScreen> {
  // 🔤 CONTROLADORES
  late TextEditingController titleController;
  late TextEditingController descriptionController;

  // 🎯 CLAVE INTERNA DEL ESTILO (IMPORTANTE PARA BACKEND)
  String selectedStyle = "formal";

  // 📦 CATÁLOGO DE ESTILOS (CLAVES, NO TEXTO)
  final List<String> styles = [
    "formal",
    "casual",
    "elegant",
    "thematic",
    "costume",
    "swimwear",
    "free",
  ];

  @override
  void initState() {
    super.initState();

    final data = widget.section["data"] ?? {};

    // 🧠 NORMALIZACIÓN
    titleController = TextEditingController(
      text: (data["title"] ?? S.of(context).moduleNameDressCode).toString(),
    );

    descriptionController = TextEditingController(
      text: (data["description"] ?? "").toString(),
    );

    // 🔥 CLAVE INTERNA SIEMPRE EN MINÚSCULAS
    selectedStyle = (data["style"] ?? "formal").toString().toLowerCase();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  // 🌍 MAPEO CLAVE → TEXTO TRADUCIDO
  String _getStyleLabel(BuildContext context, String style) {
    final s = S.of(context);

    final map = {
      "formal": s.dressCodeFormal,
      "casual": s.dressCodeCasual,
      "elegant": s.dressCodeElegant,
      "thematic": s.dressCodeThematic,
      "costume": s.dressCodeCostume,
      "swimwear": s.dressCodeSwimwear,
      "free": s.dressCodeFree,
    };

    return map[style] ?? style;
  }

  // 💾 SAVE
  void _save() {
    final provider = context.read<InvitationProvider>();

    // 📦 ESTRUCTURA LISTA PARA BACKEND
    final updatedSection = {
      ...widget.section,
      "data": {
        "title": titleController.text,

        // 🔥 CLAVE INTERNA → backend
        "style": selectedStyle,

        "description": descriptionController.text,
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
        title: Text(S.of(context).deleteDresscode),
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

  // 🧩 CHIP DE SELECCIÓN DE ESTILO
  Widget _buildStyleChip(String style) {
    final isSelected = selectedStyle == style;

    return ChoiceChip(
      label: Text(_getStyleLabel(context, style)), // 🔤 traducido
      selected: isSelected,
      onSelected: (_) => setState(() => selectedStyle = style),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).editDresscode),
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🏷️ TÍTULO
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: S.of(context).editTitle),
                onChanged: (_) => setState(() {}),
              ),

              const SizedBox(height: 20),

              // 👗 TIPO DE VESTIMENTA
              Text(
                S.of(context).editDressType,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: styles.map(_buildStyleChip).toList(),
              ),

              const SizedBox(height: 20),

              // 📝 DESCRIPCIÓN
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: S.of(context).editDescription,
                ),
                maxLines: 3,
                onChanged: (_) => setState(() {}),
              ),

              const SizedBox(height: 24),

              // 👁️ PREVIEW
              Text(
                S.of(context).actionPreview,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 12),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(Icons.checkroom, size: 32),

                    const SizedBox(height: 8),

                    Text(
                      titleController.text,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 12),

                    // 🎯 ESTILO (TRADUCIDO EN UI)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        _getStyleLabel(context, selectedStyle),
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),

                    if (descriptionController.text.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      Text(
                        descriptionController.text,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
