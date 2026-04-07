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

  // 💾 GUARDAR
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

  // ❌ ELIMINAR
  void _delete() {
    final provider = context.read<InvitationProvider>();
    provider.removeSection(widget.index);
    Navigator.pop(context);
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
              // 🔹 INPUTS
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

              // 🔹 SELECTOR DE FUENTE
              const Text(
                "Fuente",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),

              DropdownButton<String>(
                value: selectedFont,
                isExpanded: true,
                items: const [
                  DropdownMenuItem(value: "Poppins", child: Text("Poppins")),
                  DropdownMenuItem(value: "Roboto", child: Text("Roboto")),
                  DropdownMenuItem(value: "Lobster", child: Text("Lobster")),
                ],
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
                max: 32,
                divisions: 10,
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
