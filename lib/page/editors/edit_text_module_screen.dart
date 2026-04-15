import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

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
  double fontSize = 18;
  Color textColor = Colors.black;

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

    fontSize = (data["fontSize"] ?? 18).toDouble().clamp(18.0, 48.0);

    textColor = data["color"] != null
        ? _hexToColor(data["color"])
        : Colors.black;
  }

  // 🎨 HEX → COLOR
  Color _hexToColor(String hex) {
    hex = hex.replaceAll("#", "");
    if (hex.length == 6) hex = "FF$hex";
    return Color(int.parse(hex, radix: 16));
  }

  // 🎨 COLOR → HEX (SIN deprecated)
  String _colorToHex(Color color) {
    final int value = color.toARGB32();
    final hex = value.toRadixString(16).padLeft(8, '0');
    return "#${hex.substring(2).toUpperCase()}";
  }

  // 🎨 COLOR PICKER
  void _pickColor() {
    Color tempColor = textColor;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Seleccionar color"),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: tempColor,
              onColorChanged: (color) => tempColor = color,
              enableAlpha: false,
              displayThumbColor: true,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancelar"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() => textColor = tempColor);
                Navigator.pop(context);
              },
              child: const Text("Seleccionar"),
            ),
          ],
        );
      },
    );
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
        "color": _colorToHex(textColor),
      },
    };

    provider.updateSection(widget.index, updatedSection);
    Navigator.pop(context);
  }

  // ❌ ELIMINAR
  Future<void> _delete() async {
    final provider = context.read<InvitationProvider>();

    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Eliminar módulo"),
          content: const Text(
            "¿Seguro que quieres eliminar este módulo? Esta acción no se puede deshacer.",
          ),
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
        );
      },
    );

    if (confirm == true) {
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

              const SizedBox(height: 16),

              TextField(
                controller: bodyController,
                decoration: const InputDecoration(labelText: "Contenido"),
                maxLines: 4,
                onChanged: (_) => setState(() {}),
              ),

              const SizedBox(height: 16),

              const Text(
                "Fuente",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),

              DropdownButton<String>(
                value: selectedFont,
                isExpanded: true,
                items: availableFonts
                    .map(
                      (font) =>
                          DropdownMenuItem(value: font, child: Text(font)),
                    )
                    .toList(),
                onChanged: (v) => setState(() => selectedFont = v!),
              ),

              const SizedBox(height: 16),

              const Text(
                "Tamaño",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),

              Slider(
                value: fontSize,
                min: 18,
                max: 48,
                divisions: 15,
                label: fontSize.toStringAsFixed(0),
                onChanged: (v) => setState(() => fontSize = v),
              ),

              const SizedBox(height: 16),

              const Text(
                "Color",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 8),

              Row(
                children: [
                  GestureDetector(
                    onTap: _pickColor,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: textColor,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.black26),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text("Seleccionar color"),
                ],
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      titleController.text,
                      style: TextStyle(
                        fontSize: fontSize + 4,
                        fontWeight: FontWeight.bold,
                        fontFamily: selectedFont,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      bodyController.text,
                      style: TextStyle(
                        fontSize: fontSize,
                        fontFamily: selectedFont,
                        color: textColor,
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
