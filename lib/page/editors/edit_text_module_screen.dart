import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:invitaty/providers/invitation_provider.dart';

class EditTextModuleScreen extends StatefulWidget {
  final int index;
  final Map<String, dynamic> section;

  const EditTextModuleScreen({
    super.key,
    required this.index,
    required this.section,
  });

  @override
  State<EditTextModuleScreen> createState() => _EditTextModuleScreenState();
}

class _EditTextModuleScreenState extends State<EditTextModuleScreen> {
  late TextEditingController titleController;
  late TextEditingController bodyController;

  String selectedFont = "Poppins";
  double fontSize = 16;

  final List<String> availableFonts = [
    "Poppins",
    "Playfair",
    "Fredoka",
    "GreatVibes",
    "Creepster",
    "Disney",
  ];

  @override
  void initState() {
    super.initState();

    final data = widget.section["data"] ?? {};

    titleController = TextEditingController(text: data["title"] ?? "");
    bodyController = TextEditingController(text: data["body"] ?? "");

    selectedFont = data["font"] ?? "Poppins";
    fontSize = (data["fontSize"] ?? 16).toDouble();
  }

  @override
  void dispose() {
    titleController.dispose();
    bodyController.dispose();
    super.dispose();
  }

  void _save() {
    final provider = context.read<InvitationProvider>();

    final updatedSection = {
      ...widget.section,
      "data": {
        "title": titleController.text,
        "body": bodyController.text,
        "font": selectedFont,
        "fontSize": fontSize,
      },
    };

    provider.updateSection(widget.index, updatedSection);
    Navigator.pop(context);
  }

  Future<void> _delete() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Eliminar módulo"),
          content: const Text(
            "¿Estás seguro de que quieres eliminar este módulo? Esta acción no se puede deshacer.",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text("Cancelar"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar texto"),
        actions: [
          IconButton(icon: const Icon(Icons.delete), onPressed: _delete),
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
              const SizedBox(height: 16),
              TextField(
                controller: bodyController,
                decoration: const InputDecoration(labelText: "Contenido"),
                maxLines: 4,
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 24),

              // 🔹 FUENTE
              const Text(
                "Fuente",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),

              DropdownButton<String>(
                value: selectedFont,
                isExpanded: true,
                items: availableFonts.map((font) {
                  return DropdownMenuItem(
                    value: font,
                    child: Text(font, style: TextStyle(fontFamily: font)),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedFont = value!;
                  });
                },
              ),

              const SizedBox(height: 16),

              // 🔹 TAMAÑO
              const Text(
                "Tamaño de texto",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),

              Slider(
                value: fontSize,
                min: 12,
                max: 48,
                divisions: 12,
                label: fontSize.toString(),
                onChanged: (value) {
                  setState(() {
                    fontSize = value;
                  });
                },
              ),

              const SizedBox(height: 24),

              // 🔹 PREVIEW
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      titleController.text,
                      style: TextStyle(
                        fontSize: fontSize + 4,
                        fontWeight: FontWeight.bold,
                        fontFamily: selectedFont,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      bodyController.text,
                      style: TextStyle(
                        fontSize: fontSize,
                        fontFamily: selectedFont,
                      ),
                    ),
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
