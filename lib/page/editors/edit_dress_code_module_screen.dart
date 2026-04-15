import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:invitaty/providers/invitation_provider.dart';

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
  late TextEditingController titleController;
  late TextEditingController descriptionController;

  String selectedStyle = "Formal";

  final List<String> styles = [
    "Formal",
    "Casual",
    "Elegante",
    "Temático",
    "Disfraces",
    "Traje de baño",
    "Libre",
  ];

  @override
  void initState() {
    super.initState();

    final data = widget.section["data"] ?? {};

    titleController = TextEditingController(
      text: data["title"] ?? "Código de vestimenta",
    );

    descriptionController = TextEditingController(
      text: data["description"] ?? "",
    );

    selectedStyle = data["style"] ?? "Formal";
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  // 💾 SAVE
  void _save() {
    final provider = context.read<InvitationProvider>();

    final updatedSection = {
      ...widget.section,
      "data": {
        "title": titleController.text,
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
        title: const Text("Eliminar dress code"),
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

  Widget _buildStyleChip(String style) {
    final isSelected = selectedStyle == style;

    return ChoiceChip(
      label: Text(style),
      selected: isSelected,
      onSelected: (_) => setState(() => selectedStyle = style),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar vestimenta"),
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
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: "Título"),
                onChanged: (_) => setState(() {}),
              ),

              const SizedBox(height: 20),

              const Text(
                "Tipo de vestimenta",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: styles.map(_buildStyleChip).toList(),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: "Descripción (opcional)",
                ),
                maxLines: 3,
                onChanged: (_) => setState(() {}),
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
                        selectedStyle,
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
